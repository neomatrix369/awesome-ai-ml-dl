# Docker environment

### Setting your environment

Ensure your environment has the below variable set, or set it in your `.bashrc` or `.bash_profile` or the relevant startup script:

```bash
export DOCKER_USER_NAME="your_docker_username"
```

You must have an account on Docker hub under the above user name.


### Build a docker image with the necessary dependencies

```bash
    $ ./buildDockerImage.sh
    or
    $ DOCKER_USER_NAME="your_docker_username" ./buildDockerImage.sh
    or
    $ IMAGE_VERSION="x.y.z" ./buildDockerImage.sh
```


### Run the docker container to start running the programs

```bash
    $ ./runDockerImage.sh
    or
    $ DOCKER_USER_NAME="your_docker_username" ./runDockerImage.sh
    or
    $ IMAGE_VERSION="x.y.z" ./runDockerImage.sh
    or run in Debug mode
    $ DEBUG="true" ./runDockerImage.sh
```


### Push built Better NLP docker image to Docker hub

```bash
$ ./push-better-nlp-docker-image-to-hub.sh
or
$ DOCKER_USER_NAME="your_docker_username" ./push-better-nlp-docker-image-to-hub.sh
or
$ IMAGE_VERSION="x.y.z" ./push-better-nlp-docker-image-to-hub.sh
```

The above will prompt the docker login name and password, before it can push your image to Docker hub (you must have an account on Docker hub).


### Docker image on Docker Hub

Find the [Better NLP Image on Docker Hub](https://hub.docker.com/r/neomatrix369/better-nlp). The `push-better-nlp-docker-image-to-hub.sh` script pushes the image to the Docker hub and the `runDockerImage.sh` script runs it from the local repository. If absent, in the the local repository, it downloads this image from Docker Hub.


[Return to main page](../README.md)