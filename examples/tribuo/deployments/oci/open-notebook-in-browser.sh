#!/bin/bash

set -eu
set -o pipefail

getOpenCommand() {
  if [[ "$(uname)" = "Linux" ]]; then
     echo "xdg-open"
  elif [[ "$(uname)" = "Darwin" ]]; then
     echo "open"
  fi
}

OPEN_COMMAND=$(getOpenCommand)
NOTEBOOK_URL=$(get-notebook-url.sh)
set -x
"${OPEN_COMMAND}" "${NOTEBOOK_URL}"
set +x