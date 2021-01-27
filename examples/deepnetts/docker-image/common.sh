#!/bin/bash

#
# Copyright 2019, 2020, 2021 Mani Sarkar
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

gitClone() {
	REPO_URL=$1
	BRANCH=${2:-master}
	REPO_FOLDER=$(echo "${REPO_URL}" | awk '{split($0,a,"/"); print a[5]}')
	if [ -e "${REPO_FOLDER}" ]; then
		echo "${REPO_FOLDER} already exists, aborting process, remove folder manually to perform a fresh download/update"
	else
		git clone --depth=1 --branch ${BRANCH} ${REPO_URL}
	fi
}

downloadArtifact() {
	URL=$1
	ARTIFACT=${2}
	ARTIFACT_FOLDER=${3}

	if [ -e "${ARTIFACT_FOLDER}" ]; then
		echo "${ARTIFACT_FOLDER} already exists, aborting process, remove folder manually to perform a fresh download/update"
	else
		if [[ -e "${ARTIFACT}" ]]; then
			echo "${ARTIFACT} already exists, skipping to next step..."
		else
			curl -O -L -J "${URL}"
		fi

		if [[ -z "$(echo ${ARTIFACT} | grep zip)" ]]; then
			if [[ -z "$(echo ${ARTIFACT} | grep 'tar.gz|tgz')" ]]; then
				tar -xvzf ${ARTIFACT}
			else
				echo 'File format unrecognised, aborting...'
				exit -1
			fi
		else
			unzip -u ${ARTIFACT}
		fi

		rm -f ${ARTIFACT}
	fi
}