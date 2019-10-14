# Apache Zeppelin [![Zeppelin](https://img.shields.io/docker/pulls/neomatrix369/zeppelin.svg)](https://hub.docker.com/r/neomatrix369/zeppelin) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Just like [JuPyteR notebooks](https://jupyter.org/), [Apache Zeppelin](http://zeppelin.apache.org/) gives us the facility to write notebooks using Java, Scala and other languages or better known as [interpreters](http://zeppelin.apache.org/docs/0.8.0/usage/interpreter/overview.html).

Scripts provided:

- `Zeppelin-Dockerfile`: a dockerfile script to help build a docker image of Zeppelin 0.8.0 along with a standalone Spark instance running on GraalVM JRE
- `buildZeppelinDockerImage.sh`: build the Zeppelin-Dockerfile dockerfile, takes over 45 minutes to finish on a decent connection
- `runZeppelinDockerContainer.sh`: run the zeppelin docker image, exposing port 8080 to point your browser to ([http://localhost:8080](http://localhost:8080))
- `installDocker.sh`: install docker on a VM or bare-metal environment
- `push-apache-zeppelin-docker-image-to-hub.sh`: push a build Apache Zeppelin docker image to Docker Hub
- `removeUnusedContainersAndImages.sh`: remove stopped containers and dangling images to save space
- `version.txt`: counter to keep track of the current version of the Docker image

See blog post on [Apache Zeppelin: stairway to notes* haven!](https://www.javaadvent.com/2018/12/apache-zeppelin-stairway-to-notes-haven.html) and [Running Apache Zeppelin on Oracle Cloud Infrastructure](https://medium.com/@neomatrix369/running-apache-zeppelin-on-oracle-cloud-infrastructure-b0aecc79597a) for further illustration on how to use the scripts in this folder.

Enjoy writing prototypes, experiments or do some real work with it, in Java, Scala or any other intepreter of your choice.

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