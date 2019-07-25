ARG BASE_IMAGE
FROM ${BASE_IMAGE}

### Stanford NLP installation
### https://stanfordnlp.github.io/CoreNLP/

RUN curl -O -L -J http://nlp.stanford.edu/software/stanford-corenlp-full-2018-10-05.zip
RUN unzip stanford-corenlp-full-2018-10-05.zip
RUN rm stanford-corenlp-full-2018-10-05.zip

### Apache OpenNLP installation
### https://opennlp.apache.org/

RUN curl -O -L -J http://apache.mirror.anlx.net/opennlp/opennlp-1.9.1/apache-opennlp-1.9.1-bin.tar.gz
RUN tar xvzf apache-opennlp-1.9.1-bin.tar.gz
RUN rm apache-opennlp-1.9.1-bin.tar.gz

### NLP4J: NLP Toolkit for JVM Languages
### https://emorynlp.github.io/nlp4j/

RUN curl -O -L -J http://nlp.mathcs.emory.edu/nlp4j/nlp4j-appassembler-1.1.3.tgz
RUN tar xvzf nlp4j-appassembler-1.1.3.tgz
RUN rm nlp4j-appassembler-1.1.3.tgz