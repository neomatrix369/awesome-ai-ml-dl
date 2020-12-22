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

IMAGE_NAME=${IMAGE_NAME:-jupyter-java}
IMAGE_VERSION=${IMAGE_VERSION:-$(cat ../version.txt)}
GRAALVM_VERSION=${GRAALVM_VERSION:-$(cat graalvm_version.txt)}
GRAALVM_JDK_VERSION=${GRAALVM_JDK_VERSION:-$(cat graalvm_jdk_version.txt)}

if [[ -z ${DOCKER_USER_NAME:-""} ]]; then
  echo "DOCKER_USER_NAME not defined as an environment variable, set to default value: neomatrix369"
  DOCKER_USER_NAME=neomatrix369
fi

DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"
USER=jupyter
JUPYTER_HOME=/home/${USER}

time docker build \
                 --build-arg USER=jupyter                               \
                 --build-arg WORKDIR=${JUPYTER_HOME}                    \
	             --build-arg IMAGE_VERSION=${IMAGE_VERSION}             \
                 --build-arg GRAALVM_VERSION=${GRAALVM_VERSION}         \
                 --build-arg GRAALVM_JDK_VERSION=${GRAALVM_JDK_VERSION} \
                 -t ${DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION}            \
                 .

./removeUnusedContainersAndImages.sh
./push-jupyter-java-docker-image-to-hub.sh