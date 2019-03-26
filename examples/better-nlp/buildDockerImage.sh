#!/bin/bash

set -e
set -u
set -o pipefail

if [[ -z ${DOCKER_USER_NAME:-""} ]]; then
  read -p "Docker username (must exist on Docker Hub): " DOCKER_USER_NAME
fi

IMAGE_NAME=${IMAGE_NAME:-better-nlp}
IMAGE_VERSION=${IMAGE_VERSION:-0.1}
BETTER_NLP_DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

time docker build -t ${BETTER_NLP_DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION} .