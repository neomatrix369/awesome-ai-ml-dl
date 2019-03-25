#!/bin/bash

set -e
set -u
set -o pipefail

GRAKN_VERSION=${GRAKN_VERSION:-1.4.3}

DOCKER_USER_NAME=${DOCKER_USER_NAME:-"neomatrix369"}

IMAGE_NAME=${IMAGE_NAME:-grakn}
IMAGE_VERSION=${IMAGE_VERSION:-${GRAKN_VERSION}}
GRAKN_DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

WORKDIR=grakn

if [[ "${DEBUG:-}" = "true" ]]; then
   docker run --rm                   \
              --interactive --tty    \
              -p 4567:4567           \
              --workdir /${WORKDIR}  \
              --entrypoint /bin/bash \
              ${GRAKN_DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION}
else
    time docker run --rm                  \
                    --interactive --tty   \
                    -p 4567:4567          \
                    --workdir /${WORKDIR} \
                    ${GRAKN_DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION}
fi