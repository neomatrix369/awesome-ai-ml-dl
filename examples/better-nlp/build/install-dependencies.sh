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

pip install --user jupyterlab pandas nltk