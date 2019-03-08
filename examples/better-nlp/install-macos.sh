#!/usr/bin/env bash

set -e
set -u
set -o pipefail

echo "Please check if you fulfill the requirements mentioned in the README file."

# Install and update necessary MacOS packages

brew update && brew install -y wget curl liblapack-dev libswscale-dev pkg-config

brew install -y --fix-missing zip vim

# Install node and update npm
curl --silent --location https://deb.nodesource.com/setup_8.x | bash - && brew install -y nodejs

npm install -g npm

# Quick review of program versions
npm --version
python --version
pip --version

# Install python packages for NLP
python -m pip install spacy textacy

# Install the large English language model for spaCy
python -m spacy download en_core_web_lg
python -m spacy link en_core_web_lg en

python -m pip install rasa_nlu[spacy]