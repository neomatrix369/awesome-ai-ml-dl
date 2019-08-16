#!/bin/bash

set -e
set -u
set -o pipefail

TARGET_JAR_FILE="MLPMnist-1.0.0.jar"
if [[ -s "target/MLPMnist-1.0.0-beta4-bin.jar" ]]; then
	TARGET_JAR_FILE="target/MLPMnist-1.0.0-beta4-bin.jar"
fi

java -version

java -jar ${TARGET_JAR_FILE} \
          -Djava.library.path=""