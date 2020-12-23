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
GRAALVM_VERSION=${GRAALVM_VERSION:-$(cat graalvm_version.txt)}
GRAALVM_JDK_VERSION=${GRAALVM_JDK_VERSION:-$(cat graalvm_jdk_version.txt)}
USER=dataiku

if [[ -z ${DOCKER_USER_NAME:-""} ]]; then
  read -p "Docker username (must exist on Docker Hub): " DOCKER_USER_NAME
fi

IMAGE_NAME=${IMAGE_NAME:-dataiku-dss}
IMAGE_VERSION=${IMAGE_VERSION:-${DSS_VERSION}}
DSS_DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

echo "* Fetching docker image ${DSS_DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION} from Docker Hub"
time docker pull ${DSS_DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION} || true
time docker build -t ${DSS_DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION}        \
                  --build-arg DSS_VERSION=${DSS_VERSION}                 \
                  --build-arg USER=${USER}                               \
                  --build-arg WORKDIR=/home/${USER}                      \
                  --build-arg GRAALVM_VERSION=${GRAALVM_VERSION}         \
                  --build-arg GRAALVM_JDK_VERSION=${GRAALVM_JDK_VERSION} \
                  .