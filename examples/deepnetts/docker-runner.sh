#!/bin/bash

#
# Copyright 2019, 2020, 2021 Mani Sarkar
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e
set -u
set -o pipefail

findImage() {
	IMAGE_NAME=$1
	echo $(docker images ${IMAGE_NAME} -q | head -n1 || true)
}

getOpenCommand() {
  if [[ "$(uname)" = "Linux" ]]; then
     echo "xdg-open"
  elif [[ "$(uname)" = "Darwin" ]]; then
     echo "open"
  fi
}

openNotebookInBrowser() {
	echo "**********************************"
	echo "Running container in detached mode"
	echo "**********************************"

	CONTAINER_ID=$(docker ps | grep "${HOST_PORT}->${CONTAINER_PORT}" | awk '{print $1}' || true)

	sleep 7

	echo ""; echo "Displaying the missed log messages for container ${CONTAINER_ID}"
	docker logs ${CONTAINER_ID}

	URL="$(docker logs ${CONTAINER_ID} | grep ${CONTAINER_PORT}'/?token' | grep ' or http' | grep -v 'NotebookApp' | awk '{print $2}' || true)"
	URL="${URL:-https://localhost:${HOST_PORT}}"
	URL=${URL/${CONTAINER_PORT}/${HOST_PORT}}

	echo ""; echo "********************************************************************************************************"
	echo ""; echo "Opening Jupyter Notebook in a browser:"; echo "";
	echo " ${URL}"
	echo ""; echo "";
	echo "********************************************************************************************************"; echo "";

	OPEN_CMD="$(getOpenCommand)"
	"${OPEN_CMD}" "${URL}"
	
	docker exec ${CONTAINER_ID} \
	       /bin/bash -c         \
	       "echo JAVA_HOME=${JAVA_HOME}; echo PATH=${PATH}; echo JDK_TO_USE=${JDK_TO_USE}; java -version"
	echo "";
	echo "****************************************************"
	echo "Attaching back to container, with ID ${CONTAINER_ID}"
	echo ""
	echo "Use below command to connect to the running container via a new session/shell:"
	echo "                docker exec -it ${CONTAINER_ID} /bin/bash"
    echo ""
	echo "The example Deepnetts note books can be found in the deepnetts/notebooks folder"
	echo ""
	echo "****************************************************"
	echo ""; echo "You can terminate your Jupyter session with a Ctrl-C"
	echo "";
	docker attach ${CONTAINER_ID}
}

runContainer() {
	askDockerUserNameIfAbsent
	setVariables

	if [[ "${NOTEBOOK_MODE}" = "true" ]]; then
		## When run in the notebook mode (command-prompt NOT available)
		TOGGLE_ENTRYPOINT=""; ### Disable the ENTRYPOINT & CMD directives
		VOLUMES_SHARED="--volume "$(pwd)/shared/notebooks":${WORKDIR}/work --volume "$(pwd)"/shared:${WORKDIR}/shared";

		INTERACTIVE_MODE="--detach ${INTERACTIVE_MODE}"
	else
		## When run in the console mode (command-prompt available)
		TOGGLE_ENTRYPOINT="--entrypoint /bin/bash"
		VOLUMES_SHARED="--volume "$(pwd)":${WORKDIR}/work --volume "$(pwd)"/shared:${WORKDIR}/shared"
	fi

	echo "";
	echo "Running container ${FULL_DOCKER_TAG_NAME}:${IMAGE_VERSION}"; echo ""

	mkdir -p shared/notebooks

	pullImage deepnetts
	${TIME_IT} docker run                                      \
	            --rm                                           \
                ${INTERACTIVE_MODE}                            \
                ${TOGGLE_ENTRYPOINT}                           \
                -p ${HOST_PORT}:${CONTAINER_PORT}              \
                --workdir ${WORKDIR}                           \
                --env JDK_TO_USE=${JDK_TO_USE:-}               \
                --env JAVA_OPTS=${JAVA_OPTS:-}                 \
                ${VOLUMES_SHARED}                              \
                "${FULL_DOCKER_TAG_NAME}:${IMAGE_VERSION}"

    if [[ "${NOTEBOOK_MODE}" = "true" ]] && [[ "${OPEN_NOTEBOOK}" = "true" ]]; then
	  openNotebookInBrowser
    fi
}

