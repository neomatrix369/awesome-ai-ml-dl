#!/bin/bash

#
# Copyright 2019, 2020 Mani Sarkar
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

DSS_VERSION=${DSS_VERSION:-5.1.4}

DOCKER_USER_NAME=${DOCKER_USER_NAME:-"neomatrix369"}

IMAGE_NAME=${IMAGE_NAME:-dataiku-dss}
IMAGE_VERSION=${IMAGE_VERSION:-${DSS_VERSION}}
DSS_DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

EXPOSED_PORT=${EXPOSED_PORT:-10000}

WORKDIR=/home/dataiku

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
${TIME_IT} docker run --rm                                             \
                ${INTERACTIVE_MODE}                                    \
                -p ${EXPOSED_PORT}:10000                               \
                --workdir ${WORKDIR}                                   \
                --env JDK_TO_USE=${JDK_TO_USE:-}                       \
                --env DSS_VERSION=${DSS_VERSION}                       \
                --env JAVA_OPTS=${JAVA_OPTS:-}                         \
                --env DSS_PORT=10000                                   \
                --env HOME=${WORKDIR}                                  \
                --env DSS_DATADIR=${WORKDIR}/dss                       \
                --user dataiku                                         \
                ${CUSTOM_ENTRY_POINT}                                  \
                ${DSS_DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION}
set +x