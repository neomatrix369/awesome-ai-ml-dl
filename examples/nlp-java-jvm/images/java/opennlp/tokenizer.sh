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

downloadTokeniseModel() {
  echo "Checking if model ${MODEL_FILENAME} (${language}) exists..."
  if [[ -s "${SHARED_FOLDER}/${MODEL_FILENAME}" ]]; then
    echo "Found model ${MODEL_FILENAME} (${language})"
  else
    echo "Downloading model ${MODEL_FILENAME} (${language})..."
    curl -O -J -L \
         "http://opennlp.sourceforge.net/models-${MODEL_VERSION}/${MODEL_FILENAME}"
    mv ${MODEL_FILENAME} ${SHARED_FOLDER}     
  fi
}

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

if [[ "$#" -eq 0 ]]; then
  echo "No parameter has been passed. Please see usage below:"
  showUsageText
fi

SHARED_FOLDER="../shared/"
language=en
APACHE_OPENNLP_VERSION=1.9.1
MODEL_VERSION=1.5
MODEL_FILENAME=""
METHOD="simple"

APACHE_OPENNLP_CMD=""
setCommand() {
  APACHE_OPENNLP_CMD="${SHARED_FOLDER}/apache-opennlp-${APACHE_OPENNLP_VERSION}/bin/opennlp
                                                                                  ${METHOD}
                                                         ${SHARED_FOLDER}/${MODEL_FILENAME}
  "  
}

setMethod() {
  METHOD=$(echo ${METHOD} | awk '{print tolower($0)}' || true)
  if [[ "${METHOD}" = "simple" ]]; then
    METHOD=SimpleTokenizer;
    MODEL_FILENAME=""
  elif [[ "${METHOD}" = "learnable" ]]; then
    METHOD=TokenizerME
    MODEL_FILENAME="${language}-token.bin"
    downloadTokeniseModel;
  fi
}

while [[ "$#" -gt 0 ]]; do case $1 in
  --help)                showUsageText;
                         exit 0;;
  --method)              METHOD="${2:-}";
                         setMethod
                         shift;;
  --text)                PLAIN_TEXT="${2:-}";
                         TMPFILE=$(mktemp)
                         echo ${PLAIN_TEXT} > ${TMPFILE}
                         cat ${TMPFILE} | ${SHARED_FOLDER}/apache-opennlp-${APACHE_OPENNLP_VERSION}/bin/opennlp ${METHOD}
                         rm -f ${TMPFILE}
                         exit 0;;
  --file)                FILENAME="${2:-}";
                         cat ${FILENAME}| ${APACHE_OPENNLP_CMD};
                         exit 0;;
  *) echo "Unknown parameter passed: $1";
     showUsageText;
esac; shift; done

if [[ "$#" -eq 0 ]]; then
  echo "No command action passed in as parameter. Please see usage below:"
  showUsageText
fi