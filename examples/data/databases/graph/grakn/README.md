# Grakn and Graql [![Grakn](https://img.shields.io/docker/pulls/neomatrix369/grakn.svg)](https://hub.docker.com/r/neomatrix369/grakn) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Run [Grakn and Graql](http://grakn.ai) in a docker container running under the traditional Java 8 (from OpenJDK or another source).

Find out more about [Grakn and Graql](http://grakn.ai) from the [Data](../../../../../data/README.md#databases) section.

On start, useful details including time to startup Grakn and duration for which Graql was run are printed.

Also, experimental usage of GraalVM, to take advantages of the performance benefits of this JVM. 

## Goals

- Run Grakn and Graql in a docker container
- Ability to create custom docker images (scripts & docs provided)
- Ability to debug the docker container
- Run using the traditional JDK (OpenJDK or vendor specific versions)
- Run using the polyglot JVM i.e. GraalVM JDK (Community version from Oracle Labs)
- Measure startup and execution times for the different JDKs used
- Run Grakn's native performance benchmarking scripts

## Scripts provided

**See in [the current folder](../grakn) to find the below scripts**

- [runGraknInDocker.sh](./runGraknInDocker.sh) - runs the container which then calls `startGraknAndGraql.sh` inside the container and the rest is history.  Exposes the Grakn port 4567, so the dashboard can be opened at http://localhost:8080. The graql console is also available in the window running the docker instance.
- [startGraknAndGraql.sh](./startGraknAndGraql.sh) - entry point script baked into the docker image
- [runPerformanceBenchmark.sh](./runPerformanceBenchmark.sh) - script baked into the docker image, run via the [runGraknInDocker.sh](./runGraknInDocker.sh) script
- [Dockerfile](./Dockerfile): a dockerfile script to help build a docker image of Grakn and Graql in an isolated environment with the necessary dependencies.
- [buildDockerImage.sh](./buildDockerImage.sh): build the docker image for grakn, takes under 10 minutes to finish on a decent connection
- [push-grakn-docker-image-to-hub.sh](./push-grakn-docker-image-to-hub.sh) - push pre-built docker image to docker hub (please pass in your own Docker username and later on enter Docker login details, see usage below)
- [removeUnusedContainersAndImages.sh](./removeUnusedContainersAndImages.sh) - a housekeeping script to remove dangling images and terminated containers (helps save some diskspace)

## Usage

### Setting your environment

**Note: you need to do the below only if you are trying to _build your own version_ of the Grakn Docker container and push to _your own Docker Hub repository_.**

Ensure your environment has the below variable set, or set it in your `.bashrc` or `.bash_profile` or the relevant startup script:

```bash
export DOCKER_USER_NAME="your_docker_username"
```
You must have an account on Docker hub under the above user name. 

### Run the Grakn docker container

```bash
$ ./runGraknInDocker.sh
or
$ DOCKER_USER_NAME="your_docker_username" ./runGraknInDocker.sh
or
$ GRAKN_VERSION="x.y.z" ./runGraknInDocker.sh
or in debug mode
$ DEBUG="true" ./runGraknInDocker.sh
or run in GraalVM mode
$ JDK_TO_USE="GRAALVM" ./runGraknInDocker.sh
or run by switching off JVMCI flag (default: on)
$ COMMON_JAVAOPTS="-XX:-UseJVMCINativeLibrary" ./runGraknInDocker.sh

or run the performance benchmarking script with default JDK
$ RUN_PERFORMANCE_SCRIPT=true ./runGraknInDocker.sh
or run the performance benchmarking script with GraalVM
$  JDK_TO_USE="GRAALVM" RUN_PERFORMANCE_SCRIPT=true ./runGraknInDocker.sh
```

See [successful run console](successful-run-console.md) - includes both outputs from the traditional JDK8 and GraalVM executions. 
In debug mode, the docker container prompt is returned, the Grakn and Graql instances are not executed.

### Build the Grakn docker container

See [Setting your environment](#setting-your-environment) before proceeding

```bash
$ ./buildDockerImage.sh
or
$ DOCKER_USER_NAME="your_docker_username" ./buildDockerImage.sh
or
$ GRAKN_VERSION="x.y.z" ./buildDockerImage.sh
```

**Push built Grakn docker image to Docker hub:**

See [Setting your environment](#setting-your-environment) before proceeding

```bash
$ ./push-grakn-docker-image-to-hub.sh
or
$ DOCKER_USER_NAME="your_docker_username" ./push-grakn-docker-image-to-hub.sh
or
$ GRAKN_VERSION="x.y.z" ./push-grakn-docker-image-to-hub.sh
```

The above will prompt the docker login name and password, before it can push your image to Docker hub (you must have an account on Docker hub).

### Docker image on Docker Hub

Find the [Grakn Docker Image on Docker Hub](https://hub.docker.com/r/neomatrix369/grakn). The `push-grakn-docker-image-to-hub.sh` script pushes the image to the Docker hub and the `runGraknInDocker.sh` script runs it from the local repository. If this is absent in your local repository, scripts download this image from the Docker Hub.

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../../../../../CONTRIBUTING.md) guidelines, also have a read about our [licensing](../../../../../LICENSE.md) policy.

---

Back to [Data](../../../../../data/README.md)</br>
Back to [main page (table of contents)](../../../../../README.md)