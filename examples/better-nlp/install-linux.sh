#!/usr/bin/env bash

# Install and update necessary Linux packages

apt-get update && apt-get install -y --fix-missing wget curl liblapack-dev libswscale-dev pkg-config

apt-get install -y --fix-missing zip vim 

echo "fs.inotify.max_user_watches=100000" > /etc/sysctl.conf

# Install node and update npm
curl --silent --location https://deb.nodesource.com/setup_8.x | bash - && apt-get install nodejs -y

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