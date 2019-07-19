#!/bin/bash

set -e
set -u
set -o pipefail

GRAKN_VERSION=${GRAKN_VERSION:-1.5.7}

DOCKER_USER_NAME=${DOCKER_USER_NAME:-"neomatrix369"}

IMAGE_NAME=${IMAGE_NAME:-grakn}
IMAGE_VERSION=${IMAGE_VERSION:-${GRAKN_VERSION}}
GRAKN_DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

EXPOSED_PORT=${EXPOSED_PORT:-4567}

WORKDIR=/grakn

CUSTOM_ENTRY_POINT=""
RUN_PERFORMANCE_SCRIPT=${RUN_PERFORMANCE_SCRIPT:-false}
if [[ "${DEBUG:-}" = "true" ]]; then
   CUSTOM_ENTRY_POINT="${CUSTOM_ENTRY_POINT:-} --entrypoint /bin/bash"
fi

if [[ "${RUN_PERFORMANCE_SCRIPT}" = "true" ]]; then
   CUSTOM_ENTRY_POINT="${CUSTOM_ENTRY_POINT:-} --entrypoint ${WORKDIR}/runPerformanceBenchmark.sh"
fi

INTERACTIVE_MODE="--interactive --tty"
TIME_IT="time"
if [[ "${DETACHED_MODE:-}" = "true" ]]; then
    INTERACTIVE_MODE="--detach"
    TIME_IT=""
fi

mkdir -p shared
mkdir -p .cache/bazel

set -x
${TIME_IT} docker run --rm                                      \
                ${INTERACTIVE_MODE}                             \
                --volume $(pwd)/shared:${WORKDIR}/shared        \
                --volume $(pwd)/.cache/bazel:/root/.cache/bazel \
                -p ${EXPOSED_PORT}:4567                         \
                --workdir ${WORKDIR}                            \
                --env JDK_TO_USE=${JDK_TO_USE:-}                \
                --env COMMON_JAVAOPTS=${COMMON_JAVAOPTS:-}      \
                ${CUSTOM_ENTRY_POINT}                           \
                ${GRAKN_DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION}
set +x