#!/bin/bash

set -e
set -u
set -o pipefail

if [[ -z ${DOCKER_USER_NAME:-""} ]]; then
  read -p "Docker username (must exist on Docker Hub): " DOCKER_USER_NAME
fi

findImage() {
	IMAGE_NAME=$1
	echo $(docker images ${IMAGE_NAME} -q | head -n1 || true)
}

pushImage() {
    language_id=$1
    IMAGE_NAME="nlp-${2:-${language_id}}"
    IMAGE_VERSION=$(cat images/${language_id}/version.txt)
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