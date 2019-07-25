ARG BASE_IMAGE
FROM ${BASE_IMAGE}

### Common functions
COPY common.sh common.sh

### Lingua installation
### https://github.com/pemistahl/lingua/
COPY lingua.sh lingua.sh

### Kotidgy installation
### https://github.com/meiblorn/kotidgy
COPY kotidgy.sh kotidgy.sh

RUN chown -R nlp-java:nlp-java .

USER nlp-java