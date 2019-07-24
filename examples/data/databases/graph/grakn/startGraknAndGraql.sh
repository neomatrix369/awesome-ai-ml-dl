#!/bin/bash

set -e
set -u
set -o pipefail

GRAKN_VERSION=${GRAKN_VERSION:-1.5.7}

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

echo "JAVA_HOME=${JAVA_HOME}"
export PATH="${JAVA_HOME}/bin:${PATH}"
java -version

echo -n "Grakn version: (see bottom of the startup text banner)"
echo ""

(env | grep _JAVAOPTS) || true 

echo ""
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
time ./grakn-core-all-linux-${GRAKN_VERSION}/grakn server start --benchmark
echo "^^^^^^^^^^^^^^^^^ Time taken for the Grakn server to startup"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Grakn server is running..."

if [[ "${SKIP_GRAQL:-}" = "true" ]]; then
	echo "Skipping running Graql console"
else
	echo "Starting Graql console..."
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	time ./grakn-core-all-linux-${GRAKN_VERSION}/grakn console
fi