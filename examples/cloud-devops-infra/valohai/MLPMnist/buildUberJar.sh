#!/bin/bash

set -e
set -u
set -o pipefail

OSNAME=${1:-linux}

echo "Building uber jar for target platform: ${OSNAME}"
mvn package -Djavacpp.platform=${OSNAME}-x86_64