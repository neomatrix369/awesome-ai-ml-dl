#!/bin/bash

set -e
set -u
set -o pipefail

source common.sh

cd shared

FOLDER=stanford-corenlp-full-2018-10-05
ARTIFACT=${FOLDER}.zip
downloadArtifact http://nlp.stanford.edu/software/${ARTIFACT} \
                 ${ARTIFACT}                                 \
                 "${PWD}/${FOLDER}"
cd ..