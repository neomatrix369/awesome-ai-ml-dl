#!/bin/bash

#
# Copyright 2019 Mani Sarkar
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


SCRIPT_CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "${SCRIPT_CURRENT_DIR}/common.sh"

findImage() {
	IMAGE_NAME=$1
  IMAGE_VERSION=$2
  echo $(docker images --filter=reference="${IMAGE_NAME}:${IMAGE_VERSION}" \
       | grep -v "REPOSITORY" || true)
}

getOpenCommand() {
  if [[ "$(uname)" = "Linux" ]]; then
     echo "xdg-open"
  elif [[ "$(uname)" = "Darwin" ]]; then
     echo "open"
  fi
}

runContainer() {
	askDockerUserNameIfAbsent

	echo "";
  if [[ "${INTERACTIVE_MODE}" != "--detach" ]]; then
    if [[ "$(uname)" = "Linux" ]]; then
       echo "Linux: Unfortunately mounting and writing to local volumes is currently not available - should be fixed soon. This should work on the MacOS." 
    fi

	   echo "Running container ${FULL_DOCKER_REPO_NAME}:${IMAGE_VERSION}"; echo ""
  fi

  mkdir -p shared
  mkdir -p shared/grakn-${GRAKN_VERSION}-logs
  mkdir -p shared/grakn-${GRAKN_VERSION}-db/cassandra
  mkdir -p .cache/bazel

  set -x
  ${TIME_IT} docker run --rm                                       \
                ${INTERACTIVE_MODE}                                \
                --workdir ${WORKDIR}                               \
                --user=grakn                                       \
                ${TOGGLE_ENTRYPOINT}                               \
                -p ${HOST_PORT}:${CONTAINER_PORT}                  \
                -p ${DASHBOARD_HOST_PORT}:${DASHBOARD_CONTAINER_PORT}\
                --env SHARED_FOLDER_PATH="${SHARED_FOLDER_PATH:-}" \
                --env JDK_TO_USE="${JDK_TO_USE:-}"                 \
                --env JAVA_OPTS="${JAVA_OPTS:-}"                   \
                --env RUN_GRAKN_ONLY="${RUN_GRAKN_ONLY:-}"         \
                --env GRAKN_HOME=${GRAKN_HOME}                     \
                ${GRAKN_LOGS_VOLUME}                               \
                ${CASSANDRA_DATA_STORE_VOLUME}                     \
                ${JDK_SPECIFIC_ENV_VALUES}                         \
                ${VOLUMES_SHARED}                                  \
                ${FULL_DOCKER_REPO_NAME}:${IMAGE_VERSION}
  set +x
}

