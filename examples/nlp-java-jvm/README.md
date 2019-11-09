# NLP Java/JVM [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

NLP Java: [![NLP Java](https://img.shields.io/docker/pulls/neomatrix369/nlp-java.svg)](https://hub.docker.com/r/neomatrix369/nlp-java) | NLP Clojure: [![NLP Clojure](https://img.shields.io/docker/pulls/neomatrix369/nlp-clojure.svg)](https://hub.docker.com/r/neomatrix369/nlp-clojure) | NLP Kotlin: [![NLP Kotlin](https://img.shields.io/docker/pulls/neomatrix369/nlp-kotlin.svg)](https://hub.docker.com/r/neomatrix369/nlp-kotlin) | NLP Scala: [![NLP Scala](https://img.shields.io/docker/pulls/neomatrix369/nlp-scala.svg)](https://hub.docker.com/r/neomatrix369/nlp-scala)

Run a docker container with NLP libraries/frameworks written in Java/JVM languages, running under the traditional Java 8 (from OpenJDK or another source) or GraalVM.

Find out more about [Natural Language Processing](https://en.wikipedia.org/wiki/Natural_language_processing) from the [NLP section](../../natural-language-processing/README.md#natural-language-processing-nlp) section.

Startup in traditional JDK or GraalVM mode.

## Goals

- Run docker container containing NLP libraries/frameworks written in Java/JVM languages
- Ability to create custom docker images (scripts & docs provided)
- Ability to debug the docker container
- Run using the traditional JDK (OpenJDK or vendor specific versions)
- Run using the polyglot JVM i.e. GraalVM JDK (Community version from Oracle Labs)
- Play with and learn from with some examples for each of the libraries provided

## Libraries / frameworks provided

### Java
- [Standford CoreNLP](https://stanfordnlp.github.io/CoreNLP/)
- [Apache OpenNLP](https://opennlp.apache.org/) | See **[README](./images/java/opennlp/README.md#apache-opennlp-) for usage and examples**
- [NLP4J: NLP Toolkit for JVM Languages](https://emorynlp.github.io/nlp4j/)
- [Word2vec in Java](https://deeplearning4j.org/docs/latest/deeplearning4j-nlp-word2vec)
- [ReVerb: Web-Scale Open Information Extraction](https://github.com/knowitall/reverb/)
- [OpenRegex: An efficient and flexible token-based regular expression language and engine](https://github.com/knowitall/openregex)
- [CogcompNLP: Core libraries developed in the U of Illinois' Cognitive Computation Group](https://github.com/datquocnguyen/RDRPOSTagger)
- [MALLET - MAchine Learning for LanguagE Toolkit](http://mallet.cs.umass.edu/)
- [RDRPOSTagger - A robust POS tagging toolkit available (in both Java & Python) together with pre-trained models for 40+ languages.](https://github.com/datquocnguyen/RDRPOSTagger)

### Clojure
- [Clojure-openNLP](https://github.com/dakrone/clojure-opennlp) - Natural Language Processing in Clojure (opennlp)
- [Infections-clj](https://github.com/r0man/inflections-clj) - Rails-like inflection library for Clojure and ClojureScript
- [postagga](https://github.com/fekr/postagga) - A library to parse natural language in Clojure and ClojureScript

### Kotlin
- [Lingua](https://github.com/pemistahl/lingua/) - A language detection library for Kotlin and Java, suitable for long and short text alike
- [Kotidgy](https://github.com/meiblorn/kotidgy) — an index-based text data generator written in Kotlin

### Scala
- [Saul](https://github.com/CogComp/saul) - Library for developing NLP systems, including built in modules like SRL, POS, etc.
- [ATR4S](https://github.com/ispras/atr4s) - Toolkit with state-of-the-art automatic term recognition methods.
- [tm](https://github.com/ispras/tm) - Implementation of topic modeling based on regularized multilingual PLSA.
- [word2vec-scala](https://github.com/Refefer/word2vec-scala) - Scala interface to word2vec model; includes operations on vectors like word-distance and word-analogy.
- [Epic](https://github.com/dlwh/epic) - Epic is a high performance statistical parser written in Scala, along with a framework for building complex structured prediction models.

## Scripts provided

**Go to [the previous folder](../nlp-java-jvm) to find the below scripts.**

- [docker-runner.sh](./docker-runner.sh): can perform a number of the below actions depending on the flags passed to it:
    - runs the container and brings you to the command prompt inside the container:
    - build the docker base and language (i.e. java, clojure, kotlin, scala) specific image takes under 5 minutes to finish on a decent connection 
    - push pre-built docker images to docker hub (please pass in your own Docker username and later on enter Docker login details, see usage below)
    - a housekeeping script to remove dangling images and terminated containers (helps save some diskspace)
- [Base Dockerfile](./images/base/Dockerfile) | [Java Dockerfile](./images/java/Dockerfile): Dockerfile scripts to help build the base and language (i.e. java, clojure, kotlin, scala) specific docker image of NLP Java/JVM in an isolated environment with the necessary dependencies.
- [images folder](./images) - provided with scripts to build and the scripts included into the container for the base image and language (i.e. java, clojure, kotlin, scala) specific docker image

## Usage

**Help:**

```bash
$ ./docker-runner.sh --help

       Usage: ./docker-runner.sh --dockerUserName [docker user name]
                                 --language [language id]
                                 --detach
                                 --jdk [GRAALVM]
                                 --javaopts [java opt arguments]
                                 --buildImage
                                 --runContainer
                                 --pushImageToHub
                                 --cleanup
                                 --help

       --dockerUserName      docker user name as on Docker Hub
                             (mandatory with build, run and push commands)
       --language            language id as in java, clojure, scala, etc...
       --detach              run container and detach from it,
                             return control to console
       --jdk                 name of the JDK to use (currently supports 
                             GRAALVM only, default is blank which 
                             enables the traditional JDK)
       --javaopts            sets the JAVA_OPTS environment variable
                             inside the container as it starts
       --cleanup             (command action) remove exited containers and
                             dangling images from the local repository
       --buildImage          (command action) build the docker image
       --runContainer        (command action) run the docker image as a docker container
       --pushImageToHub      (command action) push the docker image built to Docker Hub
       --help                shows the script usage help text
```

**Run the NLP Java/JVM docker container:**

```bash
$ ./docker-runner.sh --runContainer

or

$ ./docker-runner.sh --runContainer --dockerUserName [your docker user name]

or run in GraalVM mode

$ ./docker-runner.sh --runContainer --jdk "GRAALVM"

or run by switching off JVMCI flag (default: on) when running in GRAALVM mode

$ ./docker-runner.sh --javaopts "-XX:-UseJVMCINativeLibrary"
```

**Build the docker container:**

Ensure your environment has the below variable set, or set it in your `.bashrc` or `.bash_profile` or the relevant startup script:

```bash
export DOCKER_USER_NAME="your_docker_username"
```

You must have an account on Docker hub under the above user name.


```bash
$ ./docker-runner --buildImage

or

$ ./docker-runner --buildImage --dockerUserName "your_docker_username"

or

$ ./docker-runner --buildImage --language [language_id]
```

`[language_id]` - defaults to `java` when not provided. Accepts: `java`, `clojure`, `kotlin`, `scala`

**Push built NLP Java/JVM docker image to Docker hub:**

```bash
$ ./docker-runner --pushImageToHub

or

$ ./docker-runner --pushImageToHub --dockerUserName "your_docker_username"
```

The above will prompt the docker login name and password, before it can push your image to Docker hub (you must have an account on Docker hub).

**Docker image on Docker Hub**

Find the [NLP Java/JVM Docker Image on Docker Hub](https://hub.docker.com/r/neomatrix369/nlp-java). The `docker-runner.sh --pushImageToHub` script pushes the image to the Docker hub and the `docker-runner.sh --runContainer` script runs it from the local repository. If absent, in the the local repository, it downloads this image from Docker Hub.

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../../CONTRIBUTING.md) guidelines, also have a read about our [licensing](../../LICENSE.md) policy.

---

Back to [NLP page](../../natural-language-processing/README.md#natural-language-processing-nlp) </br>
Back to [main page (table of contents)](../../README.md)