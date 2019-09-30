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
  echo "DOCKER_USER_NAME not defined as an environment variable, set to default value: neomatrix369"
  DOCKER_USER_NAME=neomatrix369
fi

findImage() {
	IMAGE_NAME=$1
	echo $(docker images ${IMAGE_NAME} -q | head -n1 || true)
}

pushImage() {
    language_id=$1
    IMAGE_NAME=${IMAGE_NAME:-jupyter-java}
    IMAGE_VERSION=$(cat ../version.txt)
    DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

    IMAGE_FOUND="$(findImage ${DOCKER_FULL_TAG_NAME})"
    IS_FOUND="found"
    if [[ -z "${IMAGE_FOUND}" ]]; then
        IS_FOUND="not found"        
    fi
    echo "Docker image '${DOCKER_USER_NAME}/${IMAGE_NAME}' is ${IS_FOUND} in the local repository"

    docker tag ${IMAGE_FOUND} ${DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION}
    docker push ${DOCKER_FULL_TAG_NAME}
}

docker login --username=${DOCKER_USER_NAME}
pushImage base java-base
pushImage ${1:-java}