buildDockerImage() {
	askDockerUserNameIfAbsent
	
	echo "Building image ${FULL_DOCKER_REPO_NAME}:${IMAGE_VERSION}"
 
  ### Grakn installation
  GRAKN_ARTIFACT_NAME_WITH_EXT=${GRAKN_ARTIFACT_FILENAME}.zip
  GRAKN_UNPACK_COMMAND="unzip ${GRAKN_ARTIFACT_NAME_WITH_EXT}"
  if [[ "$(isVersionGreaterThanOrEqualTo "${GRAKN_VERSION}" "1.5.2")" = "true" ]]; then
    GRAKN_ARTIFACT_NAME_WITH_EXT=${GRAKN_ARTIFACT_FILENAME}.tar.gz
    GRAKN_UNPACK_COMMAND="tar zxvf ${GRAKN_ARTIFACT_NAME_WITH_EXT}"
  fi

  GRAKN_ARTIFACT_URL="https://github.com/graknlabs/grakn/releases/download/${GRAKN_VERSION}/${GRAKN_ARTIFACT_NAME_WITH_EXT}"

  ### GraalVM installation
  if [[ "$(isVersionGreaterThanOrEqualTo "${GRAALVM_VERSION}" "19.3.0")" = "true" ]]; then
    echo "GRAALVM_VERSION=${GRAALVM_VERSION} (GRAALVM_JDK_VERSION=${GRAALVM_JDK_VERSION}) GRAKN_VERSION=${GRAKN_VERSION}"; echo ""
    TARGET_GRAALVM_HOME=graalvm-ce-${GRAALVM_JDK_VERSION}-${GRAALVM_VERSION}
    GRAALVM_ARTIFACT_FILENAME=graalvm-ce-${GRAALVM_JDK_VERSION}-linux-amd64-${GRAALVM_VERSION}
    GRAALVM_ARTIFACT_GITHUB_REPO=graalvm/graalvm-ce-builds
  else 
    echo "GRAALVM_VERSION=${GRAALVM_VERSION} GRAKN_VERSION=${GRAKN_VERSION}"; echo ""
    TARGET_GRAALVM_HOME=graalvm-ce-${GRAALVM_VERSION}
    GRAALVM_ARTIFACT_FILENAME=graalvm-ce-linux-amd64-${GRAALVM_VERSION}
    GRAALVM_ARTIFACT_GITHUB_REPO=oracle/graal
  fi

  GRAALVM_ARTIFACT="${GRAALVM_ARTIFACT_FILENAME}.tar.gz"
  GRAALVM_ARTIFACT_URL=https://github.com/${GRAALVM_ARTIFACT_GITHUB_REPO}/releases/download/vm-${GRAALVM_VERSION}/${GRAALVM_ARTIFACT}

	echo "* Fetching docker image ${FULL_DOCKER_REPO_NAME}:${IMAGE_VERSION} from Docker Hub"

  if [[ -z "$(findImage ${FULL_DOCKER_REPO_NAME} ${IMAGE_VERSION})" ]]; then
     echo "Docker image '${DOCKER_USER_NAME}/${IMAGE_NAME}:${IMAGE_VERSION}' not found in the local repository, attempting to pull from Docker Hub"
     time docker pull ${FULL_DOCKER_REPO_NAME}:${IMAGE_VERSION} || true
  else 
    echo "Docker image '${DOCKER_USER_NAME}/${IMAGE_NAME}:${IMAGE_VERSION}' found in the local repository"  
  fi
	time docker build                                                                             \
               -t ${FULL_DOCKER_REPO_NAME}:${IMAGE_VERSION}                                     \
	             --build-arg GRAKN_VERSION=${GRAKN_VERSION}                                       \
               --build-arg GRAKN_HOME=${GRAKN_HOME}                                             \
               --build-arg GRAKN_ARTIFACT_NAME_WITH_EXT=${GRAKN_ARTIFACT_NAME_WITH_EXT}         \
               --build-arg GRAKN_ARTIFACT_URL="${GRAKN_ARTIFACT_URL}"                           \
               --build-arg GRAKN_UNPACK_COMMAND="${GRAKN_UNPACK_COMMAND}"                       \
               --build-arg GRAALVM_JDK_VERSION=${GRAALVM_JDK_VERSION}                           \
               --build-arg GRAALVM_VERSION=${GRAALVM_VERSION}                                   \
               --build-arg TARGET_GRAALVM_HOME=${TARGET_GRAALVM_HOME}                           \
               --build-arg GRAALVM_ARTIFACT_FILENAME=${GRAALVM_ARTIFACT_FILENAME}               \
               --build-arg GRAALVM_ARTIFACT=${GRAALVM_ARTIFACT}                                 \
               --build-arg GRAALVM_ARTIFACT_URL=${GRAALVM_ARTIFACT_URL}                         \
               --build-arg DEFAULT_PORT=${HOST_PORT}                                            \
               .
	echo "* Finished building docker image ${FULL_DOCKER_REPO_NAME}:${IMAGE_VERSION} from Docker Hub"
	if [[ "$(isVersionGreaterThanOrEqualTo "${GRAALVM_VERSION}" "19.3.0")" = "true" ]]; then
     echo "GRAALVM_VERSION=${GRAALVM_VERSION} (GRAALVM_JDK_VERSION=${GRAALVM_JDK_VERSION}) GRAKN_VERSION=${GRAKN_VERSION}"; echo ""
  else 
     echo "GRAALVM_VERSION=${GRAALVM_VERSION} GRAKN_VERSION=${GRAKN_VERSION}"; echo ""
  fi

	cleanup
}

pushImageToHub() {
	askDockerUserNameIfAbsent

  IMAGE_FOUND="$(findImage ${FULL_DOCKER_REPO_NAME} ${IMAGE_VERSION})"
  IS_FOUND="found"
  if [[ -z "${IMAGE_FOUND}" ]]; then
      IS_FOUND="not found"        
      echo "Docker image '${DOCKER_USER_NAME}/${IMAGE_NAME}:${IMAGE_VERSION}' is ${IS_FOUND} in the local repository"
      exit 
  fi

  echo "Docker image '${DOCKER_USER_NAME}/${IMAGE_NAME}:${IMAGE_VERSION}' is ${IS_FOUND} in the local repository"
  docker login --username=${DOCKER_USER_NAME}
  echo "Pushing image ${FULL_DOCKER_REPO_NAME}:${IMAGE_VERSION} to Docker Hub"; echo ""
  docker push ${FULL_DOCKER_REPO_NAME}:${IMAGE_VERSION}
}

cleanup() {
	containersToRemove=$(docker ps --quiet --filter "status=exited")
	[ ! -z "${containersToRemove}" ] &&                                \
	    echo "Remove any stopped container from the local registry" && \
	    docker rm ${containersToRemove} || (true && echo "No docker processes to clean up")

	imagesToRemove=$(docker images --quiet --filter "dangling=true")
	[ ! -z "${imagesToRemove}" ] &&                                    \
	    echo "Remove any dangling images from the local registry" &&   \
	    docker rmi -f ${imagesToRemove} || (true && echo "No docker images to clean up")
}

