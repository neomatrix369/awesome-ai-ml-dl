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

detectOSPlatform() {
	OSNAME=$(uname)

	if [[ "${OSNAME}" = "Darwin" ]]; then
	 	OSNAME=macos
	elif [[ "${OSNAME}" = "Linux" ]]; then
		OSNAME=linux
	fi

	echo ${OSNAME}
}

MAVEN_VERSION=${MAVEN_VERSION:-"3.6.1"}
MAVEN_ARTIFACT="apache-maven-${MAVEN_VERSION}-bin.tar.gz"
CURRENT_DIR="$(cd "$(dirname "$0")" && pwd)"

downloadMavenArchive() {
	if [[ ! -e "${CURRENT_DIR}/${MAVEN_ARTIFACT}"  ]]; then
		echo "~~~ Downloading Apache Maven ${MAVEN_VERSION}"
		curl  -O -J -L \
			http://mirror.vorboss.net/apache/maven/maven-3/${MAVEN_VERSION}/binaries/${MAVEN_ARTIFACT}
	fi	
}

unpackMavenArchive() {
	TARGET=$1
	M2_HOME="${TARGET}/apache-maven-${MAVEN_VERSION}"
	if [[ ! -e "${M2_HOME}" ]]; then
		echo "~~~ Unpacking Apache Maven ${MAVEN_VERSION} into ${TARGET}"
		mkdir -p ${M2_HOME}
		tar -xvzf ${CURRENT_DIR}/${MAVEN_ARTIFACT} -C ${TARGET}
	fi	
}

downloadMavenArchive
unpackMavenArchive ${MAVEN_TARGET_DIR}

update-alternatives --install "/usr/bin/mvn" "mvn" "${MAVEN_TARGET_DIR}/apache-maven-${MAVEN_VERSION}/bin/mvn" 0
update-alternatives --set mvn ${MAVEN_TARGET_DIR}/apache-maven-${MAVEN_VERSION}/bin/mvn

mvn --version