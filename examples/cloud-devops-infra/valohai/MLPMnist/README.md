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

### Build run

```
./runMLPMnist.sh
```


### Run in docker container

```
./runDockerContainer.sh
```

At the prompt in the container:

```
./runMLPMnist.sh
```