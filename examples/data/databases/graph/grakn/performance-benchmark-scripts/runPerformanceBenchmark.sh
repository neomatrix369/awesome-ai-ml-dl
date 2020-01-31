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

DEFAULT_JDK="${JAVA8_HOME}"
GRAKN_VERSION=${GRAKN_VERSION:-$(cat grakn_version.txt)}
WORKDIR=${WORKDIR:-$(pwd)}

echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
export JAVA_HOME=${DEFAULT_JDK}
if [[ "${JDK_TO_USE:-}" = "GRAALVM" ]]; then
    export JAVA_HOME=${GRAALVM_HOME}
    export PATH=${GRAALVM_HOME}/bin:${PATH}
    COMMON_JAVAOPTS=${COMMON_JAVAOPTS:="-XX:+UseJVMCINativeLibrary"}
    export GRAKN_DAEMON_JAVAOPTS="${COMMON_JAVAOPTS} ${GRAKN_DAEMON_JAVAOPTS:-}"
    export STORAGE_JAVAOPTS="${COMMON_JAVAOPTS} ${STORAGE_JAVAOPTS:-}"
    export SERVER_JAVAOPTS="${COMMON_JAVAOPTS} ${SERVER_JAVAOPTS:-}"
fi

JDK_MODE="traditional_jdk"
if [[ "${JAVA_HOME}" = "${GRAALVM_HOME}" ]]; then
  JDK_MODE="graalvm"
fi

echo "Mode=${JDK_MODE}"

echo "JAVA_HOME=${JAVA_HOME}"
java -version

(env | grep _JAVAOPTS) || true 


echo -n "Grakn version: (see bottom of the startup text banner)"
echo ""
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
time ./grakn-core-all-linux-${GRAKN_VERSION}/grakn server start --benchmark
# Run the newly built Grakn server (UberJar, native-build, etc...)
# time ./grakn-core-all-deploy-linux-jline-2.14.6/grakn server start --benchmark
# Enable above when the build is in order
echo "^^^^^^^^^^^^^^^^^ Time taken for the Grakn server to startup"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "Grakn server is running..."

SHARED_FOLDER=${WORKDIR}/shared
cd ${SHARED_FOLDER}

echo ""; echo "~~~~ Current working directory: $(pwd)"

if [[ -d benchmark ]]; then
  cd benchmark
  git config --local user.name "Mani Sarkar"
  git config --local user.email "sadhak001@gmail.com"
  git pull
else  
  echo ""; echo "~~~~ Cloning the grakn/benchmark project"
  git clone --depth=1 https://github.com/graknlabs/benchmark/
  cd benchmark
fi

BENCHMARK_FOLDER=$(pwd)

mkdir -p logs
echo ""; echo "~~~~ grakn/benchmark: Updating maven dependencies via Bazel ~~~~"
echo ""; echo "You can follow the update process by doing this:"
echo "       $ tail -f ${BENCHMARK_FOLDER}/logs/maven_update.logs"; echo ""

set -x
time ./dependencies/maven/update.sh &> logs/maven_update.logs
set +x

if [[ $? -eq 0 ]]; then
   echo ""; echo "~~~~ grakn/benchmark: Finished updating Maven dependencies via Bazel ~~~~"
else
   echo ""; echo "~~~~ grakn/benchmark: Failed updating Maven dependencies via Bazel with error code $? ~~~~"
fi
cat logs/maven_update.logs

echo ""; echo "~~~ grakn/benchmark: Building report-producer-distribution via Bazel ~~~"
cd ${BENCHMARK_FOLDER}; 
echo ""; echo "~~~~ Current working directory: $(pwd)"
echo ""; echo "You can follow the update process by doing this:"
echo "       $ tail -f ${BENCHMARK_FOLDER}/logs/bazel_build.logs"; echo ""
set -x
time bazel build //:report-producer-distribution &> logs/bazel_build.logs
set +x

if [[ $? -eq 0 ]]; then
   echo ""; echo "~~~ grakn/benchmark: Finished building report-producer-distribution via Bazel ~~~"
else
   echo ""; echo "~~~ grakn/benchmark: Failed building report-producer-distribution via Bazel with error code $? ~~~"
fi
cat logs/bazel_build.logs

echo ""; echo "~~~ grakn/benchmark: Running report producer ~~~"
cd bazel-genfiles
unzip -u report-producer.zip
cd report-producer

BENCHMARK_CONFIG_NAME=road_read_c4
BENCHMARK_CONFIG_FILE=road_config_read_c4.yml
echo "~~~ grakn/benchmark: Listing config ${BENCHMARK_CONFIG_FILE} ~~~"
ls ${BENCHMARK_FOLDER}/bazel-out/${FOLDER_PREFIX}-fastbuild/bin/report-producer/scenario/road_network

echo ""; echo "~~~ grakn/benchmark: Running ./report_producer using config file ${BENCHMARK_CONFIG_FILE} ~~~"
set -x
GRAKN_URI="localhost" && time ./report_producer                    \
    --config=scenario/road_network/${BENCHMARK_CONFIG_FILE}        \
    --execution-name "${BENCHMARK_CONFIG_NAME}" --grakn-uri ${GRAKN_URI}:48555 \
    --keyspace "${BENCHMARK_CONFIG_NAME}_${JDK_MODE}"
set +x
echo "~~~ grakn/benchmark: Finished running report producer ~~~"

echo ""; echo "~~~ grakn/benchmark: Merging reports ~~~"
rm -f ${BENCHMARK_FOLDER}/bazel-genfiles/report-producer/report*.json
cp ${WORKDIR}/mergeJson.sh ${BENCHMARK_FOLDER}/bazel-genfiles/report-producer
cd ${BENCHMARK_FOLDER}/bazel-genfiles/report-producer
./mergeJson.sh
mv report.json report-${JDK_MODE}.json

echo ""; echo "~~~ grakn/benchmark: Converting to text report ~~~"
cd ${BENCHMARK_FOLDER}
rm -f ${BENCHMARK_FOLDER}/bazel-genfiles/report-producer/formatted.report.output*.txt

java -version &> ${BENCHMARK_FOLDER}/bazel-genfiles/report-producer/formatted.report.output-${JDK_MODE}.txt

set -x
bazel run //report/formatter:report-formatter-binary --          \
          --rawReport=${BENCHMARK_FOLDER}/bazel-genfiles/report-producer/report-${JDK_MODE}.json \
          --destination=. >> ${BENCHMARK_FOLDER}/bazel-genfiles/report-producer/formatted.report.output-${JDK_MODE}.txt
set +x
echo ""; echo "~~~ grakn/benchmark: Finished ~~~"