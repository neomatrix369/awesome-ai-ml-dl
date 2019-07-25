#!/bin/bash

set -e
set -u
set -o pipefail

source common.sh

cd shared
FOLDER=mallet-2.0.8
ARTIFACT=${FOLDER}.tar.gz
downloadArtifact http://mallet.cs.umass.edu/dist/${ARTIFACT} \
                 ${ARTIFACT}                                 \
                 "${PWD}/${FOLDER}"
cd ..