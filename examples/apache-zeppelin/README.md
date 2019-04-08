# Apache Zeppelin

Just like [JuPyteR notebooks](https://jupyter.org/), [Zeppelin](http://zeppelin.apache.org/) gives us the facility to write notebooks using Java, Scala and other languages or better known as [interpreters](http://zeppelin.apache.org/docs/0.8.0/usage/interpreter/overview.html).

Scripts provided:

- Zeppelin-Dockerfile: a dockerfile script to help build a docker image of Zeppelin 0.8.0 along with a standalone Spark instance running on GraalVM JRE
- buildZeppelinDockerImage.sh: build the Zeppelin-Dockerfile dockerfile, takes over 45 minutes to finish on a decent connection
- runZeppelinDockerContainer.sh: run the zeppelin docker image, exposing port 8080 to point your browser to (http://localhost:8080)

See blog post on [Apache Zeppelin: stairway to notes* haven!](https://www.javaadvent.com/2018/12/apache-zeppelin-stairway-to-notes-haven.html) on further illustration on how to use the scripts in this folder.

Enjoy writing prototypes, experiments or do some real work with it, in Java, Scala or any other intepreter of your choice.

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../../CONTRIBUTING.md) guidelines, also have a read about our [licensing](../../LICENSE.md) policy.

---

Back to [main page (table of contents)](../../README.md)