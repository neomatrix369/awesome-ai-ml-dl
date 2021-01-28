#!/bin/bash

set -e
set -u
set -o pipefail

IMAGE_NAME=${IMAGE_NAME:-zeppelin}
IMAGE_VERSION=${IMAGE_VERSION:-$(cat version.txt)}
GRAALVM_VERSION=${GRAALVM_VERSION:-$(cat graalvm_version.txt)}
GRAALVM_JDK_VERSION=${GRAALVM_JDK_VERSION:-$(cat graalvm_jdk_version.txt)}

DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

if [[ ${IMAGE_VERSION} = "0.1" ]]; then
	time docker build                                    \
             -t ${DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION} \
             -f Zeppelin-Dockerfile .
else
    time docker build                                               \
             -t ${DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION}            \
             --build-arg ZEPPELIN_VERSION=0.8.1                     \
             --build-arg SPARK_VERSION=2.4.4                        \
             --build-arg IMAGE_VERSION=${IMAGE_VERSION}             \
             --build-arg GRAALVM_VERSION=${GRAALVM_VERSION}         \
             --build-arg GRAALVM_JDK_VERSION=${GRAALVM_JDK_VERSION} \
             -f Zeppelin-Dockerfile .
fi

./removeUnusedContainersAndImages.sh
./push-apache-zeppelin-docker-image-to-hub.sh