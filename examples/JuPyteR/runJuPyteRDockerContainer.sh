#!/bin/bash

set -e
set -u
set -o pipefail

export DEBUG="${DEBUG:-}"

SCRIPT_CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOCKER_DEBUG_PARAMS="--interactive --tty"

if [[ "${DEBUG}" == "true" ]]; then
    DOCKER_DEBUG_PARAMS="--interactive --tty --entrypoint /bin/bash --volume ${SCRIPT_CURRENT_DIR}:/debug-repo"
    echo "*************************"
    echo "* Running in Debug mode *"
    echo "*************************"
fi

[ ! ${PWD}/jupyter/notebooks ] && mkdir -p ${PWD}/jupyter/notebooks

IMAGE_NAME=${IMAGE_NAME:-jupyter-java}
IMAGE_VERSION=${IMAGE_VERSION:-$(cat version.txt)}

if [[ -z ${DOCKER_USER_NAME:-""} ]]; then
  echo "DOCKER_USER_NAME not defined as an environment variable, set to default value: neomatrix369"
  DOCKER_USER_NAME=neomatrix369
fi

DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

docker run --rm                                                  \
           ${DOCKER_DEBUG_PARAMS}                                \
           --volume ${PWD}/jupyter/notebooks:/jupyter-notebooks  \
           -p 8888:8888                                          \
           ${DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION}	