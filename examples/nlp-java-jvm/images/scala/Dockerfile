ARG BASE_IMAGE
FROM ${BASE_IMAGE}

### Common functions
COPY common.sh common.sh

### Saul installation
### https://github.com/CogComp/saul
COPY saul.sh saul.sh

### ATR4S installation
### https://github.com/ispras/atr4s
COPY atr4s.sh atr4s.sh

### tm installation
### https://github.com/ispras/tm
COPY tm.sh tm.sh

### word2vec-scala installation
### https://github.com/Refefer/word2vec-scala
COPY word2vec-scala.sh word2vec-scala.sh

### epic installation
### https://github.com/dlwh/epic
COPY epic.sh epic.sh

RUN chown -R nlp-java:nlp-java .

USER nlp-java