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

source common-functions.sh

showUsageText() {
    cat << HEREDOC
       Finding person name, organisation name, date, time, money, location, 
       percentage information in a single line text or article.

       Usage: $0 --method [ person | location | date | time | money | organization | percentage ]
                 --text [text]
                 --file [path/to/filename]
                 --help
       --method    [ person | location | date | time | money | organization | percentage ]
                     person       - find name of persons in text
                     location     - find location names in text
                     date         - find dates mentioned in text
                     time         - find time mentioned in text
                     money        - find money / currency mentioned in text
                     organization - find organization names mentioned in text
                     percentage   - find percentages mentioned in text
       --text      plain text surrounded by quotes
       --file      name of the file containing text to pass as command arg
       --help      shows the script usage help text

HEREDOC

	exit 1
}

setModelFilename() { 
  MODEL_FILENAME="${language}-ner-${METHOD}.bin"  
}

setCommand() {
  APACHE_OPENNLP_CMD="${OPENNLP_BINARY} TokenNameFinder ${SHARED_FOLDER}/${MODEL_FILENAME}" 
}

checkMethod() {
  VALID_METHODS="|person|location|date|time|money|organization|percentage|"
  FOUND_METHOD=$(echo ${VALID_METHODS} | grep "${METHOD:-}" || true)
  if [[ -z "${METHOD:-}" ]] || [[ -z "${FOUND_METHOD:-}"  ]]; then
    echo "Method type not specified or invalid method specified. Please refer to the usage text."; 
    showUsageText
    exit -1
  fi
}

MODEL_VERSION=1.5
MODEL_FILENAME=""

checkIfNoParamHasBeenPassedIn "$#"

while [[ "$#" -gt 0 ]]; do case $1 in
  --help)                showUsageText;
                         exit 0;;
  --method)              METHOD="${2:-}";
                         checkMethod
                         setModelFilename
                         setCommand;
                         shift;;
  --text)                PLAIN_TEXT="${2:-}";
                         checkIfApacheOpenNLPIsPresent
                         checkMethod
                         downloadModel;
                         echo ${PLAIN_TEXT} | ${APACHE_OPENNLP_CMD};
                         exit 0;;
  --file)                FILENAME="${2:-}";
                         checkIfApacheOpenNLPIsPresent
                         checkMethod
                         downloadModel;
                         cat ${FILENAME}    | ${APACHE_OPENNLP_CMD};
                         exit 0;;
  *) echo "Unknown parameter passed: $1";
     showUsageText;
esac; shift; done

checkIfNoActionParamHasBeenPassedIn "$#"