# Grakn and Graql [![Grakn](https://img.shields.io/docker/pulls/neomatrix369/grakn.svg)](https://hub.docker.com/r/neomatrix369/grakn) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

Run [Grakn and Graql](http://grakn.ai) in a docker container running under the traditional Java 8 (from OpenJDK or another source).

Find out more about [Grakn and Graql](http://grakn.ai) from the [Resources](#Resources) section below.

On start-up, useful details including time to start-up the Grakn server and duration for which Graql was run are printed.

Also, available experimental usage of GraalVM, to take advantages of the performance benefits of this JVM.

- [Goals](#goals)
- [Scripts provided](#scripts-provided)
  - [Performance Scripts provided](#performance-scripts-provided)
- [Usage](#usage)
  - [Setting your environment](#setting-your-environment)
  - [Running Grakn docker container](#running-grakn-docker-container)
  - [Run the performance script in the Grakn docker container](#run-the-performance-script-in-the-grakn-docker-container)
  - [Build the Grakn docker container](#build-the-grakn-docker-container)
  - [Docker image on Docker Hub](#docker-image-on-docker-hub)
  - [Building Grakn](#building-grakn)
    - [Known issues doing the above](#known-issues-doing-the-above)
- [Graql](#graql)
  - [English-to-Graql](#english-to-graql)
  - [Graql-to-English](#graql-to-english)
- [Resources](#resources)

--- 

## Goals

- Run Grakn and Graql in a docker container
- Ability to create custom docker images (scripts & docs provided)
- Ability to debug the docker container
- Run using the traditional JDK (OpenJDK or vendor specific versions)
- Run using the polyglot JVM i.e. GraalVM JDK (Community version from Oracle Labs)
- Measure startup and execution times for the different JDKs used
- Run Grakn's native performance benchmarking scripts

## Scripts provided

See [Scripts provided](./docs/scripts-provided.md).

### Performance Scripts provided

- [measureTradVersusGraalVMStartupTime.sh](./performance-benchmark-scripts/measureTradVersusGraalVMStartupTime.sh) - measure the startup time between traditional JDK and GraalVM (with JVMCI enabled and disabled), see [successful run console](./docs/successful-run-console.md) output generated from this script.
- [runPerformanceBenchmark.sh](./performance-benchmark-scripts/runPerformanceBenchmark.sh) - script baked into the docker image, run via the [grakn-runner.sh](./grakn-runner.sh) script (see usage text to find out how to run it). This usually takes a bit of time to finish due to the many steps it does with bazel and building [benchmark](https://github.com/graknlabs/benchmark). Also see the [performance script execution output](./performance-benchmark-scripts/output-from-running-performance-script.md).

## Usage

### Setting your environment

**Note: you need to do the below only if you are trying to _build your own version_ of the Grakn Docker container and push to _your own Docker Hub repository_. Otherwise you can skip this section and move on.**

Ensure your environment has the below variable set, or set it in your `.bashrc` or `.bash_profile` or the relevant startup script:

```bash
export DOCKER_USER_NAME="your_docker_username"
```
You must have an account on Docker hub under the above user name. 

### Running Grakn docker container

See [Grakn Docker container](./docs/grakn-docker-container.md)

### Run the performance script in the Grakn docker container

See [Run the performance script](./docs/run-the-performance-script.md)

### Build the Grakn docker container

See [Build the Grakn docker container](./docs/build-the-grakn-docker-container.md)

### Docker image on Docker Hub

Find the [Grakn Docker Image on Docker Hub](https://hub.docker.com/r/neomatrix369/grakn). The `./grakn-runner.sh --pushImageToHub` command pushes the image to the Docker hub and the `./grakn-runner.sh --runContainer` script runs it from the local repository. If this is absent in your local repository, scripts download this image from the Docker Hub.

### Building Grakn

See [Building Grakn](./docs/building-grakn.md)

#### Known issues doing the above

- [java.lang.NoClassDefFoundError: Lorg/codehaus/janino/ScriptEvaluator](https://github.com/oracle/graal/issues/1943) - moving back to GraalVM CE 19.2.1 seem to have resolved the issue.
- [6 Unsupported features exception (log4j might be one of the reasons)](https://github.com/oracle/graal/issues/2115) - being discussed with the GraalVM team.

## Graql

See [Graql README](./graql/README.md)

### English-to-Graql

See [English-to-Graql](./graql/English-to-Graql.md)

### Graql-to-English

See [Graql-to-English](./graql/Graql-to-English.md)

## Resources

- [Home](https://grakn.ai)
- [GitHub](https://github.com/graknlabs) | [Grakn](https://github.com/graknlabs/Grakn) | [Graql](https://github.com/graknlabs/graql) | [benchmark](https://github.com/graknlabs/benchmark)
- [Twitter](https://twitter.com/@graknlabs)
- [LinkedIn](https://www.linkedin.com/company/graknlabs/) | [LinkedIn Community Group](https://www.linkedin.com/groups/13657731/)
- [Docs](https://dev.grakn.ai/docs/general/quickstart)
- [Blogs](https://blog.grakn.ai/) - also published on [Medium.com](https://medium.com)
- Graql example schemas/data
  - Friendship: [schema](https://dev.grakn.ai/docs/general/quickstart#the-schema) | [data](https://dev.grakn.ai/docs/general/quickstart#download-and-load-the-complete-schema)
  - [Explore Schemas](https://github.com/graknlabs/examples#explore-schemas) 
- Community
  - [DiscordApp](https://discordapp.com/invite/graknlabs) | ~[Slack](https://grakn.ai/slack)~
  - [Discuss](https://discuss.grakn.ai/)
  - [Videos](https://youtube.com/c/graknlabs)
- Cloud
  - Grakn on AWS: [Grakn Profile (AWS Marketplace)](https://aws.amazon.com/marketplace/seller-profile?id=35eaf0dd-eda4-4b8d-b78a-443f6c619104)| [Grakn KGMS(AWS Marketplace)](https://aws.amazon.com/marketplace/pp/GRAKNAI-Grakn-KGMS/B07H8RMX5X) | [Deploy Grakn on AWS](https://dev.grakn.ai/docs/cloud-deployment/aws) | [Blog](https://blog.grakn.ai/grakn-kgms-is-now-on-aws-db871ecdb425)
  - Grakn on Google: [Deploy Grakn on Google](https://dev.grakn.ai/docs/cloud-deployment/google-cloud) | [GRAKN.AI with Google Bigtable via JanusGraph](https://blog.grakn.ai/grakn-ai-with-google-bigtable-via-janusgraph-cc46fd0958df) | [Blog](https://blog.grakn.ai/grakn-ai-on-google-cloud-f18f6692670c)

## Disclaimer

All the code and scripts container in this folder `grakn` are a proof-of-concept work to illustrate use-case(s) and usage scenarios. It is not mean to be a full-fledge solution and is adapted to show-case certain scenarios and hence all of the behaviours are in that order.

The code (this repo) and the referred datasets (see Grakns' docs and git repos)are available as F/OSS. The code is available here under the Apache license, see [license.txt](../license.txt) and can be used/changed accordingly. Grakn's resources are available under their said licenses (please check accordingly).


# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../../../../../CONTRIBUTING.md) guidelines, also have a read about our [licensing](../../../../../LICENSE.md) policy.

---

Back to [Data](../../../../../data/README.md)</br>
Back to [main page (table of contents)](../../../../../README.md)
