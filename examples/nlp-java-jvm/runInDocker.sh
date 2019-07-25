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

JAVA_8_HOME="/usr/local/openjdk-8/"
JDK_SPECIFIC_ENV_VALUES="--env JAVA_HOME=${JAVA_8_HOME}"

if [[ "${JDK_TO_USE:-}" = "GRAALVM" ]]; then
    GRAALVM_HOME="/usr/local/graalvm-ce-19.1.1"
    JDK_SPECIFIC_ENV_VALUES="--env GRAALVM_HOME=${GRAALVM_HOME} --env JAVA_HOME=${GRAALVM_HOME}"
fi

set -x
${TIME_IT} docker run --rm                                      \
                ${INTERACTIVE_MODE}                             \
                --workdir ${WORKDIR}                            \
                --env JDK_TO_USE=${JDK_TO_USE:-}                \
                --volume $(pwd)/shared:${WORKDIR}/shared        \
                ${JDK_SPECIFIC_ENV_VALUES}                      \
                ${CUSTOM_ENTRY_POINT}                           \
                ${DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION}
set +x