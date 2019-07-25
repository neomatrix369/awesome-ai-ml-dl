ARG BASE_IMAGE
FROM ${BASE_IMAGE}

### Common functions
COPY common.sh common.sh

### Clojure-openNLP installation
### https://github.com/dakrone/clojure-opennlp
COPY clojure-opennlp.sh clojure-opennlp.sh

### Infections-clj installation
### https://github.com/r0man/inflections-clj
COPY inflections-clj.sh inflections-clj.sh

### postagga installation
### https://github.com/fekr/postagga
COPY postagga.sh postagga.sh

RUN chown -R nlp-java:nlp-java .

USER nlp-java