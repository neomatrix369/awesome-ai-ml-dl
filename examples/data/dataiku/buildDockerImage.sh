#!/bin/bash

set -e
set -u
set -o pipefail

DSS_VERSION=${DSS_VERSION:-5.1.4}
GRAALVM_VERSION=${GRAALVM_VERSION:-19.1.0}
USER=dataiku

if [[ -z ${DOCKER_USER_NAME:-""} ]]; then
  read -p "Docker username (must exist on Docker Hub): " DOCKER_USER_NAME
fi

IMAGE_NAME=${IMAGE_NAME:-dataiku-dss}
IMAGE_VERSION=${IMAGE_VERSION:-${DSS_VERSION}}
DSS_DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

echo "* Fetching docker image ${DSS_DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION} from Docker Hub"
time docker pull ${DSS_DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION} || true
time docker build -t ${DSS_DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION} \
                  --build-arg DSS_VERSION=${DSS_VERSION}          \
                  --build-arg USER=${USER}                        \
                  --build-arg WORKDIR=/home/${USER}               \
                  --build-arg GRAALVM_VERSION=${GRAALVM_VERSION}  \
                  .