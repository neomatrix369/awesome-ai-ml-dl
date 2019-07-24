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

git config --local user.name "Mani Sarkar"
git config --local user.email "sadhak001@gmail.com"
git am -3 < ${PROJECT_ROOT_FOLDER}/0001-Build-a-distribution-with-uber-jars.patch
git am < ${PROJECT_ROOT_FOLDER}/0002-upgrade-jline-to-2.14.6.patch

bazel build //:assemble-linux-deploy-targz