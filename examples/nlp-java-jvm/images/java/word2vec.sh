#!/bin/bash

set -e
set -u
set -o pipefail


cd shared

if [ -d "word2dec-dl4j" ]; then
	echo "word2dec-dl4j already exists, aborting process, remove folder to perform download/update"
	exit -1
fi

mkdir -p "word2dec-dl4j"
cd word2dec-dl4j

git init
git remote add -f origin https://github.com/deeplearning4j/dl4j-examples
git config core.sparseCheckout true
echo "examples/nlp" >> .git/info/sparse-checkout

git pull --depth=1 origin master

cd ../..