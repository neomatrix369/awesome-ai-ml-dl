#!/bin/bash

set -e
set -u
set -o pipefail

TMPFILE=$(mktemp)
EXEC_COUNTER=${1:-latest}
echo "Gathering output from counter ${EXEC_COUNTER}"
vh exec logs ${EXEC_COUNTER} --stdout > ${TMPFILE}

grep -A20 'Started*' ${TMPFILE} || \
          (true && \
            echo "Nothing found, maybe it failed, maybe its still running." && \
            echo "Use the './watch-execution.sh ${EXEC_COUNTER}' command to find out.")

rm -fr ${TMPFILE}