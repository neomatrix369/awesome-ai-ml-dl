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

export DEBUG="${DEBUG:-false}"

SCRIPT_CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOCKER_DEBUG_PARAMS="--detach --interactive --tty"

if [[ "${DEBUG}" == "true" ]]; then
    DOCKER_DEBUG_PARAMS="--interactive --tty --entrypoint /bin/bash --volume ${SCRIPT_CURRENT_DIR}:/debug-repo"
    echo "*************************"
    echo "* Running in Debug mode *"
    echo "*************************"
fi

[ ! ${PWD}/notebooks ] && mkdir -p ${PWD}/notebooks

IMAGE_NAME=${IMAGE_NAME:-jupyter-java}
IMAGE_VERSION=${IMAGE_VERSION:-$(cat version.txt)}

if [[ -z ${DOCKER_USER_NAME:-""} ]]; then
  echo "DOCKER_USER_NAME not defined as an environment variable, set to default value: neomatrix369"
  DOCKER_USER_NAME=neomatrix369
fi

DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

getOpenCommand() {
  if [[ "$(uname)" = "Linux" ]]; then
     echo "xdg-open"
  elif [[ "$(uname)" = "Darwin" ]]; then
     echo "open"
  fi
}

if [[ "${DEBUG}" = "false" ]]; then
  echo ""
  echo "**********************************"
  echo "Running container in detached mode"
  echo "**********************************"
fi

set -x
#--rm 
docker run                                           \
        ${DOCKER_DEBUG_PARAMS}                            \
        --volume ${PWD}/notebooks:/home/jupyter/notebooks \
        -p 8888:8888                                      \
        ${DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION}
set +x

if [[ "${DEBUG}" = "false" ]]; then
  CONTAINER_ID=$(docker ps | grep "8888->8888" | awk '{print $1}' || true)

  sleep 3

  echo ""; echo "Displaying the missed log messages for container ${CONTAINER_ID}"
  docker logs ${CONTAINER_ID}
  echo ""; echo "Scanning logs of container ${CONTAINER_ID} for Jupyter notebook url"
  RAW_URL="$(docker logs ${CONTAINER_ID} | grep -v "NotebookApp" | grep -v "LabApp" | grep "token=" || true)"
  echo ""; echo "Found some URL, extracting real url from it..."
  URL=$(echo ${RAW_URL} | awk '{print $3}' | tr -d ')' || true)
  URL="http://${URL}"
  echo ""; echo "Opening Jupyter Notebook in a browser:"
  echo " ${URL}"
  OPEN_CMD="$(getOpenCommand)"
  "${OPEN_CMD}" "${URL}"

  echo ""; 
  echo "****************************************************"
  echo "Attaching back to container, with ID ${CONTAINER_ID}"
  echo "****************************************************"
  echo ""; echo "You can terminate your Jupyter session with a Ctrl-C"
  echo "";
  docker attach ${CONTAINER_ID}
fi