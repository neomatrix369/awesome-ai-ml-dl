# Dataiku Data Science Studio (DSS) [![Dataiku DSS](https://img.shields.io/docker/pulls/neomatrix369/dataiku-dss.svg)](https://hub.docker.com/r/neomatrix369/dataiku-dss) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Run [Dataiku Data Science Studio (DSS)](http://dataiku.com) in a docker container running under the traditional Java 8 (from OpenJDK or another source) or GraalVM.

Find out more about [Dataiku DSS](http://dataiku.com) from the [Data](../../../data/about-Dataiku.md) section.

On start up, useful details including time to startup Dataiku DSS and duration for which it runs are printed.

Also, experimental usage of GraalVM, to take advantages of the performance benefits of this JVM. 

## Goals

- Run Dataiku DSS in a docker container
- Ability to create custom docker images (scripts & docs provided)
- Ability to debug the docker container
- Run using the traditional JDK (OpenJDK or vendor specific versions)
- Run using the polyglot JVM i.e. GraalVM JDK (Community version from Oracle Labs)
- Measure startup and execution times for the different JDKs used

## Scripts provided

**Go to [the previous folder](../dataiku) to find the below scripts.**

- [runDssInDocker.sh](./runDssInDocker.sh) - runs the container which then calls `runDSS.sh` inside the container and the rest is history.  Exposes the Dss port 10000, so the dashboard can be opened at http://localhost:10000.
- [Dockerfile](./Dockerfile): a dockerfile script to help build a docker image of Dataiku DSS in an isolated environment with the necessary dependencies.
- [buildDockerImage.sh](./buildDockerImage.sh): build the docker image for Dataiku DSS, takes under 5 minutes to finish on a decent connection
- [push-dss-docker-image-to-hub.sh](./push-dss-docker-image-to-hub.sh) - push pre-built docker image to docker hub (please pass in your own Docker username and later on enter Docker login details, see usage below)
- [removeUnusedContainersAndImages.sh](./removeUnusedContainersAndImages.sh) - a housekeeping script to remove dangling images and terminated containers (helps save some diskspace)

## Usage

**Setting your environment**

Ensure your environment has the below variable set, or set it in your `.bashrc` or `.bash_profile` or the relevant startup script:

```bash
export DOCKER_USER_NAME="your_docker_username"
```

You must have an account on Docker hub under the above user name.

**Run the Dataiku DSS docker container:**

```bash
$ ./runDssInDocker.sh
or
$ DOCKER_USER_NAME="your_docker_username" ./runDssInDocker.sh
or
$ DSS_VERSION="x.y.z" ./runDssInDocker.sh
or in debug mode
$ DEBUG="true" ./runDssInDocker.sh
or run in GraalVM mode
$ JDK_TO_USE="GRAALVM" ./runDssInDocker.sh
or run by switching off JVMCI flag (default: on)
$ JAVA_OPTS="-XX:-UseJVMCINativeLibrary" ./runDssInDocker.sh
```

See [successful run console](successful-run-console.md) - includes both outputs from the traditional JDK8 and GraalVM executions. 
In debug mode, the docker container prompt is returned, the Dataiku DSS instances are not executed.

**Build the Dss docker container:**

```bash
$ ./buildDockerImage.sh
or
$ DOCKER_USER_NAME="your_docker_username" ./buildDockerImage.sh
or
$ DSS_VERSION="x.y.z" ./buildDockerImage.sh
```

**Push built Dataiku DSS docker image to Docker hub:**

```bash
$ ./push-dss-docker-image-to-hub.sh
or
$ DOCKER_USER_NAME="your_docker_username" ./push-dss-docker-image-to-hub.sh
or
$ DSS_VERSION="x.y.z" ./push-dss-docker-image-to-hub.sh
```

The above will prompt the docker login name and password, before it can push your image to Docker hub (you must have an account on Docker hub).

**Docker image on Docker Hub**

Find the [Dataiku DSS Docker Image on Docker Hub](https://hub.docker.com/r/neomatrix369/dataiku-dss). The `push-dss-docker-image-to-hub.sh` script pushes the image to the Docker hub and the `runDssInDocker.sh` script runs it from the local repository. If absent, in the the local repository, it downloads this image from Docker Hub.

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../../../CONTRIBUTING.md) guidelines, also have a read about our [licensing](../../../LICENSE.md) policy.

---

Back to [Data](../../../data/README.md)</br>
Back to [main page (table of contents)](../../../README.md)