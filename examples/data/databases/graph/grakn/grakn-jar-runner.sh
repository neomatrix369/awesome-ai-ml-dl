#!/usr/bin/env bash
#
# GRAKN.AI - THE KNOWLEDGE GRAPH
# Copyright (C) 2018 Grakn Labs Ltd
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as
# published by the Free Software Foundation, either version 3 of the
# License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

# Grakn global variables
JAVA_BIN=java
[[ $(readlink $0) ]] && path=$(readlink $0) || path=$0
GRAKN_HOME=$(cd "$(dirname "${path}")" && pwd -P)
GRAKN_CONFIG="server/conf/grakn.properties"

CONSOLE_JAR_FILENAME=(${GRAKN_HOME}/console/services/lib/*console*.jar)
SERVER_JAR_FILENAME=(${GRAKN_HOME}/server/services/lib/*server*.jar)

# ================================================
# common helper functions
# ================================================
exit_if_java_not_found() {
  which "${JAVA_BIN}" > /dev/null
  exit_code=$?

  if [[ $exit_code -ne 0 ]]; then
    echo "Java is not installed on this machine. Grakn needs Java 1.8 in order to run."
    exit 1
  fi
}

# =============================================
# main routine
# =============================================

exit_code=0

pushd "$GRAKN_HOME" > /dev/null
exit_if_java_not_found

CURRENT_DIR=$(pwd)

if [ -z "$1" ]; then
    echo "Missing argument. Possible commands are:"
    echo "  Server:          grakn server [--help]"
    echo "  Console:         grakn console [--help]"
    echo "  Version:         grakn version"
elif [ "$1" = "console" ]; then
    if [ -f "${CONSOLE_JAR_FILENAME}" ]; then
        echo "Grakn Core Console is included in this Grakn distribution."
        CONSOLE_SERVICE_LIB=${GRAKN_HOME}/console/services/lib
        SERVICE_LIB_CP="console/services/lib/*"
        CLASSPATH="${GRAKN_HOME}/${SERVICE_LIB_CP}:${GRAKN_HOME}/console/conf/"
        set -x
        java -agentlib:native-image-agent=config-merge-dir=${CURRENT_DIR}/META-INF/native-image \
             ${CONSOLE_JAVAOPTS} -cp "${CLASSPATH}" -Dgrakn.dir="${GRAKN_HOME}" grakn.core.console.GraknConsole "$@"
        set +x
    else
        echo "Grakn Core Console is not included in this Grakn distribution."
        echo "You may want to install Grakn Core Console or Grakn Core (all)."
    fi
elif [[ "$1" = "server" ]] || [[ "$1" = "version" ]]; then
    if [[ -f "${SERVER_JAR_FILENAME}" ]]; then
        echo "Grakn Core Server is included in this Grakn distribution."
        SERVICE_LIB_CP="server/services/lib/*"
        CLASSPATH="${GRAKN_HOME}/${SERVICE_LIB_CP}:${GRAKN_HOME}/server/conf/"
        
        SERVER_SERVICE_LIB=${GRAKN_HOME}/server/services/lib
        SERVER_SERVICE_LIB_JAR=${SERVER_SERVICE_LIB}/server-binary_deploy.jar
        mkdir -p ${SERVER_SERVICE_LIB}/META-INF/native-image
        ### Run class file
        # java ${GRAKN_DAEMON_JAVAOPTS} -cp "${CLASSPATH}" -Dgrakn.dir="${GRAKN_HOME}" \
        #      -Dgrakn.conf="${GRAKN_HOME}/${GRAKN_CONFIG}" -Dstorage.javaopts="${STORAGE_JAVAOPTS}" \
        #      -Dserver.javaopts="${SERVER_JAVAOPTS}" grakn.core.daemon.GraknDaemon $@
        
        if [[ "${JAVA_HOME}" = "${GRAALVM_HOME}" ]]; then
          set -x
          ### Run Jar with native image
          java -Dgrakn.dir="${GRAKN_HOME}" \
               -Dgrakn.conf="${GRAKN_HOME}/${GRAKN_CONFIG}" -Dstorage.javaopts="${STORAGE_JAVAOPTS}" \
               -Dserver.javaopts="${SERVER_JAVAOPTS}"\
               ${GRAKN_DAEMON_JAVAOPTS} \
               -cp "${GRAKN_HOME}/server/conf/" \
               -agentlib:native-image-agent=config-merge-dir="${CURRENT_DIR}/META-INF/native-image" \
               -jar ${SERVER_SERVICE_LIB_JAR} \
               $@
          set +x
        else
          ### Run Jar without native image
          set -x
          java -Dgrakn.dir="${GRAKN_HOME}" \
               -Dgrakn.conf="${GRAKN_HOME}/${GRAKN_CONFIG}" -Dstorage.javaopts="${STORAGE_JAVAOPTS}" \
               -Dserver.javaopts="${SERVER_JAVAOPTS}"\
               ${GRAKN_DAEMON_JAVAOPTS} \
               -cp "${GRAKN_HOME}/server/conf/" \
               -jar ${SERVER_SERVICE_LIB_JAR} \
               $@
          set +x
        fi
    else
        echo "Grakn Core Server is not included in this Grakn distribution."
        echo "You may want to install Grakn Core Server or Grakn Core (all)."
    fi
else
    echo "Invalid argument: $1. Possible commands are: "
    echo "  Server:          grakn server [--help]"
    echo "  Console:         grakn console [--help]"
    echo "  Version:         grakn version"
fi

exit_code=$?

popd > /dev/null

exit $exit_code
