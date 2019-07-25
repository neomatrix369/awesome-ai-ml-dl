#!/bin/bash

set -e
set -u
set -o pipefail

if [[ -z ${DOCKER_USER_NAME:-""} ]]; then
  read -p "Docker username (must exist on Docker Hub): " DOCKER_USER_NAME
fi

IMAGE_NAME=${IMAGE_NAME:-nlp-java}
IMAGE_VERSION=${IMAGE_VERSION:-$(cat version.txt)}
DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"
GRAALVM_VERSION="${GRAALVM_VERSION:-19.1.1}"

echo "* Fetching docker image ${DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION} from Docker Hub"
time docker pull ${DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION} || true
time docker build \
             --build-arg GRAALVM_VERSION="${GRAALVM_VERSION}" \
             -t ${DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION} .