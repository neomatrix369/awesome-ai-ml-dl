## Docker container instructions

### Build the docker image

Build a docker image with Jupyter Notebook, JDK 9 (from the AdoptOpenJDK build farm) and set the necessary flags to enable the GraalVM compiler when running the Java Kernel inside the container.

This script depends on the `Dockerfile` which contains most of the logic and also executes [install-java-kernel.sh](install-java-kernel.sh) towards the end of the process.

```
$ [sudo] ./buildDockerImage.sh
```
or

```
$ [sudo] DOCKER_USER_NAME="you_docker_hub_username" ./buildDockerImage.sh
```

Creates a docker image by the name:

```
REPOSITORY                                TAG                 IMAGE ID            CREATED             SIZE
jupyter-java                              latest              17c1b2f81304        11 minutes ago      628MB
```
The whole build process is under 10 minutes depending on the network bandwidth and available machine resources.

`Python 2.7` is going to be installed by [install-java-kernel.sh](install-java-kernel.sh), but you can change the [Dockerfile](Dockerfile) docker script to use another version.

### Run the docker container

Once the image is built, a one-line command helps run it:

```
$ [sudo] ./runDockerContainer.sh
```

or 

```
$ [sudo] DOCKER_USER_NAME="you_docker_hub_username" ./runDockerContainer.sh
```

which runs the container and the [runLocal.sh](runLocal.sh) is executed inside the container. In theory, [runLocal.sh](runLocal.sh) should execute in the local environment, provided the necessary dependencies are installed (as done by the [buildDockerImage.sh](buildDockerImage.sh) script).

#### Scripts provided:

- [buildDockerImage.sh](buildDockerImage.sh): build the docker image using Dockerfile
    - [Dockerfile](Dockerfile): a dockerfile script to help build a docker image of Jupyter with the IJava kernel running on Java 9 (with Graal enabled)
        - [install-jupyter-notebooks.sh](install-jupyter-notebooks.sh): installs Jupyter notebook and its dependencies
        - [install-java-kernel.sh](install-java-kernel.sh): executed during building of the Docker container
- [runDockerContainer.sh](runDockerContainer.sh): run the Jupyter docker image, exposing port 8888 to point your browser to (http://localhost:8888)
    - [runLocal.sh](runLocal.sh): runs inside the docker container but can be also run on any local environment with the necessary dependencies installed
- [push-jupyter-java-docker-image-to-hub.sh](push-jupyter-java-docker-image-to-hub.sh): push the built docker image to Docker Hub. `DOCKER_USER_NAME` must be set in the environment or passed in on CLI, otherwise a default user name is assumed.

Note: the GraalVM compiler can be enabled starting Java 9 and this currently only works for Linux. But later versions support Linux, MacOS and Windows.

### Debug your running container

Set the environment variable `DEBUG` to `true` and it should do the job:

```
$ [sudo] DEBUG=true ./runDockerContainer.sh
```

or 

```
$ [sudo] DOCKER_USER_NAME="you_docker_hub_username" DEBUG=true ./runDockerContainer.sh

```

You will be provided with the below `bash` prompt:

```
*************************
* Running in Debug mode *
*************************

root@a659f75885b0:/jupyter-notebooks#
```

The `jupyter-notebook` instance will need to be started manually.