# MLPMNist Single Layer

MLPMNist using DL4J: [![MLPMNist using DL4J](https://img.shields.io/docker/pulls/neomatrix369/dl4j-mnist-single-layer.svg)](https://hub.docker.com/r/neomatrix369/dl4j-mnist-single-layer)

---

Open built-in Terminal from the Android Studio or IntelliJ IDEA. 
If you prefer, use the terminal app on your computer.
In the terminal window, `cd` to the project root directory `MLPMnist` if not already in.
(_you can use IDE's run-configuration green run button, if you like._)

### Build app

```
mvn package -Djavacpp.platform=linux-x86_64
or
mvn package -Djavacpp.platform=macos-x86_64
or
mvn package -Djavacpp.platform=windows-x86_64
```

### Build app for the docker image


#### Build docker image

```
./buildUberJar.sh
./buildDockerImage.sh
```

#### Push to docker hub

```
./push-docker-image-to-hub.sh
```

### Run app local

```
./runMLPMnist.sh --action train --output-dir /path/to/model/creation/folder
```

followed by

```
./runMLPMnist.sh --action evaluate --output-dir /path/to/model/folder
```

Model file created and seeked for in the respective cases, is called `mlpmnist-single-layer.pb`.

### Run app in docker container

```
./runDockerContainer.sh
```

At the prompt in the container, do the same as mentioned in section [Run app local](#run-app-local).

## Credits

This example has been inspired by the [MLPMNist example](https://github.com/deeplearning4j/dl4j-examples/tree/master/dl4j-examples/src/main/java/org/deeplearning4j/examples/feedforward/mnist) example from DL4J. Credits to the original authors of this example on https://github.com/deeplearning4j/dl4j-examples.

---

Back to [main page (table of contents)](../../../../README.md#awesome-ai-ml-dl-)