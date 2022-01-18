# Tribuo [![Tribuo](https://img.shields.io/docker/pulls/neomatrix369/tribuo.svg)](https://hub.docker.com/r/neomatrix369/tribuo) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)


---

Run a docker container with Tribuo (a ML Library, written in Java), running under the traditional Java 11 (from OpenJDK or another source) or GraalVM.

# Table of contents

- [Goals](#goals)
- [Tribuo examples: as a Java CLI app](#tribuo-examples-as-a-java-cli-app)
  - [native-image build (optional)](#native-image-build-optional)
- [Scripts provided](#scripts-provided)
- [Usage](#usage)
  - [Help](#help)
  - [Run the Tribuo docker container](#run-the-tribuo-docker-container)
  - [Other methods to run the container](#other-methods-to-run-the-container)
  - **[Run the Tribuo docker container in the cloud](./deployments/oci/README.md)**
- [Build the docker container](#build-the-docker-container)
- [Push built Tribuo docker image to Docker hub](#push-built-tribuo-docker-image-to-docker-hub)
- [Docker image on Docker Hub](#docker-image-on-docker-hub)
- [Presentation](../../presentations/awesome-ai-ml-dl/03-makeitweek-2020/README.md)
- [Contributing](#contributing)

## Goals

- Run docker container Tribuo
- Ability to create custom docker images (scripts & docs provided)
- Ability to debug the docker container
- Run using the traditional JDK 11 (OpenJDK or vendor specific versions)
- Run using the polyglot JVM i.e. GraalVM JDK (Community version from Oracle Labs), when running performing operations from the CLI 
- Play with and learn from with some examples for each of the libraries provided


## Tribuo examples: as a Java CLI app

Requirements before proceeding:
- Java 11 or higher
  - GraalVM CE or EE (to able to build a `native-image`) (optional)
- `JAVA_HOME` set correctly
- Maven 3.5 of higher

Run the Classification or Regression example as illustrated in the tutorial notebooks: [Classification](https://github.com/oracle/tribuo/blob/main/tutorials/irises-tribuo-v4.ipynb) | [Regression](https://github.com/oracle/tribuo/blob/main/tutorials/regression-tribuo-v4.ipynb) as a Java App run from the CLI.

Perform the below steps in order to be able to build and run the example provided in the [`src` folder](src/main/java/org/neomatrix369/tribuo) in this folder:

```
$ git clone https://github.com/neomatrix369/awesome-ai-ml-dl
$ cd awesome-ai-ml-dl/examples/tribuo

## build the Tribuo Machine uberjar (aka shadowjar)
$ mvn clean package

or 

$ ./gradlew clean build --info

# build only shadowJar
$ ./gradlew clean shadowJar --info


# using the builder.sh script
## build uber jar via mvn as the build tool
./builder.sh --uber-jar

## build uber jar via gradle as the build tool
./builder.sh --build-tool gradle --uber-jar
```



Once the artifact is built, you will see the artifact `target/tribuo-machine-1.0-with-dependencies.jar`, followed by this run this:

```bash
# classification example
$ time java -jar target/tribuo-machine-1.0-with-dependencies.jar

or 

$ time java -jar build/libs/tribuo-machine-1.0-with-dependencies.jar

or 

# regression example
$ time java -jar target/tribuo-machine-1.0-with-dependencies.jar --regression

or

$ time java -jar build/libs/tribuo-machine-1.0-with-dependencies.jar --regression
```

And you will see an output that looks like this:
```
~~~ Loading the data
Oct 13, 2020 6:06:36 PM org.tribuo.data.csv.CSVIterator getRow
WARNING: Ignoring extra newline at line 151
Training data size = 105, number of features = 4, number of classes = 3
Testing data size = 45, number of features = 4, number of classes = 3
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.
.
.
      "transformations" : [ ],
      "is-sequence" : "false",
      "is-dense" : "false",
      "class-name" : "org.tribuo.MutableDataset"
    },
    "class-name" : "org.tribuo.classification.sgd.linear.LinearSGDModel"
  }
}
java -jar target/tribuo-machine-1.0-with-dependencies.jar    1.61s user 0.14s system 176% cpu 0.993 total
```
See detailed [Classification output](outputs/tribuo-classification-example-output.txt) and [Regression output](outputs/tribuo-regression-example-output.txt).

### `native-image` build (optional)

Requirements before proceeding:
- JAR build with steps from previous section
- GraalVM CE (to able to build a `native-image`)
- [Optional] GraalVM EE (to able to build a profile-guided `native-image`)
- [Optional] UPX (https://upx.github.io) to further compress native-image

Please follow the below to be able to build a native-image from the already built jar:

```bash
## build native-image from the mvn built artifact (jar file in target folder)
./builder.sh --extract
./builder.sh --native-image

## or compress the resulting native-image file further (-9 for highest compression)
./builder.sh --compress-image 9 --native-image

## or to build profile-guided optimisation using GraalVM EE
./builder.sh --pgo --native-image

## or compress the resulting native-image file further (-9 for highest compression)
./builder.sh --compress-image 9 --pgo --native-image

## build native-image from the gradle built artifact (jar file in build/libs folder)
./builder.sh --build-tool gradle --extract
./builder.sh --build-tool gradle --native-image

## or to build profile-guided optimisation using GraalVM EE
./builder.sh --pgo --build-tool gradle --native-image

## or compress the resulting native-image file further (-9 for highest compression)
./builder.sh --compress-image 9 --pgo --build-tool gradle --native-image
```

You may some warnings and then get a binary to use (instead of the `jar`), see [native-image build output](outputs/native-image-build-output.log) and the [native-image overall run output](outputs/native-image-overall-run.log).

Once the native-image is built, you can run it with (no JDK dependencies needed):
```bash
# classification example
$ time ./tribuo-machine-1.0-with-dependencies
or
$ time ./tribuo-machine-1.0-with-dependencies-pgo   # build using --pgo option using GraalVM EE

or

# regression example
$ time ./tribuo-machine-1.0-with-dependencies --regression
or
$ time ./tribuo-machine-1.0-with-dependencies-pgo --regression   # build using --pgo option using GraalVM EE
```

You should see the same [Classification output](outputs/tribuo-classification-example-output.txt) and [Regression output](outputs/tribuo-regression-example-output.txt) as before.

_Note: You will also notice it runs faster than the `jar` version, of course this could change when the dataset and/or other end-to-end training/evaluation flow changes (**no speed guaranutees**, it will depend on various factors)._

## Scripts provided

**Scroll up to find the below provided scripts**

- [docker-runner.sh](./docker-runner.sh): can perform a number of the below actions depending on the flags passed to it:
    - runs the container and brings you to the command prompt inside the container:
    - build the Tribuo docker image takes under 5 minutes to finish on a decent connection 
    - push pre-built docker images to docker hub (please pass in your own Docker username and later on enter Docker login details, see usage below)
    - a housekeeping script to remove dangling images and terminated containers (helps save some diskspace)
- [docker-image folder](docker-image) - provided with scripts to build and the scripts included into the container for the Tribuo docker image

## Usage

### Help

```bash
$ ./docker-runner.sh --help
      Usage: ./docker-runner.sh --dockerUserName [Docker user name]
                                 --detach
                                 --jdk [GRAALVM]
                                 --javaopts [java opt arguments]
                                 --notebookMode
                                 --cleanup
                                 --buildImage
                                 --runContainer
                                 --pushImageToHub
                                 --help

       --dockerUserName      your Docker user name as on Docker Hub
                             (mandatory with build, run and push commands)
       --detach              run container and detach from it,
                             return control to console
       --jdk                 name of the JDK to use (currently supports
                             GRAALVM only, default is blank which
                             enables the traditional JDK)
       --javaopts            sets the JAVA_OPTS environment variable
                             inside the container as it starts
       --notebookMode        runs the Jupyter/Jupyhai notebook server
                             (default: opens the page in a browser)
       --cleanup             (command action) remove exited containers and
                             dangling images from the local repository
       --buildImage          (command action) build the docker image
       --runContainer        (command action) run the docker image as a docker container
       --pushImageToHub      (command action) push the docker image built to Docker Hub
       --help                shows the script usage help text
```

### Run the Tribuo docker container

#### Run the Jupyter/Jupyhai notebook server and open it the browser
```bash

$ ./docker-runner.sh --notebookMode --runContainer

### (The example Tribuo notebooks can be found in the tribuo/tuturials folder
### (remember container ID published in the console)
```

![Screen Shot 2020-12-25 at 19 56 52](https://user-images.githubusercontent.com/1570917/103141634-e13d8c00-46ee-11eb-8022-860fb8416500.png). **Please watch [this  video](https://youtu.be/2daclN-yAfI?list=PLUz6BqeCy21SXbOTMV5uRs5buGoYaW-Qu&t=2020) to learn how to navigate through the cells and run the cells of the notebook or the whole notebook.**

_[Optional] To start a second session in the above running instance, do the below:_
```bash
$ docker exec -it [CONTAINER_ID] /bin/bash"

### (apply above the container ID published in the previous console)
```

#### Run the docker container to the command prompt

```bash
$ ./docker-runner.sh --runContainer
```

### Other methods to run the container

```bash
$ ./docker-runner.sh --runContainer --dockerUserName [your docker user name]

or run in GraalVM mode

$ ./docker-runner.sh --runContainer --jdk "GRAALVM"

or run by switching off JVMCI flag (default: on) when running in GRAALVM mode

$ ./docker-runner.sh --javaopts "-XX:-UseJVMCINativeLibrary"
```

### Build the docker container

Ensure your environment has the below variable set, or set it in your `.bashrc` or `.bash_profile` or the relevant startup script:

```bash
export DOCKER_USER_NAME="your_docker_username"
```

You must have an account on Docker hub under the above user name.


```bash
$ ./docker-runner.sh --buildImage

orgr

$ ./docker-runner.sh --buildImage --dockerUserName "your_docker_username"
```

### Push built Tribuo docker image to Docker hub

```bash
$ ./docker-runner.sh --pushImageToHub

or

$ ./docker-runner.sh --pushImageToHub --dockerUserName "your_docker_username"
```

The above will prompt the docker login name and password, before it can push your image to Docker hub (you must have an account on Docker hub).

### Docker image on Docker Hub

Find the [Tribuo Docker Image on Docker Hub](https://hub.docker.com/r/neomatrix369/tribuo). The `docker-runner.sh --pushImageToHub` script pushes the image to the Docker hub and the `docker-runner.sh --runContainer` script runs it from the local repository. If absent, in the the local repository, it downloads this image from Docker Hub.

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](CONTRIBUTING.md) guidelines, also have a read about our [licensing](LICENSE.txt) policy.

---

Go to [Java/JVM Machine Learning page](../../details/java-jvm.md#javajvm) </br>
Go to [Main page](../../README.md)