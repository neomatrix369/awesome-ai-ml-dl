#!/bin/bash

set -e
set -u
set -o pipefail

STEPNAME=${1:-}

if [[ -z "${STEPNAME}" ]];  then
	echo "Please specify step name. Exiting..."
	echo " Usage: "
	echo "        $0 [stepname]"
	exit -1
fi
echo "Executing step ${STEPNAME}"

vh exec run ${STEPNAME}                      \
        --adhoc