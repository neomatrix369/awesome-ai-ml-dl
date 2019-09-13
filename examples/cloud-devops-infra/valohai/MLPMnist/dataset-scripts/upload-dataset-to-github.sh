#
# Copyright 2019 Mani Sarkar
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#!/bin/bash

set -e
set -u
set -o pipefail

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

function uploadAsset() {
    local releaseId=$1
    local assetName=$2
    local releaseArtifact="${assetName}"
    echo "~~~~ Uploading asset to ReleaseId ${releaseId}, name=${assetName}"
    curl \
        -H "Authorization: token ${MY_GITHUB_TOKEN}" \
        -H "Content-Type: application/zip" \
        -H "Accept: application/vnd.github.v3+json" \
        --data-binary @${releaseArtifact} \
         "https://uploads.github.com/repos/${TARGET_REPO}/releases/${releaseId}/assets?name=${assetName}"
}

function releaseDatasetArtifacts() {
    POST_DATA=$(printf '{
    "tag_name": "%s",
    "target_commitish": "master",
    "name": "%s",
    "body": "Release %s",
    "draft": false,
    "prerelease": false
  }' ${TAG_NAME} ${TAG_NAME} ${TAG_NAME})
  echo "~~~~ Creating release ${RELEASE_VERSION}: $POST_DATA"
  curl \
      -H "Authorization: token ${MY_GITHUB_TOKEN}" \
      -H "Content-Type: application/json" \
      -H "Accept: application/vnd.github.v3+json" \
      -X POST -d "${POST_DATA}" "https://api.github.com/repos/${TARGET_REPO}/releases"

  mkdir -p ${CURRENT_DIR}/artifacts
  CURL_OUTPUT="${CURRENT_DIR}/artifacts/github-release.listing"
  echo "~~~~ Getting Github ReleaseId"
  curl \
      -H "Authorization: token ${MY_GITHUB_TOKEN}" \
      -H "Accept: application/vnd.github.v3+json" \
      -X GET "https://api.github.com/repos/${TARGET_REPO}/releases/tags/${TAG_NAME}" |
      tee ${CURL_OUTPUT}
  RELEASE_ID=$(cat ${CURL_OUTPUT} | grep id | head -n 1 | tr -d " " | tr "," ":" | cut -d ":" -f 2)

  TARGET_ARCHIVE_FILE="${1:-mlp-mnist-dataset.tgz}"

  if [[ -z "${TARGET_ARCHIVE_FILE:-}" ]]; then
    echo ""
    echo "Please specify the dataset archive to upload as parameter"
    echo "Usage:"
    echo "   $0 [archive]"
    echo ""
    exit -1
  fi

  uploadAsset ${RELEASE_ID} "${TARGET_ARCHIVE_FILE}"

  echo "~~~~ Finished uploading to GitHub"
  echo ""
  echo "~~~~ Checkout curl output at ${CURL_OUTPUT}"
  echo ""
  echo "Use curl -O -L [github release url] to download this artifacts."
  echo "    for e.g."
  echo "        curl -J -O -L https://github.com/${TARGET_REPO}/releases/download/${TAG_NAME}/${TARGET_ARCHIVE_FILE}"
}


if [[ -z ${DOCKER_USER_NAME:-""} ]]; then
  read -p "Docker username (must exist on Docker Hub): " DOCKER_USER_NAME
fi

TARGET_REPO="${DOCKER_USER_NAME}/awesome-ai-ml-dl"

if [[ -z ${MY_GITHUB_TOKEN} ]]; then
  echo "MY_GITHUB_TOKEN cannot be found in the current environment, please populate to proceed either in the startup bash script of your OS or in the environment variable settings of your CI/CD interface."
  exit -1
fi

RELEASE_VERSION="0.1"
TAG_NAME="mnist-dataset-v${RELEASE_VERSION}"

echo "Current TAG_NAME=${TAG_NAME}"
echo ""
echo "~~~~ Uploading dataset archive"
releaseDatasetArtifacts ${1:-}