#!/bin/bash

set -e
set -u
set -o pipefail

EXEC_COUNTER=${1:-latest}
echo "Watching counter ${EXEC_COUNTER}"
# Use 'timeout 5' as prefix, if you wish your script 
# to time out after watching for 5 seconds
vh exec watch ${EXEC_COUNTER}
echo "Stopped watching counter ${EXEC_COUNTER}"
echo "Re-run to continue to watch or run the './show-final-result.sh ${EXEC_COUNTER}' to see the final outcome"