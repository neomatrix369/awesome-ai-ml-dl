#!/bin/bash

set -ex
set -u
set -o pipefail

echo "JAVA_OPTS=${JAVA_OPTS}"

java -XX:+PrintFlagsFinal

jupyter kernelspec list
jupyter notebook --ip=0.0.0.0 --no-browser --allow-root