#!/bin/bash

set -e
set -u
set -o pipefail

GRAKN_VERSION=${GRAKN_VERSION:-1.5.7}
GRAALVM_VERSION=${GRAALVM_VERSION:-19.1.0}

if [[ -z ${DOCKER_USER_NAME:-""} ]]; then
  read -p "Docker username (must exist on Docker Hub): " DOCKER_USER_NAME
fi

IMAGE_NAME=${IMAGE_NAME:-grakn}
IMAGE_VERSION=${IMAGE_VERSION:-${GRAKN_VERSION}}
GRAKN_DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

echo "* Fetching docker image ${GRAKN_DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION} from Docker Hub"
time docker pull ${GRAKN_DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION} || true
time docker build -t ${GRAKN_DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION} \
                  --build-arg GRAKN_VERSION=${GRAKN_VERSION} \
                  --build-arg GRAALVM_VERSION=${GRAALVM_VERSION} \
                  .