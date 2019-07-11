#!/bin/bash

set -e
set -u
set -o pipefail

if [[ "${JDK_TO_USE}" = "GRAALVM" ]]; then	
	GRAALVM_HOME="/usr/lib/jvm/graalvm-ce-${GRAALVM_VERSION}"
	JAVA_HOME=${GRAALVM_HOME}
	echo "JAVA_HOME=${JAVA_HOME}"
	PATH=${GRAALVM_HOME}/bin:${PATH}
	echo "PATH=${PATH}"

	java -version
fi

echo "Current working directory: $(pwd)"
echo "DSS_VERSION=${DSS_VERSION}"
./run.sh