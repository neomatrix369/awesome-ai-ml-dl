#!/bin/bash

set -e
set -u
set -o pipefail

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

	echo ""
	echo "~~~ Running DSS in a Docker container using the ${JDK_TO_USE_STRING}"
	DSS_CONTAINER_ID=$(DETACHED_MODE=true JDK_TO_USE="${JDK_TO_USE}" JAVA_OPTS=${JAVA_OPTS} ./runDssInDocker.sh)
	DSS_CONTAINER_ID=${DSS_CONTAINER_ID:0:7}

	if [[ -z "${DSS_CONTAINER_ID}" ]]; then
		echo "${JDK_TO_USE}: DSS in the container has not started yet"
		exit 0
	fi

	echo "${JDK_TO_USE}: DSS in the container is now starting (id = ${DSS_CONTAINER_ID})"
	tempOutputFile=$(mktemp)
	while [ true ]
	do
		result=$( curl -I localhost:10000 &> ${tempOutputFile} \
			              && grep "200 OK" ${tempOutputFile} || true )
		if [[ -z "${result}" ]]; then
			printPing 4000
		else
			echo ""
			echo "${JDK_TO_USE}: DSS in the container is now running."
			break
		fi
	done

	echo "${JDK_TO_USE}: Shutting down DSS in the container (id = ${DSS_CONTAINER_ID})"
	docker rm -f ${DSS_CONTAINER_ID} || true
	echo "${JDK_TO_USE}: DSS in the container (id = ${DSS_CONTAINER_ID}) has been shutdown."
	echo ""
}

time runContainer "Traditional-JDK" "Traditional JDK (version 1.8)" ""

time runContainer "GRAALVM" "GraalVM (version 1.8), JVMCI disabled" "-XX:-UseJVMCINativeLibrary"

time runContainer "GRAALVM" "GraalVM (version 1.8), JVMCI enabled" "-XX:+UseJVMCINativeLibrary"