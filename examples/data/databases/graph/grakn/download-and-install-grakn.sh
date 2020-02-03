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

if [[ "${GRAKN_VERSION}" = "1.4.3" ]]; then
	GRAKN_CORE_LINUX=grakn-core
else
	GRAKN_CORE_LINUX=grakn-core-all-linux
fi

ARTIFACT_FILENAME=${GRAKN_CORE_LINUX}-${GRAKN_VERSION}

if [[ "${GRAKN_VERSION}" = "1.4.3" ]]; then
	ARTIFACT_FILENAME_WITH_EXT=${ARTIFACT_FILENAME}.zip
else
	ARTIFACT_FILENAME_WITH_EXT=${ARTIFACT_FILENAME}.tar.gz
fi

ARTIFACT_URL=https://github.com/graknlabs/grakn/releases/download/${GRAKN_VERSION}/${ARTIFACT_FILENAME_WITH_EXT}

echo "Downloading artifact from url: ${ARTIFACT_URL}"
wget  ${ARTIFACT_URL} \
     --progress=bar:force 2>&1 | tail -f -n +3

if [[ "${GRAKN_VERSION}" = "1.4.3" ]]; then
	echo "unzipping artifact: ${ARTIFACT_FILENAME_WITH_EXT}"
	unzip ${ARTIFACT_FILENAME_WITH_EXT} | pv -l >/dev/null
else
	echo "Untarring artifact: ${ARTIFACT_FILENAME_WITH_EXT}"
	tar zxvf ${ARTIFACT_FILENAME_WITH_EXT} | pv -l >/dev/null
fi

echo "Removing artifact: ${ARTIFACT_FILENAME_WITH_EXT}"
rm ${ARTIFACT_FILENAME_WITH_EXT}

echo "Checking version"
./${ARTIFACT_FILENAME}/grakn version