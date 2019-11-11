#!/bin/bash

set -e
set -u
set -o pipefail

source ../common.sh

mkdir -p ../shared
cd ../shared
FOLDER=apache-opennlp-1.9.1-bin
ARTIFACT=${FOLDER}.tar.gz
downloadArtifact http://apache.mirror.anlx.net/opennlp/opennlp-1.9.1/${ARTIFACT} \
                 ${ARTIFACT}                                 \
                 "${PWD}/${FOLDER}"
cd -