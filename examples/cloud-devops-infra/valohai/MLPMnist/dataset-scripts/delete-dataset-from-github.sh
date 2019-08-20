#!/bin/bash

set -e
set -u
set -o pipefail

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ -z ${DOCKER_USER_NAME:-""} ]]; then
  read -p "Docker username (must exist on Docker Hub): " DOCKER_USER_NAME
fi

TARGET_REPO="${DOCKER_USER_NAME}/awesome-ai-ml-dl"
RELEASE_VERSION="0.1"
TAG_NAME="mnist-dataset-v${RELEASE_VERSION}"

if [[ -z ${MY_GITHUB_TOKEN} ]]; then
  echo "MY_GITHUB_TOKEN cannot be found in the current environment, please populate to proceed either in the startup bash script of your OS or in the environment variable settings of your CI/CD interface."
  exit -1
fi

echo ""
echo "~~~~ Fetching Release ID for ${TAG_NAME}"
mkdir -p ${CURRENT_DIR}/artifacts
CURL_OUTPUT="${CURRENT_DIR}/artifacts/github-release.listing"
curl \
    -H "Authorization: token ${MY_GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github.v3+json" \
    -X GET "https://api.github.com/repos/${TARGET_REPO}/releases/tags/${TAG_NAME}" |
    tee ${CURL_OUTPUT}
RELEASE_ID=$(cat ${CURL_OUTPUT} | grep id | head -n 1 | tr -d " " | tr "," ":" | cut -d ":" -f 2)

echo ""
echo "~~~~ Deleting release with ID ${RELEASE_ID} linked to ${TAG_NAME}"
curl \
    -H "Authorization: token ${MY_GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github.v3+json" \
    -X DELETE "https://api.github.com/repos/${TARGET_REPO}/releases/${RELEASE_ID}"

echo ""
echo "~~~~ Deleting reference refs/tags/${TAG_NAME}"
curl \
    -H "Authorization: token ${MY_GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github.v3+json" \
    -X DELETE  "https://api.github.com/repos/${TARGET_REPO}/git/refs/tags/${TAG_NAME}"