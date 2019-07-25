#!/bin/bash

set -e
set -u
set -o pipefail

language_id=${1:-java}
NLP_JAVA_VERSION=${NLP_JAVA_VERSION:-$(cat images/${language_id}/version.txt)}
GRAALVM_VERSION=${GRAALVM_VERSION:-19.1.1}

DOCKER_USER_NAME=${DOCKER_USER_NAME:-"neomatrix369"}

IMAGE_NAME=${IMAGE_NAME:-nlp-java}
IMAGE_VERSION=${IMAGE_VERSION:-${NLP_JAVA_VERSION}}
DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

WORKDIR=/home/nlp-java

CUSTOM_ENTRY_POINT=""
RUN_PERFORMANCE_SCRIPT=${RUN_PERFORMANCE_SCRIPT:-false}
if [[ "${DEBUG:-}" = "true" ]]; then
   CUSTOM_ENTRY_POINT="${CUSTOM_ENTRY_POINT:-} --entrypoint /bin/bash"
fi

INTERACTIVE_MODE="--interactive --tty"
TIME_IT="time"
if [[ "${DETACHED_MODE:-}" = "true" ]]; then
    INTERACTIVE_MODE="--detach"
    TIME_IT=""
fi

set -x
${TIME_IT} docker run --rm                                      \
                ${INTERACTIVE_MODE}                             \
                --workdir ${WORKDIR}                            \
                --env JDK_TO_USE=${JDK_TO_USE:-}                \
                --volume $(pwd)/shared:${WORKDIR}/shared        \
                ${CUSTOM_ENTRY_POINT}                           \
                ${DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION}
set +x