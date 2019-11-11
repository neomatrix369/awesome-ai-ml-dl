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
       Text chunking by dividing a text or an article into syntactically 
       correlated parts of words, like noun groups, verb groups. You apply 
       this feature on the tagged parts of speech text or article. Apply 
       chunking on a text already tagged by PoS tagger. Also see 
       https://nlpforhackers.io/text-chunking/.    

       Usage: $0 --text [text]
                 --file [path/to/filename]
                 --help

       --text      plain text surrounded by quotes
       --file      name of the file containing text to pass as command arg
       --help      shows the script usage help text

HEREDOC

	exit 1
}

MODEL_FILENAME="${language}-chunker.bin"
APACHE_OPENNLP_CMD="${OPENNLP_BINARY} ChunkerME ${SHARED_FOLDER}/${MODEL_FILENAME}" 

checkIfNoParamHasBeenPassedIn "$#"

while [[ "$#" -gt 0 ]]; do case $1 in
  --help)                showUsageText;
                         exit 0;;
  --text)                PLAIN_TEXT="${2:-}";
                         checkIfApacheOpenNLPIsPresent
                         downloadModel;
                         echo ${PLAIN_TEXT} | ${APACHE_OPENNLP_CMD};
                         exit 0;;
  --file)                FILENAME="${2:-}";
                         checkIfApacheOpenNLPIsPresent
                         downloadModel;
                         cat ${FILENAME}    | ${APACHE_OPENNLP_CMD};
                         exit 0;;
  *) echo "Unknown parameter passed: $1";
     showUsageText;
esac; shift; done