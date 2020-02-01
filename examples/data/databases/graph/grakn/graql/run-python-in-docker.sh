#!/bin/bash

set -e
set -u
set -o pipefail

echo "Running python contain, mapping to current folder"
WORKDIR=/home/python

echo ""; echo "Run the below command once you are in the container"
echo "   $ pip3 install setuptools ijson==2.3 grakn-client"; echo ""
echo ""
echo "Use python3 or pip3 to run any pythong or pip commands"

PREVIOUS_TO_PREVIOUS_DIR=$(cd ../.. && echo $(pwd))

set -x
docker run --rm                                       \
           -it                                        \
           --volume $(pwd):${WORKDIR}                 \
           --workdir ${WORKDIR}                       \
           --network="host"                           \
           --entrypoint="/bin/bash"                   \
           neomatrix369/grakn:1.6.2-GRAALVM-CE-19.2.1
           
set +x