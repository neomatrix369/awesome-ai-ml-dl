#!/bin/bash

set -e
set -u
set -o pipefail

source common.sh

cd shared
FOLDER=appassembler
ARTIFACT=nlp4j-${FOLDER}-1.1.3.tgz
downloadArtifact http://nlp.mathcs.emory.edu/nlp4j/${ARTIFACT} \
                 ${ARTIFACT}                                   \
                 "${PWD}/${FOLDER}"
cd ..