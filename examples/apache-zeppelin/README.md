# Apache Zeppelin [![Zeppelin](https://img.shields.io/docker/pulls/neomatrix369/zeppelin.svg)](https://hub.docker.com/r/neomatrix369/zeppelin) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Just like [JuPyteR notebooks](https://jupyter.org/), [Apache Zeppelin](http://zeppelin.apache.org/) gives us the facility to write notebooks using Java, Scala and other languages or better known as [interpreters](http://zeppelin.apache.org/docs/0.8.0/usage/interpreter/overview.html).

Enjoy writing prototypes, experiments or do some real work with it, in Java, Scala or any other intepreter of your choice.

# Scripts provided

- `Zeppelin-Dockerfile`: a dockerfile script to help build a docker image of Zeppelin 0.8.0 along with a standalone Spark instance running on GraalVM JRE
- `buildZeppelinDockerImage.sh`: build the Zeppelin-Dockerfile dockerfile, takes over 45 minutes to finish on a decent connection
- `runZeppelinDockerContainer.sh`: run the zeppelin docker image, exposing port 8080 to point your browser to ([http://localhost:8080](http://localhost:8080))
- `installDocker.sh`: install docker on a VM or bare-metal environment
- `push-apache-zeppelin-docker-image-to-hub.sh`: push a build Apache Zeppelin docker image to Docker Hub
- `removeUnusedContainersAndImages.sh`: remove stopped containers and dangling images to save space
- `version.txt`: counter to keep track of the current version of the Docker image

# Blogs

- [Apache Zeppelin: stairway to notes* haven!](https://www.javaadvent.com/2018/12/apache-zeppelin-stairway-to-notes-haven.html) 
- [Running Apache Zeppelin on Oracle Cloud Infrastructure](https://medium.com/@neomatrix369/running-apache-zeppelin-on-oracle-cloud-infrastructure-b0aecc79597a)

## Installation

### Local machine

- Download and unpack Apache Zeppelin from the [download page](https://zeppelin.apache.org/download.html)
- Ensure `JAVA_HOME` is pointing to a valid JDK, preferrably GraalVM, download from the [Oracle/Graal releases page](https://github.com/oracle/graal/releases)
- Run the below commands:

```
$ cd /opt/zeppelin-0.8.0-bin-netinst
$ ./bin/install-interpreter.sh --all
```

You will see the below:
```
Pid dir doesn&#039;t exist, create /opt/zeppelin-0.8.0-bin-netinst/run
GraalVM 1.0.0-rc7 warning: ignoring option MaxPermSize=512m; support was removed in 8.0
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/opt/zeppelin-0.8.0-bin-netinst/lib/interpreter/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/opt/zeppelin-0.8.0-bin-netinst/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
Dec 25, 2018 1:34:23 AM org.glassfish.jersey.internal.inject.Providers checkProviderRuntime
WARNING: A provider org.apache.zeppelin.rest.NotebookRepoRestApi registered in SERVER runtime does not implement any provider interfaces applicable in the SERVER runtime. Due to constraint configuration problems the provider org.apache.zeppelin.rest.NotebookRepoRestApi will be ignored.
Dec 25, 2018 1:34:23 AM org.glassfish.jersey.internal.inject.Providers checkProviderRuntime
Dec 25, 2018 1:34:23 AM org.glassfish.jersey.internal.inject.Providers checkProviderRuntime
[---- snipped ----]
WARNING: The (sub)resource method getNoteList in org.apache.zeppelin.rest.NotebookRestApi contains empty path annotation.
```
- Open the browser and go to http://localhost:8080
- You will see a screen like this in the browser:
![](https://miro.medium.com/max/1408/0*KgMaDrIt107dUpVb.png)

### Docker container

- Ensure you have access to this repo on your local machine
- Ensure Docker has been installed on your local machine
- Ensure the current user on your local machine is part of the `docker` group, see https://docs.docker.com/install/linux/linux-postinstall/ on how to do that
- Run the below commands:

```
$ git clone https://github.com/neomatrix369/awesome-ai-ml-dl/
$ cd examples/apache-zeppelin
$ docker pull neomatrix369/zeppelin:0.2
$ IMAGE_VERSION=0.2 ./runZeppelinDockerContainer.sh
```

You should see these messages:

```
ubuntu@instance-20191014-0101:~/awesome-ai-ml-dl/examples/apache-zeppelin$ IMAGE_VERSION=0.2 ./runZeppelinDockerContainer.sh
Please wait till the log messages stop moving, it will be a sign that the service is ready! (about a minute or so)
Once the service is ready, go to http://localhost:8080 to open the Apache Zeppelin homepage
Pid dir doesn't exist, create /zeppelin/run
OpenJDK GraalVM CE 19.0.0 warning: ignoring option MaxPermSize=512m; support was removed in 8.0
SLF4J: Class path contains multiple SLF4J bindings.
SLF4J: Found binding in [jar:file:/zeppelin/lib/interpreter/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: Found binding in [jar:file:/zeppelin/lib/slf4j-log4j12-1.7.10.jar!/org/slf4j/impl/StaticLoggerBinder.class]
SLF4J: See http://www.slf4j.org/codes.html#multiple_bindings for an explanation.
SLF4J: Actual binding is of type [org.slf4j.impl.Log4jLoggerFactory]
[---snipped---]
WARNING: A HTTP GET method, public javax.ws.rs.core.Response org.apache.zeppelin.rest.CredentialRestApi.getCredentials(java.lang.String) throws java.io.IOException,java.lang.IllegalArgumentException, should not consume any entity.
WARNING: The (sub)resource method createNote in org.apache.zeppelin.rest.NotebookRestApi contains empty path annotation.
WARNING: The (sub)resource method getNoteList in org.apache.zeppelin.rest.NotebookRestApi contains empty path annotation.
```
- Open the browser and go to http://localhost:8080
- You will see a screen like this in the browser:
![](https://miro.medium.com/max/1408/0*KgMaDrIt107dUpVb.png)

## Building Docker images

```
$ git clone https://github.com/neomatrix369/awesome-ai-ml-dl/
$ cd examples/apache-zeppelin

## version 0.1
$ DOCKER_USER_NAME=<your Docker Hub username> ./buildZeppelinDockerImage.sh

- or -

## version 0.2
$ DOCKER_USER_NAME=<your Docker Hub username> IMAGE_VERSION=0.2 ./buildZeppelinDockerImage.sh
```

## Pushing the built Docker image to Docker hub

Please run one of the below commands when the above steps are successful:

```
## version 0.1
$ DOCKER_USER_NAME=<your Docker Hub username> ./push-apache-zeppelin-docker-image-to-hub.sh

- or -

## version 0.2
$ DOCKER_USER_NAME=<your Docker Hub username> IMAGE_VERSION=0.2 ./push-apache-zeppelin-docker-image-to-hub.sh
```

You will need a valid account on Docker Hub.

# Writing Zeppelin interpreters

- https://zeppelin.apache.org/docs/0.6.0/development/writingzeppelininterpreter.html
- https://zeppelin.apache.org/docs/0.5.6-incubating/development/writingzeppelininterpreter.html
- https://zeppelin.apache.org/docs/0.5.6-incubating/rest-api/rest-interpreter.html

# Resources

- [Download page](https://zeppelin.apache.org/download.html)
- [Apache Zeppelin: Quick Start page](https://zeppelin.apache.org/docs/0.8.0/quickstart/install.html)
- [Exploring Zeppelin UI](https://zeppelin.apache.org/docs/0.8.0/quickstart/explore_ui.html)
- [https://issues.apache.org/jira/browse/ZEPPELIN-3586](https://issues.apache.org/jira/browse/ZEPPELIN-3586)
- https://gist.github.com/conker84/4ffc9a2f0125c808b4dfcf3b7d70b043#file-zeppelin-dockerfile
- [Notebook API](https://zeppelin.apache.org/docs/0.5.6-incubating/rest-api/rest-notebook.html)
- [Interpreter API](https://zeppelin.apache.org/docs/0.5.6-incubating/rest-api/rest-interpreter.html)
- Examples to try
  - https://github.com/dylanmei/docker-zeppelin
  - https://github.com/mmatloka/machine-learning-by-example-workshop
  - https://raw.githubusercontent.com/mmatloka/machine-learning-by-example-workshop/master/Workshop.json

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../../CONTRIBUTING.md) guidelines, also have a read about our [licensing](../../LICENSE.md) policy.

---

Back to [main page (table of contents)](../../README.md)