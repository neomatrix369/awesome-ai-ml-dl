## Docker container instructions

### Build the docker image

Build a docker image with Jupyter Notebook, JDK 9 (from the AdoptOpenJDK build farm) and set the necessary flags to enable the GraalVM compiler when running the Java Kernel inside the container.

This script depends on the `Dockerfile` which contains most of the logic and also executes [install-java-kernel.sh](./build-docker-image/install-java-kernel.sh) towards the end of the process.

```
$ cd build-docker-image
```

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

`Python 2.7` is going to be installed by [install-java-kernel.sh](./build-docker-image/install-java-kernel.sh), but you can change the [Dockerfile](./build-docker-image/Dockerfile) docker script to use another version.

### Run the docker container

Once the image is built, a one-line command helps run it:

```
$ cd build-docker-image
```

```
$ [sudo] ./runDockerContainer.sh
```

or 

```
$ [sudo] DOCKER_USER_NAME="you_docker_hub_username" ./runDockerContainer.sh
```

which runs the container and the [runLocal.sh](./build-docker-image/runLocal.sh) is executed inside the container. In theory, [runLocal.sh](./build-docker-image/runLocal.sh) should execute in the local environment, provided the necessary dependencies are installed (as done by the [buildDockerImage.sh](./build-docker-image/buildDockerImage.sh) script).

#### Scripts provided:

All the scripts will be found on the `build-docker-image` folder:

- [buildDockerImage.sh](./build-docker-image/buildDockerImage.sh): build the docker image using Dockerfile
    - [Dockerfile](./build-docker-image/Dockerfile): a dockerfile script to help build a docker image of Jupyter with the IJava kernel running on Java 9 (with Graal enabled)
        - [install-jupyter-notebooks.sh](./build-docker-image/install-jupyter-notebooks.sh): installs Jupyter notebook and its dependencies
        - [install-java-kernel.sh](./build-docker-image/install-java-kernel.sh): executed during building of the Docker container
    - [removeUnusedContainersAndImages.sh](./build-docker-image/removeUnusedContainersAndImages.sh)  - clean up after a build, removes dangling images and closed/exited containers
- [runDockerContainer.sh](runDockerContainer.sh): run the Jupyter docker image, exposing port 8888 to point your browser to (http://localhost:8888)
    - [runLocal.sh](./build-docker-image/runLocal.sh): runs inside the docker container but can be also run on any local environment with the necessary dependencies installed
- [push-jupyter-java-docker-image-to-hub.sh](./build-docker-image/push-jupyter-java-docker-image-to-hub.sh): push the built docker image to Docker Hub. `DOCKER_USER_NAME` must be set in the environment or passed in on CLI, otherwise a default user name is assumed

Note: the GraalVM compiler can be enabled starting Java 9 and this currently only works for Linux. But later versions support Linux, MacOS and Windows. See [Switches to enable the GraalVM compiler in Java 9](./README.md#switches-to-enable-the-graalvm-compiler-in-java-9) in [README.md](README.md).

### Debug your running container

Set the environment variable `DEBUG` to `true` and it should do the job:

```
$ [stay or switch into the project root folder]
```

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

root@a659f75885b0:/home/jupyter#
```

The `/home/jupyter` instance will need to be started manually.