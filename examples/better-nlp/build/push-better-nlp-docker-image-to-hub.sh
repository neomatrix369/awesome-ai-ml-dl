#!/bin/bash

set -e
set -u
set -o pipefail

if [[ -z ${DOCKER_USER_NAME:-""} ]]; then
  read -p "Docker username (must exist on Docker Hub): " DOCKER_USER_NAME
fi

IMAGE_NAME=${IMAGE_NAME:-better-nlp}
IMAGE_VERSION=${IMAGE_VERSION:-$(cat ../version.txt)}
BETTER_NLP_DOCKER_FULL_TAG_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"

findImage() {
	IMAGE_NAME=$1
	echo $(docker images ${IMAGE_NAME} -q | head -n1 || true)
}

IMAGE_FOUND="$(findImage ${DOCKER_USER_NAME}/${IMAGE_NAME})"
if [[ -z "${IMAGE_FOUND}" ]]; then
    echo "Docker image '${DOCKER_USER_NAME}/${IMAGE_NAME}' not found in the local repository"
    IMAGE_FOUND="$(findImage ${IMAGE_NAME})"
    if [[ -z "${IMAGE_FOUND}" ]]; then
    	echo "Docker image '${IMAGE_NAME}' not found in the local repository"
    	exit 1
    else 
    	echo "Docker image '${IMAGE_NAME}' found in the local repository"
    fi
else
    echo "Docker image '${DOCKER_USER_NAME}/${IMAGE_NAME}' found in the local repository"
fi

docker tag ${IMAGE_FOUND} ${BETTER_NLP_DOCKER_FULL_TAG_NAME}:${IMAGE_VERSION}
docker login --username=${DOCKER_USER_NAME}
docker push ${BETTER_NLP_DOCKER_FULL_TAG_NAME}