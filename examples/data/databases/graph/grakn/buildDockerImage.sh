#!/bin/bash

set -e
set -u
set -o pipefail

GRAKN_VERSION=${GRAKN_VERSION:-1.4.3}

if [[ -z "${USER_NAME:-''}" ]]; then
  read -p "Docker username (must exist on Docker Hub): " USER_NAME
fi

IMAGE_NAME=${IMAGE_NAME:-grakn}
IMAGE_VERSION=${IMAGE_VERSION:-${GRAKN_VERSION}}
GRAKN_DOCKER_FULL_TAG_NAME="${USER_NAME}/${IMAGE_NAME}"

time docker build -t ${GRAKN_DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION} .