#!/bin/bash

set -e
set -u
set -o pipefail

IMAGE_NAME=${IMAGE_NAME:-zeppelin}
IMAGE_VERSION=${IMAGE_VERSION:-$(cat version.txt)}
DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

if [[ ${IMAGE_VERSION} = "0.1" ]]; then
	time docker build                                    \
             -t ${DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION} \
             -f Zeppelin-Dockerfile .
else
	time docker build                                    \
             -t ${DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION} \
             --build-arg ZEPPELIN_VERSION=0.8.1          \
             --build-arg SPARK_VERSION=2.4.4             \
             --build-arg GRAALVM_VERSION=19.2.0.1        \
             -f Zeppelin-Dockerfile .
fi

./removeUnusedContainersAndImages.sh