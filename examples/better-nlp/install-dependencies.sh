#!/usr/bin/env bash

set -e
set -u
set -o pipefail

echo "Install components using python and pip"

npm install -g npm

# Quick review of program versions
npm --version
python --version
pip --version

# Install python packages for NLP
python -m pip install spacy textacy

pip install --user jupyterlab

python -m pip install rasa_nlu[spacy]

# Install the large English language model for spaCy
# Note: from observation it appears that spaCy model 
# should be installed towards the end of the installation 
# process, it avoid errors when running programs using the model.
python -m spacy download en_core_web_lg
python -m spacy link en_core_web_lg en