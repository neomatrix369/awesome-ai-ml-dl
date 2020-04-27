#!/bin/bash

set -e
set -u
set -o pipefail

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Running python contain, mapping to current folder"
WORKDIR=/home/python

echo ""; echo "Run the below command once you are in the container"
echo "   $ pip3 install -r requirements.txt"; echo ""
echo "Use python3 or pip3 to run any pythong or pip commands"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"; echo ""

PREVIOUS_TO_PREVIOUS_DIR=$(cd ../.. && echo $(pwd))

set -x
docker run --rm                                       \
           -it                                        \
           --volume $(pwd):${WORKDIR}                 \
           --workdir ${WORKDIR}                       \
           --network="host"                           \
           --entrypoint="/bin/bash"                   \
           neomatrix369/datascience:0.1

set +x