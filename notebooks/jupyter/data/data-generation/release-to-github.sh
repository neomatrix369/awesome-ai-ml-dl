#!/bin/bash

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

set -e
set -u
set -o pipefail

TARGET_REPO="neomatrix369/awesome-ai-ml-dl"

if [[ -z ${GITHUB_TOKEN} ]]; then
  echo "GITHUB_TOKEN cannot be found in the current environment, please populate to proceed."
  exit 0
fi

RELEASE_VERSION="0.1"
TAG_NAME="v${RELEASE_VERSION}"
POST_DATA=$(printf '{
  "tag_name": "%s",
  "target_commitish": "master",
  "name": "%s",
  "body": "Release %s",
  "draft": false,
  "prerelease": false
}' ${TAG_NAME} ${TAG_NAME} ${TAG_NAME})
echo "Creating release ${RELEASE_VERSION}: $POST_DATA"
curl \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    -H "Content-Type: application/json" \
    -H "Accept: application/vnd.github.v3+json" \
    -X POST -d "${POST_DATA}" "https://api.github.com/repos/${TARGET_REPO}/releases"

mkdir -p artifacts
CURL_OUTPUT="./artifacts/github-release.listing"
echo "Getting Github ReleaseId"
curl \
    -H "Authorization: token ${GITHUB_TOKEN}" \
    -H "Accept: application/vnd.github.v3+json" \
    -X GET "https://api.github.com/repos/${TARGET_REPO}/releases/tags/${TAG_NAME}" |
    tee ${CURL_OUTPUT}
RELEASE_ID=$(cat ${CURL_OUTPUT} | grep id | head -n 1 | tr -d " " | tr "," ":" | cut -d ":" -f 2)

function uploadAsset() {
    local releaseId=$1
    local assetName=$2
    local releaseArtifact="${assetName}"
    echo "Uploading asset to ReleaseId ${releaseId}, name=${assetName}"
    curl \
        -H "Authorization: token ${GITHUB_TOKEN}" \
        -H "Content-Type: application/zip" \
        -H "Accept: application/vnd.github.v3+json" \
        --data-binary @${releaseArtifact} \
         "https://uploads.github.com/repos/${TARGET_REPO}/releases/${releaseId}/assets?name=${assetName}"
}

UPLOAD_ARTIFACT=$1
uploadAsset ${RELEASE_ID} ${UPLOAD_ARTIFACT}

echo "Finished uploading to GitHub"
echo ""
echo "Checkout curl output at ${CURL_OUTPUT}"
echo ""
echo "Use curl -O -L [github release url] to download this artifacts."
echo "    for e.g."
echo "        curl -O -L https://github.com/neomatrix369/awesome-ai-ml-dl/releases/download/${TAG_NAME}/${UPLOAD_ARTIFACT}"