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

GRAALVM_VERSIONS="19.0.0 19.1.0 19.2.0 19.3.0"
GRAALVM_JDK_VERSIONS="java8" # java11 is not supported by Grakn
GRAKN_VERSIONS="1.4.3 1.5.2 1.5.7 1.6.0 1.6.2"

DOCKER_USER_NAME="${DOCKER_USER_NAME:-neomatrix369}"
IMAGE_NAME=${IMAGE_NAME:-grakn}
FULL_DOCKER_REPO_NAME="${DOCKER_USER_NAME}/${IMAGE_NAME}"      ### Using this field as Repository name of the image (using Docker terms)

for GRAKN_VERSION in ${GRAKN_VERSIONS[@]}
do
	for GRAALVM_VERSION in ${GRAALVM_VERSIONS[@]}
	do
		if [[ "$(isVersionGreaterThanOrEqualTo "${GRAALVM_VERSION}" "19.3.0")" = "true" ]]; then
			for GRAALVM_JDK_VERSION in ${GRAALVM_JDK_VERSIONS[@]}
			do
				set -x
				IMAGE_VERSION=${GRAKN_VERSION}-GRAALVM-CE-${GRAALVM_JDK_VERSION}-${GRAALVM_VERSION}
				docker pull ${FULL_DOCKER_REPO_NAME}:${IMAGE_VERSION} || true				     
				set +x
			done
		else
			set -x
			IMAGE_VERSION=${GRAKN_VERSION}-GRAALVM-CE-${GRAALVM_VERSION}   ### Using this field as Tag name of the image (using Docker terms)			
			docker pull ${FULL_DOCKER_REPO_NAME}:${IMAGE_VERSION} || true
			set +x
        fi
	done
done