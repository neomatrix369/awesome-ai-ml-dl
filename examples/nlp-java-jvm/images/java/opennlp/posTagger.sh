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

downloadPosTaggerModel() {
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
       Tag parts of speech of each token in a line of text or an article 
       (see Penn Treebank tag set 
       (https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html) 
       also see https://nlp.stanford.edu/software/tagger.shtml.

       Usage: $0 --method [ maxent | perceptron ]
                 --text [text]
                 --file [path/to/filename]
                 --help

       --method       [ maxent | perceptron ]
                        maxent        use the model trained using the Max Entropy algorithm
                        perceptron    use the model trained using the Perceptron algorithm to train
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
                                                                                  POSTagger
                                                         ${SHARED_FOLDER}/${MODEL_FILENAME}
  "  
}

checkMethod() {
  VALID_METHODS="|maxent|perceptron"
  FOUND_METHOD=$(echo ${VALID_METHODS} | grep "${METHOD:-}" || true)
  if [[ -z "${METHOD:-}" ]] || [[ -z "${FOUND_METHOD:-}"  ]]; then
    echo "Method type not specified or invalid method specified. Please refer to the usage text."; 
    showUsageText
    exit -1
  fi
}

setMethod() {
  METHOD=$(echo ${METHOD} | awk '{print tolower($0)}' || true)
  MODEL_FILENAME="${language}-pos-${METHOD}.bin"
}

showHelpForLegend() {
  echo ""; 
  echo "Check out https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html 
  to find out what each of the tags mean"
}

while [[ "$#" -gt 0 ]]; do case $1 in
  --help)                showUsageText;
                         exit 0;;
  --method)              METHOD="${2:-}";
                         checkMethod
                         setMethod
                         setCommand;
                         shift;;
  --text)                PLAIN_TEXT="${2:-}";
                         downloadPosTaggerModel;
                         echo ${PLAIN_TEXT} | ${APACHE_OPENNLP_CMD};
                         showHelpForLegend
                         exit 0;;
  --file)                FILENAME="${2:-}";
                         downloadPosTaggerModel;
                         cat ${FILENAME}    | ${APACHE_OPENNLP_CMD};
                         showHelpForLegend                         
                         exit 0;;
  *) echo "Unknown parameter passed: $1";
     showUsageText;
esac; shift; done

if [[ "$#" -eq 0 ]]; then
  echo "No command action passed in as parameter. Please see usage below:"
  showUsageText
fi