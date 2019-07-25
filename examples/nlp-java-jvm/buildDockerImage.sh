#!/bin/bash

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
             -t ${BASE_DOCKER_FULL_TAG_NAME}:${BASE_IMAGE_VERSION} \
             "${IMAGES_DIR}/base/."


### Build language specific image
language_id=${1:-java}
IMAGE_NAME=${IMAGE_NAME:-nlp-java}
IMAGE_VERSION=${IMAGE_VERSION:-$(cat images/${language_id}/version.txt)}
DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

echo "* Fetching NLP ${language_id} docker image ${DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION} from Docker Hub"
time docker pull ${DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION} || true
time docker build                                                                        \
             --build-arg BASE_IMAGE="${BASE_DOCKER_FULL_TAG_NAME}:${BASE_IMAGE_VERSION}" \
             -t ${DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION}                                 \
             "${IMAGES_DIR}/${language_id}/."