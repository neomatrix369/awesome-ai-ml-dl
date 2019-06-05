#!/bin/bash

set -e
set -u
set -o pipefail

IMAGE_NAME=${IMAGE_NAME:-zeppelin}
IMAGE_VERSION=${IMAGE_VERSION:-$(cat version.txt)}
DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

docker run --rm \
           -it  \
           -p 8888:8888 \
           ${DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION}