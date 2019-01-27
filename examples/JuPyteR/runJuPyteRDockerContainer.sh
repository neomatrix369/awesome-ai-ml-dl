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

docker run --rm                   \
           ${DOCKER_DEBUG_PARAMS} \
           -p 8888:8888 jupyter           