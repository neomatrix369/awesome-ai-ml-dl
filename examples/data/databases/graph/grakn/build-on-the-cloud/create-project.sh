#!/bin/bash

set -e
set -u
set -o pipefail

PROJECT_NAME=${1:-}

if [[ -z "${PROJECT_NAME}" ]]; then
	echo "Please specify the project name. Exiting..."
	echo " Usage: "
	echo "        $0 [project name]"
	exit -1
fi

vh --valohai-token ${VALOHAI_TOKEN} \
   project create                   \
   -n ${PROJECT_NAME} --yes