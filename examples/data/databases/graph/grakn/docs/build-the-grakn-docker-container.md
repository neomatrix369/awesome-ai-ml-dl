## Build the Grakn docker container

See [Setting your environment](../README.md#setting-your-environment) before proceeding

```bash
$ ./buildDockerImage.sh
or
$ DOCKER_USER_NAME="your_docker_username" ./buildDockerImage.sh
or
$ GRAKN_VERSION="x.y.z" ./buildDockerImage.sh
```

**Push built Grakn docker image to Docker hub:**

See [Setting your environment](../README.md#setting-your-environment) before proceeding

```bash
$ ./push-grakn-docker-image-to-hub.sh
or
$ DOCKER_USER_NAME="your_docker_username" ./push-grakn-docker-image-to-hub.sh
or
$ GRAKN_VERSION="x.y.z" ./push-grakn-docker-image-to-hub.sh
```

The above will prompt the docker login name and password, before it can push your image to Docker hub (you must have an account on Docker hub).

---

[back to README](./../README.md)