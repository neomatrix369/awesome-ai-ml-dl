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

source ../common.sh

printPing() {
	MAX_LIMIT=${1-"100"}
	i=$((0))
	while [ $i -le ${MAX_LIMIT} ]
	do
		## do nothing
		i=$((i + 1))
	done
	echo -n "."
}

runContainer() {
	JDK_TO_USE=${1:-}
	JDK_TO_USE_STRING=${2:-}
	JAVA_OPTS=${3:-""}
	
	echo ""; echo "~~~ Running Grakn in a Docker container using the ${JDK_TO_USE_STRING}"; echo ""

	GRAKN_CONTAINER_ID=$(cd .. &&  
		GRAKN_VERSION=${GRAKN_VERSION} GRAALVM_VERSION=${GRAALVM_VERSION} 
		     ./grakn-runner.sh --jdk "${JDK_TO_USE}" --javaopts "${JAVA_OPTS}" --detach --runContainer)
	GRAKN_CONTAINER_ID=$(echo ${GRAKN_CONTAINER_ID} | tr -d '\n')
	GRAKN_CONTAINER_ID=${GRAKN_CONTAINER_ID:0:7}

	if [[ -z "${GRAKN_CONTAINER_ID}" ]]; then
		echo "${JDK_TO_USE}: Grakn in the container has not started yet"
		exit 0
	fi

	echo ""; echo "${JDK_TO_USE}: Grakn in the container is now starting (id = ${GRAKN_CONTAINER_ID})"
	docker logs -f "${GRAKN_CONTAINER_ID}"

	echo ""; echo "${JDK_TO_USE}: Shutting down Grakn in the container (id = ${GRAKN_CONTAINER_ID})"
	echo "${JDK_TO_USE}: Grakn in the container (id = ${GRAKN_CONTAINER_ID}) has been shutdown."; echo "";
}

GRAKN_VERSION="${GRAKN_VERSION:-$(cat ../grakn_version.txt)}"
GRAALVM_VERSION="${GRAALVM_VERSION:-$(cat ../graalvm_version.txt)}"
GRAALVM_JDK_VERSION="${GRAALVM_JDK_VERSION:-}"
if [[ "$(isVersionGreaterThanOrEqualTo "${GRAALVM_VERSION}" "19.3.0")" = "true" ]]; then
   GRAALVM_JDK_VERSION="${GRAALVM_JDK_VERSION:-$(cat ../graalvm_jdk_version.txt || true)}"
fi

time runContainer "Traditional-JDK" "Traditional JDK (version 1.8) Grakn version ${GRAKN_VERSION}" ""

time runContainer "GRAALVM" "GraalVM CE ${GRAALVM_JDK_VERSION} (version ${GRAALVM_VERSION}), JVMCI disabled, Grakn version ${GRAKN_VERSION}" "-XX:-UseJVMCINativeLibrary"

time runContainer "GRAALVM" "GraalVM CE ${GRAALVM_JDK_VERSION} (version ${GRAALVM_VERSION}), JVMCI enabled, Grakn version ${GRAKN_VERSION}" "-XX:+UseJVMCINativeLibrary"