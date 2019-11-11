# Apache OpenNLP [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) [![NLP Java](https://img.shields.io/docker/pulls/neomatrix369/nlp-java.svg)](https://hub.docker.com/r/neomatrix369/nlp-java) 

Run a docker container with Apache OpenNLP written in Java, running under the traditional Java 8 (from OpenJDK or another source) or GraalVM.

Find out more about [Natural Language Processing](https://en.wikipedia.org/wiki/Natural_language_processing) from the [NLP section](../../../../../natural-language-processing/README.md#natural-language-processing-nlp) section.

Startup in traditional JDK or GraalVM mode.

## Goals

- Run the Docker container containing the Apache OpenNLP tool by using `./docker-runner --runContainer`
- Run in GraalVM mode inside the docker container by using `switchToGraal` at the prompt (polyglot JVM i.e. GraalVM JDK Community version from Oracle Labs) (optional)
- Run a number of NLP actions to explore the Apache OpenNLP tool shown below in the [Exploring NLP concepts](#exploring-nlp-concepts) section

## Exploring NLP concepts

### Detecting language

Detecting language in a single line text or article (see [legend of language abbreviations](https://www.apache.org/dist/opennlp/models/langdetect/1.8.3/README.txt) used).

See [Detecting Language](./README-detecting-language.md)

### Detecting sentences

Detecting sentences in a single line text or article.

See [Detecting sentences](./README-detecting-sentences.md)

### Finding names

Finding person name, organization name, date, time, money, location, percentage information in a single line text or article.

See [Finding names](./README-finding-names.md)

### Tokenise

Tokenise a line of text or an article into it’s smaller components (i.e. words, punctuation, numbers).

See [Tokenise](./README-tokenise.md)

### Parser

Parse a line of text or an article and identify groups of words or phrases that go together (see [Penn Treebank tag set](https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html) for legend of token types).

See [Parser](./README-parser.md)

### Tag Parts of Speech

Tag parts of speech of each token in a line of text or an article (see [Penn Treebank tag set](https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html) for legend of token types), also see https://nlp.stanford.edu/software/tagger.shtml.

See [Tag Parts of Speech](./README-tag-parts-of-speech.md)

### Chunking

Text chunking by dividing a text or an article into syntactically correlated parts of words, like noun groups, verb groups. You apply this feature on the tagged parts of speech text or article. Apply chunking on a text already tagged by PoS tagger. Also see https://nlpforhackers.io/text-chunking/.

See [Chunking](./README-chunking.md)

## Scripts provided

**Go to [the previous folder](../opennlp) to find the below scripts.**

- [opennlp.sh](./opennlp.sh): download and install the Apache OpenNLP tool into the `shared` folder
- [detectLanguage.sh](./detectLanguage.sh): Detecting language in a single line text or article (see [legend of language abbreviations](https://www.apache.org/dist/opennlp/models/langdetect/1.8.3/README.txt) used).
- [detectSentence.sh](./detectSentence.sh): Detecting sentences in a single line text or article.
- [nameFinder.sh](./nameFinder.sh): Finding person name, organization name, date, time, money, location, percentage information in a single line text or article.
- [tokenizer.sh](./tokenizer.sh): Tokenise a line of text or an article into it’s smaller components (i.e. words, punctuation, numbers).
- [parser.sh](./parser.sh): Parse a line of text or an article and identify groups of words or phrases that go together (see [Penn Treebank tag set](https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html) for legend of token types).
- [posTagger.sh](./posTagger.sh): Tag parts of speech of each token in a line of text or an article (see [Penn Treebank tag set](https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html) for legend of token types), also see https://nlp.stanford.edu/software/tagger.shtml.
- [chunker.sh](./chunker.sh): Text chunking by dividing a text or an article into syntactically correlated parts of words, like noun groups, verb groups. You apply this feature on the tagged parts of speech text or article. Apply chunking on a text already tagged by PoS tagger. Also see https://nlpforhackers.io/text-chunking/.

All the above scripts check if the respective model(s) exist and downloads them accordingly into the `shared` folder.

## Docker image on Docker Hub (optional)

Find the [NLP Java/JVM Docker Image on Docker Hub](https://hub.docker.com/r/neomatrix369/nlp-java). The `docker-runner.sh --pushImageToHub` script pushes the image to the Docker hub and the `docker-runner.sh --runContainer` script runs it from the local repository. If absent, in the the local repository, it downloads this image from Docker Hub.

## Resources

### Apache OpenNLP

- [Apache OpenNLP](https://opennlp.apache.org/) | [GitHub](https://github.com/apache/opennlp) | [Mailing list](https://opennlp.apache.org/mailing-lists.html) | [@apacheopennlp](https://twitter.com/@apacheopennlp)
- Docs
    - [Documentation resources](https://opennlp.apache.org/docs/)
    - [Apache OpenNLP Tools Javadoc](https://opennlp.apache.org/docs/1.9.1/apidocs/opennlp-tools/index.html)
    - [Manual](https://opennlp.apache.org/docs/1.9.1/manual/opennlp.html)
- Download
    - [Apache OpenNLP Jar/binary](https://opennlp.apache.org/download.html)
    - Model Zoo
        - [Models page](https://opennlp.apache.org/models.html)
        - [Language Detect model](http://www.mirrorservice.org/sites/ftp.apache.org/opennlp/models/langdetect/1.8.3/langdetect-183.bin)
        - [Older models to support the examples in the docs](http://opennlp.sourceforge.net/models-1.5/)
- Legend to support the examples in the docs
    - [List of languages](https://www.apache.org/dist/opennlp/models/langdetect/1.8.3/README.txt)
    - [Penn Treebank tag set](https://www.ling.upenn.edu/courses/Fall_2003/ling001/penn_treebank_pos.html)

### Other NLP Java/JVM libraries

- [Standford CoreNLP](https://stanfordnlp.github.io/CoreNLP/) (GPL v2)
- [NLP4J: NLP Toolkit for JVM Languages](https://emorynlp.github.io/nlp4j/)
- [Word2vec in Java](https://deeplearning4j.org/docs/latest/deeplearning4j-nlp-word2vec) (DL4J)
- [ReVerb: Web-Scale Open Information Extraction](https://github.com/knowitall/reverb/) 
- [OpenRegex: An efficient and flexible token-based regular expression language and engine](https://github.com/knowitall/openregex) 
- [CogcompNLP: Core libraries developed in the U of Illinois' Cognitive Computation Group](https://github.com/datquocnguyen/RDRPOSTagger)
- [MALLET - MAchine Learning for LanguagE Toolkit](http://mallet.cs.umass.edu/)
- [RDRPOSTagger - A robust POS tagging toolkit available (in both Java & Python) together with pre-trained models for 40+ languages.](https://github.com/datquocnguyen/RDRPOSTagger)

### [Awesome AI/ML/DL resources](https://github.com/neomatrix369/awesome-ai-ml-dl/)
  * [Java AI/ML/DL resources](https://github.com/neomatrix369/awesome-ai-ml-dl/blob/master/README-details.md#java)
      * [Deep Learning and DL4J Resources](https://github.com/neomatrix369/awesome-ai-ml-dl/blob/master/README-details.md#deep-learning)
      * **Awesome AI/ML/DL:** [NLP resources](https://github.com/neomatrix369/awesome-ai-ml-dl/tree/master/natural-language-processing#natural-language-processing-nlp)
      * **DL4J NLP resources**
          * [Language processing](https://deeplearning4j.org/docs/latest/deeplearning4j-nlp-overview)
              * [ND4J backends for GPUs and CPUs](https://deeplearning4j.org/docs/latest/deeplearning4j-config-gpu-cpu)
              * [How the Vocab Cache Works](https://deeplearning4j.org/docs/latest/deeplearning4j-nlp-vocabulary-cache)
              * [Word2Vec, Doc2vec & GloVe: Neural Word Embeddings for Natural Language Processing](https://deeplearning4j.org/docs/latest/deeplearning4j-nlp-word2vec)
              * [Doc2Vec, or Paragraph Vectors, in Deeplearning4j](https://deeplearning4j.org/docs/latest/deeplearning4j-nlp-doc2vec)
              * [Sentence iterator](https://deeplearning4j.org/docs/latest/deeplearning4j-nlp-sentence-iterator)
              * [What is Tokenization?](https://deeplearning4j.org/docs/latest/deeplearning4j-nlp-tokenization)
          * Examples
              * https://github.com/eclipse/deeplearning4j-examples/tree/master/dl4j-examples
              * https://github.com/eclipse/deeplearning4j/tree/master/deeplearning4j/deeplearning4j-nlp-parent

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../../../../../CONTRIBUTING.md) guidelines, also have a read about our [licensing](../../../../../LICENSE.md) policy.

---

Back to [NLP page](../../../../../natural-language-processing/README.md#natural-language-processing-nlp) </br>
Back to [main page (table of contents)](../../../../../README.md)