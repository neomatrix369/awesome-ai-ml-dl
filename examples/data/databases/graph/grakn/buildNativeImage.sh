#!/bin/bash

set -e
set -u
set -o pipefail

JARFILE=${1:-server-binary_deploy.jar}
IMAGE_NAME=$(basename ${JARFILE%.*})

SHOW_STACK_TRACES=${SHOW_STACK_TRACES:-}
# --enable-all-security-services --enable-http --enable-https --enable-url-protocols
OPTIONS="${2:-} --no-fallback --no-fallback -H:+ReportExceptionStackTraces --report-unsupported-elements-at-runtime --allow-incomplete-classpath"
OPTIONS="${OPTIONS} -H:ReflectionConfigurationFiles=${PWD}/META-INF/native-image/reflect-config.json"
OPTIONS="${OPTIONS} -H:DynamicProxyConfigurationFiles=${PWD}/META-INF/native-image/proxy-config.json"
OPTIONS="${OPTIONS} -H:ResourceConfigurationFiles=${PWD}/META-INF/native-image/resource-config.json"
OPTIONS="${OPTIONS} -H:JNIConfigurationFiles=${PWD}/META-INF/native-image/jni-config.json"

if [[ "${SHOW_STACK_TRACES}" = "true" ]]; then
   OPTIONS="${OPTIONS} -H:+ReportExceptionStackTraces"
fi

native-image ${OPTIONS} -jar ${JARFILE} ${IMAGE_NAME} 