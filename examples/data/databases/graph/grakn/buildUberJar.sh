#!/bin/bash

set -e
set -u
set -o pipefail

PROJECT_ROOT_FOLDER=$(pwd)

cd ${PROJECT_ROOT_FOLDER}/shared

if [[ -d "grakn" ]]; then
	cd ${PROJECT_ROOT_FOLDER}/shared/grakn
	git pull origin master
else
    git clone https://github.com/graknlabs/grakn
    cd ${PROJECT_ROOT_FOLDER}/shared/grakn
fi


git config --global user.email "you@example.com"
git config --global user.name "Your Name"
git am -3 < ${PROJECT_ROOT_FOLDER}/0001-Build-a-distribution-with-uber-jars.patch

bazel build //:assemble-linux-deploy-targz