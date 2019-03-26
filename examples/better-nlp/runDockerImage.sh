#!/bin/bash

set -e
set -u
set -o pipefail

DOCKER_USER_NAME=${DOCKER_USER_NAME:-"neomatrix369"}

IMAGE_NAME=${IMAGE_NAME:-better-nlp}
IMAGE_VERSION=${IMAGE_VERSION:-0.1}
BETTER_NLP_DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

WORKDIR=better-nlp

time docker run --rm                        \
                --interactive --tty         \
                --volume $(pwd):/better-nlp \
                --workdir /${WORKDIR}       \
                --entrypoint /bin/bash      \
                ${BETTER_NLP_DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION}