#!/bin/bash

set -e
set -u
set -o pipefail

if [[ -z ${DOCKER_USER_NAME:-""} ]]; then
  echo "DOCKER_USER_NAME not defined as an environment variable, set to default value: neomatrix369"
  DOCKER_USER_NAME=neomatrix369
fi

findImage() {
	IMAGE_NAME=$1
	echo $(docker images ${IMAGE_NAME} -q | head -n1 || true)
}

pushImage() {
    language_id=$1
    IMAGE_NAME=${IMAGE_NAME:-jupyter-java}
    IMAGE_VERSION=$(cat ../version.txt)
    DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

    IMAGE_FOUND="$(findImage ${DOCKER_FULL_TAG_NAME})"
    IS_FOUND="found"
    if [[ -z "${IMAGE_FOUND}" ]]; then
        IS_FOUND="not found"        
    fi
    echo "Docker image '${DOCKER_USER_NAME}/${IMAGE_NAME}' is ${IS_FOUND} in the local repository"

    docker tag ${IMAGE_FOUND} ${DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION}
    docker push ${DOCKER_FULL_TAG_NAME}
}

docker login --username=${DOCKER_USER_NAME}
pushImage base java-base
pushImage ${1:-java}