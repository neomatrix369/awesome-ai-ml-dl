TARGET_REPO="neomatrix369/awesome-ai-ml-dl"

if [[ -z ${GITHUB_TOKEN} ]]; then
  echo "GITHUB_TOKEN cannot be found in the current environment, please populate to proceed."
  exit 0
fi

TAG_NAME="v0.1"
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

uploadAsset ${RELEASE_ID} ${1:-boston_housing_dataset.zip}

echo "Finished uploading to GitHub"
echo ""
echo "Checkout curl output at ${CURL_OUTPUT}"
echo ""
echo "Use curl -O -L [github release url] to download this artifacts."
echo "    for e.g."
echo "        curl -O -L https://github.com/neomatrix369/awesome-ai-ml-dl/releases/download/v0.1/boston_housing_dataset.zip"