showUsageText() {
    cat << HEREDOC

       Usage: $0 --dockerUserName [Docker user name]
                                 --detach
                                 --debug
                                 --run-perf-scripts
                                 --jdk [GRAALVM]
                                 --javaopts [java opt arguments]
                                 --cleanup
                                 --buildDockerImage
                                 --runContainer
                                 --pushImageToHub
                                 --help

       --dockerUserName      your Docker user name as on Docker Hub
                             (mandatory with build, run and push commands)
       --detach              run container and detach from it,
                             return control to console
       --debug               run docker container in interactive mode 
                             (gives command-prompt to run commands inside the container)
       --run-perf-scripts    run performance script in interactive mode (can take a long time)
       --run-grakn-only      run the Grakn docker container in interacive mode
                             but do not start the Graql console, just the Grakn server
       --jdk                 name of the JDK to use (currently supports
                             GRAALVM only, default is blank which
                             enables the traditional JDK)
       --javaopts            sets the JAVA_OPTS environment variable
                             inside the container as it starts
       --cleanup             (command action) remove exited containers and
                             dangling images from the local repository
       --buildDockerImage    (command action) build the docker image
       --runContainer        (command action) run the docker image as a docker container,
                             container will run without this command with selected and 
                             default params, in most cases
       --pushImageToHub      (command action) push the docker image built to Docker Hub
       --help                shows the script usage help text

HEREDOC

	exit 1
}

askDockerUserNameIfAbsent() {
	if [[ -z ${DOCKER_USER_NAME:-""} ]]; then
	  read -p "Enter Docker username (must exist on Docker Hub): " DOCKER_USER_NAME
	fi	
}

#### Start of script
INTERACTIVE_MODE="--interactive --tty"
TIME_IT="time"

HOST_PORT=${HOST_PORT:-48555}
CONTAINER_PORT=48555
DASHBOARD_HOST_PORT=${DASHBOARD_HOST_PORT:-4567}
DASHBOARD_CONTAINER_PORT=4567
WORKDIR="/home/grakn"

IMAGES_DIR="${SCRIPT_CURRENT_DIR}/images"

DOCKER_USER_NAME="${DOCKER_USER_NAME:-neomatrix369}"
IMAGE_NAME=${IMAGE_NAME:-grakn}
FULL_DOCKER_REPO_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"      ### Using this field as Repository name of the image (using Docker terms)

GRAKN_VERSION=${GRAKN_VERSION:-$(cat grakn_version.txt)}
GRAALVM_VERSION=${GRAALVM_VERSION:-$(cat graalvm_version.txt)}

GRAALVM_JDK_VERSION="${GRAALVM_JDK_VERSION:-}"
IMAGE_VERSION=${GRAKN_VERSION}-GRAALVM-CE-${GRAALVM_VERSION}   ### Using this field as Tag name of the image (using Docker terms)

if [[ "$(isVersionGreaterThanOrEqualTo "${GRAALVM_VERSION}" "19.3.0")" = "true" ]]; then
  GRAALVM_JDK_VERSION=${GRAALVM_JDK_VERSION:-$(cat graalvm_jdk_version.txt || true)}
  IMAGE_VERSION=${GRAKN_VERSION}-GRAALVM-CE-${GRAALVM_JDK_VERSION}-${GRAALVM_VERSION}
fi

GRAKN_CORE_LINUX=grakn-core
GRAKN_ARTIFACT_FILENAME=${GRAKN_CORE_LINUX}-${GRAKN_VERSION}
if [[ "$(isVersionGreaterThanOrEqualTo "${GRAKN_VERSION}" "1.5.2")" = "true" ]]; then
  GRAKN_CORE_LINUX=grakn-core-all-linux
  GRAKN_ARTIFACT_FILENAME=${GRAKN_CORE_LINUX}-${GRAKN_VERSION}
fi

GRAKN_HOME="${WORKDIR}/${GRAKN_CORE_LINUX}-${GRAKN_VERSION}"

############################################ we are defaulting to GraalVM

JDK_TO_USE="GRAALVM"  
GRAALVM_HOME="/usr/local/graalvm-ce-${GRAALVM_VERSION}"
if [[ "$(isVersionGreaterThanOrEqualTo "${GRAALVM_VERSION}" "19.3.0")" = "true" ]]; then
  GRAALVM_HOME="/usr/local/graalvm-ce-${GRAALVM_JDK_VERSION}-${GRAALVM_VERSION}"
fi

