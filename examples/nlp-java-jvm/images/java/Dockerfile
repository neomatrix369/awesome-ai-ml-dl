ARG BASE_IMAGE
FROM ${BASE_IMAGE}

### Common functions
COPY common.sh common.sh

### Stanford NLP installation
### https://stanfordnlp.github.io/CoreNLP/
COPY corenlp.sh corenlp.sh

### Apache OpenNLP installation
### https://opennlp.apache.org/
COPY opennlp.sh opennlp.sh

### NLP4J: NLP Toolkit for JVM Languages
### https://emorynlp.github.io/nlp4j/
COPY nlp4j.sh nlp4j.sh

### Word2vec in Java
### https://deeplearning4j.org/docs/latest/deeplearning4j-nlp-word2vec
COPY word2vec.sh word2vec.sh

### ReVerb: Web-Scale Open Information Extraction
### https://github.com/knowitall/reverb/
COPY reverb.sh reverb.sh

### OpenRegex:  An efficient and flexible token-based regular expression language and engine
### https://github.com/knowitall/openregex
COPY openregex.sh openregex.sh

### CogCompNLP:  Core libraries developed in the U of Illinois' Cognitive Computation Group.
### https://github.com/CogComp/cogcomp-nlp
COPY cogcomp-nlp.sh cogcomp-nlp.sh

### MALLET: MAchine Learning for LanguagE Toolkit
### http://mallet.cs.umass.edu/
COPY mallet.sh mallet.sh

### RDRPOSTagger: A robust POS tagging toolkit available (in both Java & Python) together with pre-trained models for 40+ languages.
### https://github.com/datquocnguyen/RDRPOSTagger
COPY rdrposttagger.sh rdrposttagger.sh

RUN chown -R nlp-java:nlp-java .

USER nlp-java