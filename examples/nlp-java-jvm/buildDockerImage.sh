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

if [[ -z ${DOCKER_USER_NAME:-""} ]]; then
  read -p "Docker username (must exist on Docker Hub): " DOCKER_USER_NAME
fi


SCRIPT_CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
IMAGES_DIR="${SCRIPT_CURRENT_DIR}/images"

### Build base image
BASE_IMAGE_NAME=${BASE_IMAGE_NAME:-nlp-java-base}
BASE_IMAGE_VERSION=${BASE_IMAGE_VERSION:-$(cat images/base/version.txt)}
BASE_DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${BASE_IMAGE_NAME}"
GRAALVM_VERSION="${GRAALVM_VERSION:-19.1.1}"

echo "* Fetching NLP base docker image ${BASE_DOCKER_FULL_TAG_NAME}:${BASE_IMAGE_VERSION} from Docker Hub"
time docker pull ${BASE_DOCKER_FULL_TAG_NAME}:${BASE_IMAGE_VERSION} || true
time docker build                                                  \
             --build-arg GRAALVM_VERSION="${GRAALVM_VERSION}"      \
             --build-arg JAVA_8_HOME="/opt/java/openjdk"           \
             --build-arg GRAALVM_HOME="/opt/java/graalvm-ce-${GRAALVM_VERSION}" \
             -t ${BASE_DOCKER_FULL_TAG_NAME}:${BASE_IMAGE_VERSION} \
             "${IMAGES_DIR}/base/."


### Build language specific image
language_id=${1:-java}
IMAGE_NAME=${IMAGE_NAME:-nlp-${language_id}}
IMAGE_VERSION=${IMAGE_VERSION:-$(cat images/${language_id}/version.txt)}
DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

echo "* Fetching NLP ${language_id} docker image ${DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION} from Docker Hub"
time docker pull ${DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION} || true
time docker build                                                                        \
             --build-arg BASE_IMAGE="${BASE_DOCKER_FULL_TAG_NAME}:${BASE_IMAGE_VERSION}" \
             -t ${DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION}                                 \
             "${IMAGES_DIR}/${language_id}/."

./removeUnusedContainersAndImages.sh
./push-nlp-java-docker-image-to-hub.sh ${language_id}