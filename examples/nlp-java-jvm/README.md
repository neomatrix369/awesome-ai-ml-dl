# NLP Java/JVM

Run a docker container with NLP libraries/frameworks writting in Java/JVM languages, running under the traditional Java 8 (from OpenJDK or another source) or GraalVM.

Find out more about [Natural Language Processing](https://en.wikipedia.org/wiki/Natural_language_processing) from the [NLP section](../../natural-language-processing/README.md) section.

Startup in traditional JDK or GraalVM mode.

## Goals

- Run docker container containing NLP libraries/frameworks written in Java/JVM languages
- Ability to create custom docker images (scripts & docs provided)
- Ability to debug the docker container
- Run using the traditional JDK (OpenJDK or vendor specific versions)
- Run using the polyglot JVM i.e. GraalVM JDK (Community version from Oracle Labs)
- Play with and learn from with some examples for each of the libraries provided

## Libraries / frameworks provided

- [Standford CoreNLP](https://stanfordnlp.github.io/CoreNLP/)
- [Apache OpenNLP](https://opennlp.apache.org/)
- [NLP4J: NLP Toolkit for JVM Languages](https://emorynlp.github.io/nlp4j/)
- [Word2vec in Java](https://deeplearning4j.org/docs/latest/deeplearning4j-nlp-word2vec)
- [ReVerb: Web-Scale Open Information Extraction](https://github.com/knowitall/reverb/)
- [OpenRegex: An efficient and flexible token-based regular expression language and engine](https://github.com/knowitall/openregex)
- [CogcompNLP: Core libraries developed in the U of Illinois' Cognitive Computation Group](https://github.com/datquocnguyen/RDRPOSTagger)
- [MALLET - MAchine Learning for LanguagE Toolkit](http://mallet.cs.umass.edu/)
- [RDRPOSTagger - A robust POS tagging toolkit available (in both Java & Python) together with pre-trained models for 40+ languages.](https://github.com/datquocnguyen/RDRPOSTagger)

## Scripts provided

**Go to [the previous folder](../nlp-java-jvm) to find the below scripts.**

- [runInDocker.sh](./runInDocker.sh) - runs the container and brings you to the command prompt inside the container
- [Base Dockerfile](./images/base/Dockerfile) | [Java Dockerfile](./images/java/Dockerfile): Dockerfile scripts to help build the base and language (i.e. java) specific docker image of NLP Java/JVM in an isolated environment with the necessary dependencies.
- [images folder](./images) - provided with scripts to build and the scripts included into the container for the base image and language (i.e. java) specific docker image
- [buildDockerImage.sh](./buildDockerImage.sh): build the docker base and language (i.e. java) specific image takes under 5 minutes to finish on a decent connection
- [push-nlp-java-docker-image-to-hub.sh](./push-nlp-java-docker-image-to-hub.sh) - push pre-built docker images to docker hub (please pass in your own Docker username and later on enter Docker login details, see usage below)
- [removeUnusedContainersAndImages.sh](./removeUnusedContainersAndImages.sh) - a housekeeping script to remove dangling images and terminated containers (helps save some diskspace)

## Usage

**Setting your environment**

Ensure your environment has the below variable set, or set it in your `.bashrc` or `.bash_profile` or the relevant startup script:

```bash
export DOCKER_USER_NAME="your_docker_username"
```

You must have an account on Docker hub under the above user name.

**Run the NLP Java/JVM docker container:**

```bash
$ ./runInDocker.sh
or
$ DOCKER_USER_NAME="your_docker_username" ./runInDocker.sh
or
or in debug mode
$ DEBUG="true" ./runInDocker.sh
or run in GraalVM mode
$ JDK_TO_USE="GRAALVM" ./runInDocker.sh
or run by switching off JVMCI flag (default: on)
$ JAVA_OPTS="-XX:-UseJVMCINativeLibrary" ./runInDocker.sh
```

**Build the docker container:**

```bash
$ ./buildDockerImage.sh
or
$ DOCKER_USER_NAME="your_docker_username" ./buildDockerImage.sh
or
$ IMAGE_VERSION="x.y.z" ./buildDockerImage.sh [language_id]
```
`[language_id]` defaults to `java` when not provided.

**Push built NLP Java/JVM docker image to Docker hub:**

```bash
$ ./push-nlp-java-docker-image-to-hub.sh
or
$ DOCKER_USER_NAME="your_docker_username" ./push-nlp-java-docker-image-to-hub.sh
or
$ IMAGE_VERSION="x.y.z" ./push-nlp-java-docker-image-to-hub.sh
```

The above will prompt the docker login name and password, before it can push your image to Docker hub (you must have an account on Docker hub).

**Docker image on Docker Hub**

Find the [NLP Java/JVM Docker Image on Docker Hub](https://hub.docker.com/r/neomatrix369/nlp-java). The `push-nlp-java-docker-image-to-hub.sh` script pushes the image to the Docker hub and the `runInDocker.sh` script runs it from the local repository. If absent, in the the local repository, it downloads this image from Docker Hub.

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../../CONTRIBUTING.md) guidelines, also have a read about our [licensing](../../LICENSE.md) policy.

---

Back to [main page (table of contents)](../../README.md)