#!/bin/bash

set -e
set -u
set -o pipefail

java -XX:+PrintFlagsFinal --version

echo ""
echo "~~~ JDK9, Linux only: We are enabling JVMCI flags (enabling Graal as Tier-2 compiler) ~~~"
echo "~~~ Please check docs for higher versions of JDK and other platforms ~~~"
echo "JAVA_OPTS=${JAVA_OPTS}"
echo ""

jupyter kernelspec list
echo ""

jupyter notebook --ip=0.0.0.0 --no-browser --allow-root