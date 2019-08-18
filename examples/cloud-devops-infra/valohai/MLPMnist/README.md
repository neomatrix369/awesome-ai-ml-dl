# MLPMNist Single Layer

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
./runMLPMnist.sh
```

### Run app in docker container

```
./runDockerContainer.sh
```

At the prompt in the container:

```
./runMLPMnist.sh
```

## Credits

This example has been inspired by the [MLPMNist example](https://github.com/deeplearning4j/dl4j-examples/tree/master/dl4j-examples/src/main/java/org/deeplearning4j/examples/feedforward/mnist) example from DL4J. Credits to the original authors of this example on https://github.com/deeplearning4j/dl4j-examples.