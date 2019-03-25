#!/bin/bash

set -e
set -u
set -o pipefail

DEFAULT_JDK="${JAVA_8_HOME}"
GRAKN_VERSION=${GRAKN_VERSION:-1.4.3}
GRAKN_PORT=${GRAKN_PORT:-4567}

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
export JAVA_HOME=${DEFAULT_JDK}
if [[ "${JDK_TO_USE:-}"="GRAALVM" ]]; then
    export JAVA_HOME=${GRAALVM_HOME}
    export PATH=${GRAALVM_HOME}/bin:${PATH}
fi

echo "JAVA_HOME=${JAVA_HOME}"
java -version

echo -n "Grakn version:"
./grakn-core-${GRAKN_VERSION}/grakn version
echo -n "Graql version:"
./grakn-core-${GRAKN_VERSION}/graql version

echo -n "GRAKN_PORT=${GRAKN_PORT}"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
time ./grakn-core-${GRAKN_VERSION}/grakn server start 
echo "^^^^^^^^^^^^^^^^^ Time taken for the Grakn server to startup"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Grakn server is running..."
echo "Dashboard: http://localhost:${GRAKN_PORT}"
echo "Starting Graql console..."
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
time ./grakn-core-${GRAKN_VERSION}/graql console