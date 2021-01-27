#!/bin/bash

set -eu
set -o pipefail

INSTANCE_PUBLIC_IP="$(get-instance-public-ip.sh)"

NOTEBOOK_URL=""

while [[ true ]];
do
	NOTEBOOK_URL=$(ssh opc@${INSTANCE_PUBLIC_IP}      \
	                  'docker logs $(docker ps -q)' | \
	                  grep -v "NotebookApp"         | \
	                  grep '127.0\.0\.1'            | \
	                  awk '{print $2}'              | \
	                  sed 's/127\.0\.0\.1/'${INSTANCE_PUBLIC_IP}'/g')
	if [[ "${NOTEBOOK_URL}" == "" ]]; then
		sleep 2
	else
		break
	fi
done

echo ${NOTEBOOK_URL}