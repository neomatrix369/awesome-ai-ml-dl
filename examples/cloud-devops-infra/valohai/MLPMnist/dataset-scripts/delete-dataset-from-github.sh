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