buildImage() {
	askDockerUserNameIfAbsent
	setVariables
	
	echo "Building image ${FULL_DOCKER_TAG_NAME}:${IMAGE_VERSION}"; echo ""

	echo "* Fetching Deepnetts docker image ${FULL_DOCKER_TAG_NAME}:${IMAGE_VERSION} from Docker Hub"
	time docker pull ${FULL_DOCKER_TAG_NAME}:${IMAGE_VERSION} || true
	time docker build                                                   \
	             --build-arg WORKDIR=${WORKDIR}                         \
	             --build-arg JAVA_11_HOME="/opt/java/openjdk"           \
	             --build-arg GRAALVM_HOME="/opt/java/graalvm"           \
	             --build-arg IMAGE_VERSION=${IMAGE_VERSION}             \
	             --build-arg DEEPNETTS_VERSION=${DEEPNETTS_VERSION}           \
                 --build-arg GRAALVM_VERSION=${GRAALVM_VERSION}         \
                 --build-arg GRAALVM_JDK_VERSION=${GRAALVM_JDK_VERSION} \
	             -t ${FULL_DOCKER_TAG_NAME}:${IMAGE_VERSION} \
	             "${IMAGES_DIR}/."
	echo "* Finished building Deepnetts docker image ${FULL_DOCKER_TAG_NAME}:${IMAGE_VERSION}"
	
	cleanup
	pushImageToHub
	cleanup
}

pushImage() {
	IMAGE_NAME="deepnetts"
	IMAGE_VERSION=$(cat docker-image/version.txt)
	FULL_DOCKER_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

	IMAGE_FOUND="$(findImage ${FULL_DOCKER_TAG_NAME})"
	IS_FOUND="found"
	if [[ -z "${IMAGE_FOUND}" ]]; then
		IS_FOUND="not found"        
	fi
	echo "Docker image '${DOCKER_USER_NAME}/${IMAGE_NAME}' is ${IS_FOUND} in the local repository"

	docker tag ${IMAGE_FOUND} ${FULL_DOCKER_TAG_NAME}:${IMAGE_VERSION}
	docker push ${FULL_DOCKER_TAG_NAME}
}

pullImage() {
	IMAGE_NAME="deepnetts"
	IMAGE_VERSION=$(cat docker-image/version.txt)
	FULL_DOCKER_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"
	
	docker pull ${FULL_DOCKER_TAG_NAME}:${IMAGE_VERSION} || true
}


pushImageToHub() {
	askDockerUserNameIfAbsent
	setVariables

	echo "Pushing image ${FULL_DOCKER_TAG_NAME}:${IMAGE_VERSION} to Docker Hub"; echo ""

	docker login --username=${DOCKER_USER_NAME}
	pushImage deepnetts
}

pullImageFromHub() {
	askDockerUserNameIfAbsent
	setVariables

	echo "Pulling image ${FULL_DOCKER_TAG_NAME}:${IMAGE_VERSION} from Docker Hub"; echo ""

	pullImage deepnetts
}


cleanup() {
	containersToRemove=$(docker ps --quiet --filter "status=exited")
	[ ! -z "${containersToRemove}" ] && \
	    echo "Remove any stopped container from the local registry" && \
	    docker rm ${containersToRemove} || true

	imagesToRemove=$(docker images --quiet --filter "dangling=true")
	[ ! -z "${imagesToRemove}" ] && \
	    echo "Remove any dangling images from the local registry" && \
	    docker rmi -f ${imagesToRemove} || true
}

