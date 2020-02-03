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

source common.sh

TARGET_GRAALVM_HOME=graalvm-ce-${GRAALVM_VERSION}
GRAALVM_ARTIFACT_FILENAME=graalvm-ce-linux-amd64-${GRAALVM_VERSION}
ARTIFACT_GITHUB_REPO=oracle/graal

if [[ $(isVersionGreaterThanOrEqualTo "${GRAALVM_VERSION}" "19.3.0") ]]; then
	TARGET_GRAALVM_HOME=graalvm-ce-${GRAALVM_JDK_VERSION}-${GRAALVM_VERSION}
	GRAALVM_ARTIFACT_FILENAME=graalvm-ce-${GRAALVM_JDK_VERSION}-linux-amd64-${GRAALVM_VERSION}
	ARTIFACT_GITHUB_REPO=graalvm/graalvm-ce-builds
fi

GRAALVM_ARTIFACT="${GRAALVM_ARTIFACT_FILENAME}.tar.gz"
ARTIFACT_URL=https://github.com/${ARTIFACT_GITHUB_REPO}/releases/download/vm-${GRAALVM_VERSION}/${GRAALVM_ARTIFACT}

echo "Downloading artifact from url: ${ARTIFACT_URL}"
wget  ${ARTIFACT_URL} \
     --progress=bar:force 2>&1 | tail -f -n +3

echo "Untarring artifact: ${GRAALVM_ARTIFACT}"
tar xvzf ${GRAALVM_ARTIFACT} -C /usr/local | pv -l >/dev/null

GRAALVM_HOME="/usr/local/${TARGET_GRAALVM_HOME}"
echo "GRAALVM_HOME=${GRAALVM_HOME}"

echo "Removing artifact: ${GRAALVM_ARTIFACT}"
rm ${GRAALVM_ARTIFACT}
rm -fr ${GRAALVM_ARTIFACT_FILENAME}

echo "Downloading native-image"
${GRAALVM_HOME}/bin/gu install native-image

echo "Checking version"
${GRAALVM_HOME}/bin/java -version

echo "JAVA_HOME=${JAVA_HOME}"
echo "PATH=${PATH}"