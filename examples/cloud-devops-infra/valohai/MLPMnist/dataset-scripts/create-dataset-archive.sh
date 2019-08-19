#!/bin/bash

set -e
set -u
set -o pipefail

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

TARGET_ARCHIVE="${CURRENT_DIR}/mlp-mnist-dataset.tgz"

echo ""
echo "~~~ Deleting ${TARGET_ARCHIVE}"
rm -f ${TARGET_ARCHIVE}

echo ""
echo "~~~ Creating new archive ${TARGET_ARCHIVE}"
cd ${HOME}
tar cvzf ${TARGET_ARCHIVE} .deeplearning4j

cd ${CURRENT_DIR}
echo ""
ls -lash ${TARGET_ARCHIVE}