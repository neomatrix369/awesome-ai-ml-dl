# Tribuo [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)


---

Run a docker container with Tribuo (a ML Library, written in Java), running under the traditional Java 11 (from OpenJDK or another source) or GraalVM.

## Goals

- Run docker container Tribuo
- Ability to create custom docker images (scripts & docs provided)
- Ability to debug the docker container
- Run using the traditional JDK 11 (OpenJDK or vendor specific versions)
- Run using the polyglot JVM i.e. GraalVM JDK (Community version from Oracle Labs), when running performing operations from the CLI 
- Play with and learn from with some examples for each of the libraries provided

## Scripts provided

**Scroll up to find the below provided scripts**

- [docker-runner.sh](./docker-runner.sh): can perform a number of the below actions depending on the flags passed to it:
    - runs the container and brings you to the command prompt inside the container:
    - build the Tribuo docker image takes under 5 minutes to finish on a decent connection 
    - push pre-built docker images to docker hub (please pass in your own Docker username and later on enter Docker login details, see usage below)
    - a housekeeping script to remove dangling images and terminated containers (helps save some diskspace)
- [docker-image folder](docker-image) - provided with scripts to build and the scripts included into the container for the Tribuo docker image

## Usage

**Help:**

```bash
$ ./docker-runner.sh --help

       Usage: ./docker-runner.sh --dockerUserName [docker user name]
                                 --detach
                                 --buildImage
                                 --runContainer
                                 --pushImageToHub
                                 --cleanup
                                 --help

       --dockerUserName      docker user name as on Docker Hub
                             (mandatory with build and push commands)
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

**Run the Tribuo docker container:**

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
$ ./docker-runner.sh --buildImage

orgr

$ ./docker-runner.sh --buildImage --dockerUserName "your_docker_username"
```

**Push built Tribuo docker image to Docker hub:**

```bash
$ ./docker-runner.sh --pushImageToHub

or

$ ./docker-runner.sh --pushImageToHub --dockerUserName "your_docker_username"
```

The above will prompt the docker login name and password, before it can push your image to Docker hub (you must have an account on Docker hub).

**Docker image on Docker Hub**

Find the [Tribuo Docker Image on Docker Hub](https://hub.docker.com/r/neomatrix369/tribuo). The `docker-runner.sh --pushImageToHub` script pushes the image to the Docker hub and the `docker-runner.sh --runContainer` script runs it from the local repository. If absent, in the the local repository, it downloads this image from Docker Hub.

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](CONTRIBUTING.md) guidelines, also have a read about our [licensing](LICENSE.txt) policy.

---

Go to [Machine Learning page](../README.md#machine-learning)