COMMON_JAVAOPTS="${COMMON_JAVAOPTS:-'-XX:+UseJVMCINativeLibrary'}"
GRAKN_DAEMON_JAVAOPTS=$(echo "${COMMON_JAVAOPTS} ${GRAKN_DAEMON_JAVAOPTS:-}" | xargs)
STORAGE_JAVAOPTS=$(echo "${COMMON_JAVAOPTS} ${STORAGE_JAVAOPTS:-}" | xargs)
SERVER_JAVAOPTS=$(echo "${COMMON_JAVAOPTS} ${SERVER_JAVAOPTS:-}"  | xargs)

JDK_SPECIFIC_ENV_VALUES="
       --env GRAALVM_HOME=${GRAALVM_HOME}
       --env JAVA_HOME=${GRAALVM_HOME}
       --env GRAKN_DAEMON_JAVAOPTS=${GRAKN_DAEMON_JAVAOPTS}
       --env STORAGE_JAVAOPTS=${STORAGE_JAVAOPTS}
       --env SERVER_JAVAOPTS=${SERVER_JAVAOPTS}"

###########################################################################

JAVA8_HOME="/usr/local/openjdk-8/"

## When run in the console mode (command-prompt available)
TOGGLE_ENTRYPOINT=""
SHARED_FOLDER_PATH="${WORKDIR}/shared"

VOLUMES_SHARED="--volume "$(pwd)"/shared:${SHARED_FOLDER_PATH} --volume $(pwd)/.cache/bazel:$(pwd)/.cache/bazel"
CASSANDRA_DATA_STORE_VOLUME="--volume $(pwd)/shared/grakn-${GRAKN_VERSION}-db/cassandra:${GRAKN_HOME}/server/db/cassandra"
GRAKN_LOGS_VOLUME="--volume $(pwd)/shared/grakn-${GRAKN_VERSION}-logs:${GRAKN_HOME}/logs"

if [[ "$(uname)" = "Linux" ]]; then
  VOLUMES_SHARED=""
  CASSANDRA_DATA_STORE_VOLUME=""
  GRAKN_LOGS_VOLUME=""
fi

RUN_GRAKN_ONLY=false

if [[ "$#" -eq 0 ]]; then
  if [[ "${INTERACTIVE_MODE}" != "--detach" ]]; then
     echo "No parameter has been passed. Running Grakn docker container with selected and default params."
  fi  
	runContainer
  exit 0
fi

while [[ "$#" -gt 0 ]]; do case $1 in
  --help)                showUsageText;
                         exit 0;;
  --cleanup)             cleanup;
                         exit 0;; 
  --dockerUserName)      DOCKER_USER_NAME="${2:-}";
                         shift;;
  --port)                HOST_PORT="${2:-${HOST_PORT}}";
                         CONTAINER_PORT="${2:-${CONTAINER_PORT}}";
                         shift;;
  --debug)               TOGGLE_ENTRYPOINT="--entrypoint /bin/bash";
                         ;;
  --run-perf-scripts)    TOGGLE_ENTRYPOINT="--entrypoint ${WORKDIR}/runPerformanceBenchmark.sh";
                         echo "Running performance scripts inside the container when it starts off"
                         ;;
  --run-grakn-only)      RUN_GRAKN_ONLY=true; 
                         echo "Running Grakn server only (not running Graql) when container starts."
                         ;;
  --detach)              INTERACTIVE_MODE="--detach";
                         TIME_IT="";
                         ;;
  --jdk)                 JDK_TO_USE="${2:-}"; JDK_TO_USE="$(echo ${JDK_TO_USE} | tr '[:lower:]' '[:upper:]')"; ### Capitalise our input
            						 if [[ "${JDK_TO_USE:-}" != "GRAALVM" ]]; then
                            JDK_SPECIFIC_ENV_VALUES="--env JAVA_HOME=${JAVA8_HOME}"
                            GRAKN_DAEMON_JAVAOPTS=$(echo "${COMMON_JAVAOPTS} ${GRAKN_DAEMON_JAVAOPTS:-}" | xargs)
                            STORAGE_JAVAOPTS=$(echo "${COMMON_JAVAOPTS} ${STORAGE_JAVAOPTS:-}" | xargs)
                            SERVER_JAVAOPTS=$(echo "${COMMON_JAVAOPTS} ${SERVER_JAVAOPTS:-}"  | xargs)
            						 fi 
                         shift;;
  --javaopts)            JAVA_OPTS="${2:-}";
                         shift;;
  --buildDockerImage)    buildDockerImage;
                         exit 0;;
  --runContainer)        runContainer;
                         exit 0;;
  --pushImageToHub)      pushImageToHub;
                         exit 0;;
  *) echo "Unknown parameter passed: $1";
     showUsageText;
esac; shift; done


if [[ "${INTERACTIVE_MODE}" != "--detach" ]]; then
   echo "No parameter has been passed. Running Grakn docker container with selected and default params."
fi
runContainer