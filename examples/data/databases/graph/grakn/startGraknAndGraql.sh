#!/bin/bash

set -e
set -u
set -o pipefail

GRAKN_VERSION=${GRAKN_VERSION:-1.4.3}
GRAKN_PORT=${GRAKN_PORT:-4567}

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
java -version
echo "JAVA_HOME=${JAVA_HOME}"

echo "\nGrakn version:"
./grakn-core-${GRAKN_VERSION}/grakn version
echo "\nGraql version:" 
./grakn-core-${GRAKN_VERSION}/graql version

echo "\nGRAKN_PORT=${GRAKN_PORT}"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
time ./grakn-core-${GRAKN_VERSION}/grakn server start 
echo "^^^^^^^^^^^^^^^^^ Time taken for the Grakn server to startup"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Grakn server is running..."
echo "Dashboard: http://localhost:${GRAKN_PORT}"
echo "Starting Graql console..."
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
time ./grakn-core-${GRAKN_VERSION}/graql console