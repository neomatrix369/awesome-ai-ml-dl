# Grakn and Graql [![Grakn](https://img.shields.io/docker/pulls/neomatrix369/grakn.svg)](https://hub.docker.com/r/neomatrix369/grakn) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Run [Grakn and Graql](http://grakn.ai) in a docker container running under the traditional Java 8 (from OpenJDK or another source).

Find out more about [Grakn and Graql](http://grakn.ai) from the [Resources](#Resources) section below.

On start-up, useful details including time to start-up the Grakn server and duration for which Graql was run are printed.

Also, available experimental usage of GraalVM, to take advantages of the performance benefits of this JVM.

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

- [grakn_version.txt](grakn_version.txt) - save the version of Grakn used to build and run the docker container
- [graalvm_version.txt](graalvm_version.txt) - save the version of GraalVM used to build and run the docker container
- [Dockerfile](./Dockerfile): a dockerfile script to help build a docker image of Grakn and Graql in an isolated environment with the necessary dependencies.
- [grakn-runner.sh](grakn-runner.sh) - one script does it all, using CLI args, see script usage text:
```
$ ./grakn-runner.sh --help

       Usage: grakn-runner.sh --dockerUserName [Docker user name]
                                 --detach
                                 --debug
                                 --run-perf-scripts
                                 --jdk [GRAALVM]
                                 --javaopts [java opt arguments]
                                 --cleanup
                                 --buildImage
                                 --runContainer
                                 --pushImageToHub
                                 --help

       --dockerUserName      your Docker user name as on Docker Hub
                             (mandatory with build, run and push commands)
       --detach              run container and detach from it,
                             return control to console
       --debug               run docker container in interactive mode
                             (gives command-prompt to run commands inside the container)
       --run-perf-scripts    run performance script in interactive mode (can take a long time)
       --skip-graql          run the Grakn docker container in interacive mode
                             but do not start the Graql console, just the Grakn server
       --jdk                 name of the JDK to use (currently supports
                             GRAALVM only, default is blank which
                             enables the traditional JDK)
       --javaopts            sets the JAVA_OPTS environment variable
                             inside the container as it starts
       --cleanup             (command action) remove exited containers and
                             dangling images from the local repository
       --buildImage          (command action) build the docker image
       --runContainer        (command action) run the docker image as a docker container,
                             container will run without this command with selected and default params, in most cases
       --pushImageToHub      (command action) push the docker image built to Docker Hub
       --help                shows the script usage help text

```
The [grakn-runner.sh](grakn-runner.sh) script runs the container which then calls the respective scripts inside the container and the rest you can see by examing the script. It exposes the Grakn port 48555, so Workbase can be used to connect to http://localhost:48555. The graql console is also available in the window running the docker instance via a separate command (see usage text above).
- Run inside the Grakn docker container
    - [startGraknAndGraql.sh](./startGraknAndGraql.sh) - entry point script baked into the docker image
    - [builder.sh](./builder.sh) - build uberjar and native image from the uberjar for standalone execution (target for native-image is OS specific, uberjar can run on any JVM target), see script usage text:
    ```
               Usage: ./builder.sh --buildUberJar
                         --extract   [/path/to/JAR file]
                         --build     [/path/to/JAR file]
                         --test      [/path/to/native-image file]

               --buildUberJar                                build the Uber jar before building the native image
               --extract      [/path/to/JAR file]            extract the Jar file configuration information and
                                                             save into the META-INF folder
               --build        [/path/to/JAR file]            build the native image from the Jar file provided
               --test         [/path/to/native-image file]   test the native image
               --help                                        shows the script usage help text
     ```


### Performance Scripts provided
- [measureTradVersusGraalVMLoadTime.sh](./performance-benchmark-scripts/measureTradVersusGraalVMLoadTime.sh) - measure the startup time between traditional JDK and GraalVM (with JVMCI enabled and disabled), see [successful run console](successful-run-console.md) output generated from this script.
- [runPerformanceBenchmark.sh](./performance-benchmark-scripts/runPerformanceBenchmark.sh) - script baked into the docker image, run via the [runGraknInDocker.sh](./runGraknInDocker.sh) script. This usually takes a bit of time to finish due to the many steps it does with bazel and building [benchmark](https://github.com/graknlabs/benchmark). Also see the [performance script execution output](./performance-benchmark-scripts/output-from-running-performance-script.md).

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

or run Grakn server only (not run the Console: Graql)

$ SKIP_GRAQL="true" ./runGraknInDocker.sh

or run in GraalVM mode

$ JDK_TO_USE="GRAALVM" ./runGraknInDocker.sh

or run by switching off JVMCI flag (default: on)

$ COMMON_JAVAOPTS="-XX:-UseJVMCINativeLibrary" JDK_TO_USE="GRAALVM" ./runGraknInDocker.sh
```

### Run the scripts in the Grakn docker container

```
$ DEBUG="true" ./runGraknInDocker.sh
$  startGraknAndGraql.sh

Exiting the Graql Console takes you into the Docker container prompt. Also another way to run Grakn server but not use the Graql console prompt.    

or 

$  SKIP_GRAQL=true startGraknAndGraql.sh
```

### Run the performance script in the Grakn docker container

#### Automatically

```bash
Run the performance benchmarking script with default JDK

$ RUN_PERFORMANCE_SCRIPT=true ./runGraknInDocker.sh

or 

Run the performance benchmarking script with GraalVM

$  JDK_TO_USE="GRAALVM" RUN_PERFORMANCE_SCRIPT=true ./runGraknInDocker.sh
```

#### Manually

```bash
Run the performance benchmarking script with default JDK

$ DEBUG=true ./runGraknInDocker.sh
grakn@040eb5bd829c:~$ ./runPerformanceBenchmark.sh    # inside the container

or 

Run the performance benchmarking script with GraalVM

$  JDK_TO_USE="GRAALVM" DEBUG=true ./runGraknInDocker.sh
grakn@040eb5bd829c:~$ ./runPerformanceBenchmark.sh    # inside the container
```

See [successful run console](successful-run-console.md) - includes both outputs from the traditional JDK8 and GraalVM executions. In debug mode, the docker container prompt is returned, the Grakn and Graql instances are not executed. Please check out the history of [successful run console](successful-run-console.md) to see progress with previous runs under various versions of Grakn, GraalVM and other configuration settings.

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

### Resources

- [Home](https://grakn.ai)
- [GitHub](https://github.com/graknlabs) | [Grakn](https://github.com/graknlabs/Grakn) | [Graql](https://github.com/graknlabs/graql) | [benchmark](https://github.com/graknlabs/benchmark)
- [Twitter](https://twitter.com/@graknlabs)
- [LinkedIn](https://www.linkedin.com/company/graknlabs/) | [LinkedIn Community Group](https://www.linkedin.com/groups/13657731/)
- [Docs](https://dev.grakn.ai/docs/general/quickstart)
- [Blogs](https://blog.grakn.ai/) - also published on [Medium.com](https://medium.com)
- Community
  - [Slack](https://grakn.ai/slack)
  - [Discuss](https://discuss.grakn.ai/)
- Cloud
  - Grakn on AWS: [Grakn Profile (AWS Marketplace)](https://aws.amazon.com/marketplace/seller-profile?id=35eaf0dd-eda4-4b8d-b78a-443f6c619104)| [Grakn KGMS(AWS Marketplace)](https://aws.amazon.com/marketplace/pp/GRAKNAI-Grakn-KGMS/B07H8RMX5X) | [Deploy Grakn on AWS](https://dev.grakn.ai/docs/cloud-deployment/aws) | [Blog](https://blog.grakn.ai/grakn-kgms-is-now-on-aws-db871ecdb425)
  - Grakn on Google: [Deploy Grakn on Google](https://dev.grakn.ai/docs/cloud-deployment/google-cloud) | [GRAKN.AI with Google Bigtable via JanusGraph](https://blog.grakn.ai/grakn-ai-with-google-bigtable-via-janusgraph-cc46fd0958df) | [Blog](https://blog.grakn.ai/grakn-ai-on-google-cloud-f18f6692670c)

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../../../../../CONTRIBUTING.md) guidelines, also have a read about our [licensing](../../../../../LICENSE.md) policy.

---

Back to [Data](../../../../../data/README.md)</br>
Back to [main page (table of contents)](../../../../../README.md)