#!/bin/bash

set -e
set -u
set -o pipefail

DEFAULT_JDK="${JAVA_8_HOME}"
GRAKN_VERSION=${GRAKN_VERSION:-1.5.7}
GRAKN_PORT=${GRAKN_PORT:-4567}


echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
export JAVA_HOME=${DEFAULT_JDK}
if [[ "${JDK_TO_USE:-}" = "GRAALVM" ]]; then
    export JAVA_HOME=${GRAALVM_HOME}
    export PATH=${GRAALVM_HOME}/bin:${PATH}
    TOGGLE_JVMCI=${TOGGLE_JVMCI:="-XX:+UseJVMCINativeLibrary"}
    export GRAKN_DAEMON_JAVAOPTS="${TOGGLE_JVMCI} ${GRAKN_DAEMON_JAVAOPTS:-}"
    export STORAGE_JAVAOPTS="${TOGGLE_JVMCI} ${STORAGE_JAVAOPTS:-}"
    export SERVER_JAVAOPTS="${TOGGLE_JVMCI} ${SERVER_JAVAOPTS:-}"
fi

echo "JAVA_HOME=${JAVA_HOME}"
java -version

echo -n "Grakn version: (see bottom of sartup text banner)"
echo ""

(env | grep _JAVAOPTS) || true 

echo -n "GRAKN_PORT=${GRAKN_PORT}"
echo ""
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
time ./grakn-core-all-linux-${GRAKN_VERSION}/grakn server start --benchmark
echo "^^^^^^^^^^^^^^^^^ Time taken for the Grakn server to startup"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Grakn server is running..."
echo "Dashboard: http://localhost:${GRAKN_PORT}"
echo "Starting Graql console..."
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
time ./grakn-core-all-linux-${GRAKN_VERSION}/grakn console