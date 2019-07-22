#!/bin/bash

set -e
set -u
set -o pipefail

DEFAULT_JDK="${JAVA_8_HOME}"
GRAKN_VERSION=${GRAKN_VERSION:-1.5.7}
GRAKN_PORT=${GRAKN_PORT:-4567}

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

echo "JAVA_HOME=${JAVA_HOME}"
java -version

(env | grep _JAVAOPTS) || true 

echo "GRAKN_PORT=${GRAKN_PORT}"
BAZEL_VERSION=0.26.1
./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh

cd ${WORKDIR}/shared
echo "~~~~ Current working directory: $(pwd)"

if [[ -d benchmark ]]; then
  cd benchmark
  git pull origin master
else
  git clone --depth=1 https://github.com/graknlabs/benchmark/
  cd benchmark
fi

mkdir -p logs
echo "~~~~ Updating maven dependencies via Bazel ~~~~"
time ./dependencies/maven/update.sh              &> logs/maven_update.logs

if [[ $? -eq 0 ]]; then
   echo "~~~~ Finished updating Maven dependencies via Bazel ~~~~"
else
   echo "~~~~ Failed updating Maven dependencies via Bazel with error code $? ~~~~"
fi
cat logs/maven_update.logs

echo "~~~ Building report-producer-distribution via Bazel ~~~"
time bazel build //:report-producer-distribution &> logs/bazel_build.logs

if [[ $? -eq 0 ]]; then
   echo "~~~ Finished building report-producer-distribution via Bazel ~~~"
else
   echo "~~~ Failed building report-producer-distribution via Bazel with error code $? ~~~"
fi
cat logs/bazel_build.logs

echo "~~~ Running report producer ~~~"
cd bazel-genfiles
unzip report-producer.zip
time GRAKN_URI=localhost ./report_producer                              \
    --config=scenario/road_network/road_config_read_c4.yml         \
    --execution-name "road-read-c4" --grakn-uri ${GRAKN_URI}:48555 \
    --keyspace road_read_c4
echo "~~~ Finished running report producer ~~~"