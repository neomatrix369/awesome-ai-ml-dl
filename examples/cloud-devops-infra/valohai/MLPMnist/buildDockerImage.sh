#!/bin/bash

set -e
set -u
set -o pipefail

IMAGE_NAME=${IMAGE_NAME:-dl4j-mnist-single-layer}
IMAGE_VERSION=${IMAGE_VERSION:-$(cat version.txt)}
DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

cp -rf $HOME/.deeplearning4j .
cp target/MLPMnist-1.0.0-bin.jar MLPMnist-1.0.0.jar

time docker build                                            \
                 --build-arg WORKDIR=/workspace              \
                 -t ${DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION} \
                 .

rm -rf .deeplearning4j
rm -f MLPMnist-1.0.0.jar