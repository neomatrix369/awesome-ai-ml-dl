#!/bin/bash

#
# Copyright 2019 Mani Sarkar
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e
set -u
set -o pipefail

source common.sh

gitClone https://github.com/oracle/tribuo "v4.1.X-release-branch"
cd tribuo

echo "Downloading Maven wrapper artifacts"
curl -sL https://github.com/shyiko/mvnw/releases/download/0.1.0/mvnw.tar.gz | tar xvz

# Maven version can be changed with
(MAVEN_VERSION=3.6.3 &&
  sed -iEe "s/[0-9]\+[.][0-9]\+[.][0-9]\+/${MAVEN_VERSION}/g" .mvn/wrapper/maven-wrapper.properties)

## Ideally we could have just downloaded the jars from maven central
## But we need the below, and it's not clear if the Maven central Jars 
## have dependencies with them:
#
#      "tribuo-core-4.1.0-SNAPSHOT.jar"
#      "tribuo-json-4.0.0-jar-with-dependencies.jar"
#      "tribuo-classification-experiments-4.0.0-jar-with-dependencies.jar"
#      "tribuo-regression-sgd-4.0.0-jar-with-dependencies.jar"
#      "tribuo-regression-xgboost-4.0.0-jar-with-dependencies.jar"
#      "tribuo-regression-tree-4.0.0-jar-with-dependencies.jar"
#      "tribuo-anomaly-libsvm-4.0.0-jar-with-dependencies.jar"
#      "tribuo-clustering-kmeans-4.0.0-jar-with-dependencies.jar"
#
## and other dependencies needed for the notebooks in the 'tutorials' folder.

# But we will build instead, skipping tests and ignoring test failures,
# as they fail when building an ONNX related sub-project.
# The below does build jars with dependencies which we can
# directly use for the notebooks
echo "Building Tribuo using Maven"
set -x
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Skipping test failures - not ideal, but to gain some speed"
./mvnw install package -DskipTests
       
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
set +x

TRIBUO_VERSION="4.2.0"
TRIBUO_VERSION_IN_NOTEBOOK="4.2.0"
M2_REPO_FOLDER="/root/.m2/repository/"
TRIBUO_M2_FOLDER="${M2_REPO_FOLDER}/org/tribuo/"
JSON_FOLDER="${TRIBUO_M2_FOLDER}/tribuo-json/${TRIBUO_VERSION}"
CORE_FOLDER="${TRIBUO_M2_FOLDER}/tribuo-core/${TRIBUO_VERSION}"
CLASSIFICATION_FOLDER="${TRIBUO_M2_FOLDER}/tribuo-classification-experiments/${TRIBUO_VERSION}"
REGRESSION_SGD_FOLDER="${TRIBUO_M2_FOLDER}/tribuo-regression-sgd/${TRIBUO_VERSION}"
REGRESSION_XGBOOST_FOLDER="${TRIBUO_M2_FOLDER}/tribuo-regression-xgboost/${TRIBUO_VERSION}"
REGRESSION_TREE_FOLDER="${TRIBUO_M2_FOLDER}/tribuo-regression-tree/${TRIBUO_VERSION}"
CLUSTERING_KMEANS_FOLDER="${TRIBUO_M2_FOLDER}/tribuo-clustering-kmeans/${TRIBUO_VERSION}"
ANOMALY_LIBSVM_FOLDER="${TRIBUO_M2_FOLDER}/tribuo-anomaly-libsvm/${TRIBUO_VERSION}"
ONNX_FOLDER="${TRIBUO_M2_FOLDER}/tribuo-onnx/${TRIBUO_VERSION}"

echo "Copying the necessary jars into the tutorials folder"

cp ${JSON_FOLDER}/tribuo-json-${TRIBUO_VERSION}-jar-with-dependencies.jar \
   tutorials/tribuo-json-${TRIBUO_VERSION_IN_NOTEBOOK}-jar-with-dependencies.jar

cp ${CORE_FOLDER}/tribuo-core-${TRIBUO_VERSION}.jar \
   tutorials/tribuo-core-${TRIBUO_VERSION_IN_NOTEBOOK}.jar

cp ${CLASSIFICATION_FOLDER}/tribuo-classification-experiments-${TRIBUO_VERSION}-jar-with-dependencies.jar \
   tutorials/tribuo-classification-experiments-${TRIBUO_VERSION_IN_NOTEBOOK}-jar-with-dependencies.jar

cp ${REGRESSION_SGD_FOLDER}/tribuo-regression-sgd-${TRIBUO_VERSION}-jar-with-dependencies.jar \
   tutorials/tribuo-regression-sgd-${TRIBUO_VERSION_IN_NOTEBOOK}-jar-with-dependencies.jar

cp ${REGRESSION_XGBOOST_FOLDER}/tribuo-regression-xgboost-${TRIBUO_VERSION}-jar-with-dependencies.jar \
   tutorials/tribuo-regression-xgboost-${TRIBUO_VERSION_IN_NOTEBOOK}-jar-with-dependencies.jar

cp ${REGRESSION_TREE_FOLDER}/tribuo-regression-tree-${TRIBUO_VERSION}-jar-with-dependencies.jar \
   tutorials/tribuo-regression-tree-${TRIBUO_VERSION_IN_NOTEBOOK}-jar-with-dependencies.jar

cp ${CLUSTERING_KMEANS_FOLDER}/tribuo-clustering-kmeans-${TRIBUO_VERSION}-jar-with-dependencies.jar \
   tutorials/tribuo-clustering-kmeans-${TRIBUO_VERSION_IN_NOTEBOOK}-jar-with-dependencies.jar

cp ${ANOMALY_LIBSVM_FOLDER}/tribuo-anomaly-libsvm-${TRIBUO_VERSION}-jar-with-dependencies.jar \
   tutorials/tribuo-anomaly-libsvm-${TRIBUO_VERSION_IN_NOTEBOOK}-jar-with-dependencies.jar

cp ${ONNX_FOLDER}/tribuo-onnx-${TRIBUO_VERSION}-jar-with-dependencies.jar \
   tutorials/tribuo-onnx-${TRIBUO_VERSION_IN_NOTEBOOK}-jar-with-dependencies.jar

echo "Downloading datasets"
wget --directory-prefix=tutorials \
     https://archive.ics.uci.edu/ml/machine-learning-databases/iris/bezdekIris.data

wget --directory-prefix=tutorials \
     https://archive.ics.uci.edu/ml/machine-learning-databases/wine-quality/winequality-red.csv

wget http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz \
     http://yann.lecun.com/exdb/mnist/train-labels-idx1-ubyte.gz
wget http://yann.lecun.com/exdb/mnist/t10k-images-idx3-ubyte.gz \
     http://yann.lecun.com/exdb/mnist/t10k-labels-idx1-ubyte.gz

cd ..