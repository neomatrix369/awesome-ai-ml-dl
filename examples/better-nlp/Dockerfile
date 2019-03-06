FROM python:3.7

RUN apt-get update && apt-get install -y --fix-missing wget curl liblapack-dev libswscale-dev pkg-config

RUN apt-get install -y --fix-missing zip vim 

RUN useradd -ms /bin/bash node
RUN echo "fs.inotify.max_user_watches=100000" > /etc/sysctl.conf

RUN curl --silent --location https://deb.nodesource.com/setup_8.x | bash - && apt-get install nodejs -y

RUN npm install -g npm

RUN npm --version
RUN python --version
RUN pip --version

# Install python packages for NLP
RUN python -m pip install spacy textacy

# Install the large English language model for spaCy
RUN python -m spacy download en_core_web_lg
RUN python -m spacy link en_core_web_lg en

RUN python -m pip install rasa_nlu[spacy]