showUsageText() {
    cat << HEREDOC

       Usage: $0 --dockerUserName [Docker user name]
                                 --detach
                                 --jdk [GRAALVM]
                                 --javaopts [java opt arguments]
                                 --hostport [1024-65535]
                                 --notebookMode
                                 --doNotOpenNotebook
                                 --cleanup
                                 --buildImage
                                 --runContainer
                                 --pushImageToHub
                                 --pullImageFromHub								 
                                 --help

       --dockerUserName      your Docker user name as on Docker Hub
                             (mandatory with build, run and push commands)
       --detach              run container and detach from it,
                             return control to console
       --jdk                 name of the JDK to use (currently supports
                             GRAALVM only, default is blank which
                             enables the traditional JDK)
       --javaopts            sets the JAVA_OPTS environment variable
                             inside the container as it starts
       --hostport            specify an available port between 0 and 65535,
                             handy when running multiple Jupyter sessions.
                             (default: 8888)
       --notebookMode        runs the Jupyter/Jupyhai notebook server
                             (default: opens the page in a browser)
       --doNotOpenNotebook   when used with --notebookMode, suppresses 
                             the opening of the notebook action
       --cleanup             (command action) remove exited containers and
                             dangling images from the local repository
       --buildImage          (command action) build the docker image
       --runContainer        (command action) run the docker image as a docker container
       --pushImageToHub      (command action) push the docker image built to Docker Hub
       --pullImageFromHub    (command action) pull the latest docker image from Docker Hub	   
       --help                shows the script usage help text

HEREDOC

	exit 1
}

askDockerUserNameIfAbsent() {
	if [[ -z ${DOCKER_USER_NAME:-""} ]]; then
	  read -p "Enter Docker username (must exist on Docker Hub): " DOCKER_USER_NAME
	fi	
}

setVariables() {
	IMAGE_NAME=${IMAGE_NAME:-deepnetts}
	IMAGE_VERSION=${IMAGE_VERSION:-$(cat docker-image/version.txt)}
	DEEPNETTS_VERSION=${DEEPNETTS_VERSION:-$(cat docker-image/deepnetts_version.txt)}
	GRAALVM_VERSION=${GRAALVM_VERSION:-$(cat docker-image/graalvm_version.txt)}
	GRAALVM_JDK_VERSION=${GRAALVM_JDK_VERSION:-$(cat docker-image/graalvm_jdk_version.txt)}
	FULL_DOCKER_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"
}

#### Start of script
SCRIPT_CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IMAGES_DIR="${SCRIPT_CURRENT_DIR}/docker-image"

FULL_DOCKER_TAG_NAME=""
DOCKER_USER_NAME="${DOCKER_USER_NAME:-neomatrix369}"

WORKDIR=/home/jovyan
JDK_TO_USE="GRAALVM"  ### we are defaulting to GraalVM

INTERACTIVE_MODE="--interactive --tty"
TIME_IT="time"

NOTEBOOK_MODE=false
OPEN_NOTEBOOK=true
HOST_PORT=8888
CONTAINER_PORT=8888

if [[ "$#" -eq 0 ]]; then
	echo "No parameter has been passed. Please see usage below:"
	showUsageText
fi

while [[ "$#" -gt 0 ]]; do case $1 in
  --help)                showUsageText;
                         exit 0;;
  --cleanup)             cleanup;
                         exit 0;;
  --dockerUserName)      DOCKER_USER_NAME="${2:-}";
                         shift;;
  --detach)              INTERACTIVE_MODE="--detach";
                         TIME_IT="";;
  --jdk)                 JDK_TO_USE="${2:-}";
                         shift;;
  --javaopts)            JAVA_OPTS="${2:-}";
                         shift;;
  --hostport)            HOST_PORT=${2:-${HOST_PORT}};
                         shift;;
  --notebookMode)        NOTEBOOK_MODE=true;;
  --doNotOpenNotebook)   OPEN_NOTEBOOK=false;;
  --buildImage)          buildImage;
                         exit 0;;
  --runContainer)        runContainer;
                         exit 0;;
  --pushImageToHub)      pushImageToHub;
                         exit 0;;
  --pullImageFromHub)    pullImageFromHub;
                         exit 0;;
  *) echo "Unknown parameter passed: $1";
     showUsageText;
esac; shift; done

if [[ "$#" -eq 0 ]]; then
	echo "No command action passed in as parameter. Please see usage below:"
	showUsageText
fi