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
       Tokenise a line of text or an article into it’s smaller components (i.e. words, punctuation, numbers).
       
       Usage: $0 --method [ simple | learnable ]
                 --text [text]
                 --file [path/to/filename]
                 --help

       --method       [ simple | learnable ]
                        simple        use the simple tokenisation method
                        learnable     use the learned model to perform tokenisation
       --text         plain text surrounded by quotes
       --file         name of the file containing text to pass as command arg
       --help         shows the script usage help text

HEREDOC

  exit 1
}

APACHE_OPENNLP_CMD=""
setCommand() {
  APACHE_OPENNLP_CMD="${OPENNLP_BINARY} ${METHOD} ${SHARED_FOLDER}/${MODEL_FILENAME}"
}

setMethod() {
  METHOD=$(echo ${METHOD} | awk '{print tolower($0)}' || true)
  if [[ "${METHOD}" = "simple" ]]; then
    METHOD=SimpleTokenizer;
    MODEL_FILENAME=""
  elif [[ "${METHOD}" = "learnable" ]]; then
    METHOD=TokenizerME
    MODEL_FILENAME="${language}-token.bin"
    downloadModel;
  fi
}

MODEL_VERSION=1.5
MODEL_FILENAME=""
METHOD="simple"

checkIfNoParamHasBeenPassedIn "$#"

while [[ "$#" -gt 0 ]]; do case $1 in
  --help)                showUsageText;
                         exit 0;;
  --method)              METHOD="${2:-}";
                         setMethod
                         shift;;
  --text)                PLAIN_TEXT="${2:-}";
                         checkIfApacheOpenNLPIsPresent
                         setCommand
                         TMPFILE=$(mktemp)
                         echo ${PLAIN_TEXT} > ${TMPFILE}
                         cat ${TMPFILE} | ${APACHE_OPENNLP_CMD}
                         rm -f ${TMPFILE} 
                         exit 0;;
  --file)                FILENAME="${2:-}";
                         checkIfApacheOpenNLPIsPresent
                         setCommand
                         cat ${FILENAME} | ${APACHE_OPENNLP_CMD};
                         exit 0;;
  *) echo "Unknown parameter passed: $1";
     showUsageText;
esac; shift; done

checkIfNoActionParamHasBeenPassedIn "$#"