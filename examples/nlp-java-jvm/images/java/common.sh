#!/bin/bash

set -e
set -u
set -o pipefail

gitClone() {
	REPO_URL=$1
	REPO_FOLDER=$(echo "${REPO_URL}" | awk '{split($0,a,"/"); print a[5]}')
	if [ -e "${REPO_FOLDER}" ]; then
		echo "${REPO_FOLDER} already exists, aborting process, remove folder manually to perform a fresh download/update"
	else
		git clone --depth=1 ${REPO_URL}
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