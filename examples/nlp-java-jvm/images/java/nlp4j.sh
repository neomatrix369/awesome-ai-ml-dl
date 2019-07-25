#!/bin/bash

set -e
set -u
set -o pipefail

source common.sh

cd shared
FOLDER=nlp4j-appassembler-1.1.3
ARTIFACT=${FOLDER}.tgz
downloadArtifact http://nlp.mathcs.emory.edu/nlp4j/${ARTIFACT} \
                 ${ARTIFACT}                                   \
                 "${PWD}/${FOLDER}"
cd ..