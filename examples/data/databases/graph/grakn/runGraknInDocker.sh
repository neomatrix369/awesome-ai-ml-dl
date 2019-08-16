#!/bin/bash

set -e
set -u
set -o pipefail

GRAKN_VERSION=${GRAKN_VERSION:-1.5.7}

DOCKER_USER_NAME=${DOCKER_USER_NAME:-"neomatrix369"}

IMAGE_NAME=${IMAGE_NAME:-grakn}
IMAGE_VERSION=${IMAGE_VERSION:-${GRAKN_VERSION}}
GRAKN_DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

WORKDIR=/home/grakn

CUSTOM_ENTRY_POINT=""
RUN_PERFORMANCE_SCRIPT=${RUN_PERFORMANCE_SCRIPT:-false}
if [[ "${DEBUG:-}" = "true" ]]; then
   CUSTOM_ENTRY_POINT="${CUSTOM_ENTRY_POINT:-} --entrypoint /bin/bash"
else
    if [[ "${RUN_PERFORMANCE_SCRIPT}" = "true" ]]; then
       CUSTOM_ENTRY_POINT="${CUSTOM_ENTRY_POINT:-} --entrypoint ${WORKDIR}/runPerformanceBenchmark.sh"
    fi
fi

INTERACTIVE_MODE="--interactive --tty"
TIME_IT="time"
if [[ "${DETACHED_MODE:-}" = "true" ]]; then
    INTERACTIVE_MODE="--detach"
    TIME_IT=""
fi

JAVA8_HOME="/usr/local/openjdk-8/"
JDK_SPECIFIC_ENV_VALUES="--env JAVA_HOME=${JAVA8_HOME}"

if [[ "${JDK_TO_USE:-}" = "GRAALVM" ]]; then
    GRAALVM_HOME="/usr/local/graalvm-ce-19.1.1"
    COMMON_JAVAOPTS="${COMMON_JAVAOPTS:-'-XX:+UseJVMCINativeLibrary'}"
    GRAKN_DAEMON_JAVAOPTS=$(echo "${COMMON_JAVAOPTS} ${GRAKN_DAEMON_JAVAOPTS:-}" | xargs)
    STORAGE_JAVAOPTS=$(echo "${COMMON_JAVAOPTS} ${STORAGE_JAVAOPTS:-}" | xargs)
    SERVER_JAVAOPTS=$(echo "${COMMON_JAVAOPTS} ${SERVER_JAVAOPTS:-}"  | xargs)

    JDK_SPECIFIC_ENV_VALUES=$(cat <<EOF
           --env GRAALVM_HOME=${GRAALVM_HOME}
           --env JAVA_HOME=${GRAALVM_HOME}
           --env GRAKN_DAEMON_JAVAOPTS=${GRAKN_DAEMON_JAVAOPTS}
           --env STORAGE_JAVAOPTS=${STORAGE_JAVAOPTS}
           --env SERVER_JAVAOPTS=${SERVER_JAVAOPTS}
EOF
           )
fi

mkdir -p shared
mkdir -p .cache/bazel

set -x
${TIME_IT} docker run --rm                                           \
                ${INTERACTIVE_MODE}                                  \
                --volume $(pwd)/shared:${WORKDIR}/shared             \
                --volume $(pwd)/.cache/bazel:$(pwd)/.cache/bazel     \
                --workdir ${WORKDIR}                                 \
                --env JDK_TO_USE=${JDK_TO_USE:-}                     \
                ${JDK_SPECIFIC_ENV_VALUES}                           \
                ${CUSTOM_ENTRY_POINT}                                \
                ${GRAKN_DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION}
set +x