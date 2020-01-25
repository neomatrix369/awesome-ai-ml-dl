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

cd ${WORKDIR}/shared
echo ""; echo "~~~~ Current working directory: $(pwd)"

if [[ -d benchmark ]]; then
  cd benchmark
  git config --local user.name "Mani Sarkar"
  git config --local user.email "sadhak001@gmail.com"
  git pull
else
  git clone --depth=1 https://github.com/graknlabs/benchmark/
  cd benchmark
fi

BENCHMARK_FOLDER=$(pwd)

mkdir -p logs
echo ""; echo "~~~~ Updating maven dependencies via Bazel ~~~~"
set -x
time ./dependencies/maven/update.sh &> logs/maven_update.logs
set +x

if [[ $? -eq 0 ]]; then
   echo ""; echo "~~~~ Finished updating Maven dependencies via Bazel ~~~~"
else
   echo ""; echo "~~~~ Failed updating Maven dependencies via Bazel with error code $? ~~~~"
fi
cat logs/maven_update.logs

echo ""; echo "~~~ Building report-producer-distribution via Bazel ~~~"
cd ${BENCHMARK_FOLDER}; echo "\n~~~~ Current working directory: $(pwd)"
set -x
time bazel build //:report-producer-distribution &> logs/bazel_build.logs
set +x

if [[ $? -eq 0 ]]; then
   echo ""; echo "~~~ Finished building report-producer-distribution via Bazel ~~~"
else
   echo ""; echo "~~~ Failed building report-producer-distribution via Bazel with error code $? ~~~"
fi
cat logs/bazel_build.logs

echo ""; echo "~~~ Running report producer ~~~"
cd bazel-genfiles
unzip -u report-producer.zip
cd report-producer

echo ""; echo "~~~ Copying config road_config_read_c2.yml ~~~"
cp ${BENCHMARK_FOLDER}/common/configuration/scenario/road_network/road_config_read_c2.yml \
   ${BENCHMARK_FOLDER}/bazel-out/darwin-fastbuild/bin/report-producer/scenario/road_network

echo ""; echo "~~~ Running ./report_producer using copied config ~~~"
set -x
GRAKN_URI="localhost" && time ./report_producer                    \
    --config=scenario/road_network/road_config_read_c2.yml         \
    --execution-name "road-read-c2" --grakn-uri ${GRAKN_URI}:48555 \
    --keyspace road_read_c2_${JDK_MODE}
set +x
echo "~~~ Finished running report producer ~~~"

echo ""; echo "~~~ Merging reports ~~~"
rm -f ${BENCHMARK_FOLDER}/bazel-genfiles/report-producer/report*.json
cp ${WORKDIR}/mergeJson.sh ${BENCHMARK_FOLDER}/bazel-genfiles/report-producer
cd ${BENCHMARK_FOLDER}/bazel-genfiles/report-producer
./mergeJson.sh
mv report.json report-${JDK_MODE}.json

echo ""; echo "~~~ Converting to text report ~~~"
cd ${BENCHMARK_FOLDER}
rm -f ${BENCHMARK_FOLDER}/bazel-genfiles/report-producer/formatted.report.output*.txt

java -version &> ${BENCHMARK_FOLDER}/bazel-genfiles/report-producer/formatted.report.output-${JDK_MODE}.txt

set -x
bazel run //report/formatter:report-formatter-binary --          \
          --rawReport=${BENCHMARK_FOLDER}/bazel-genfiles/report-producer/report-${JDK_MODE}.json \
          --destination=. >> ${BENCHMARK_FOLDER}/bazel-genfiles/report-producer/formatted.report.output-${JDK_MODE}.txt
set +x