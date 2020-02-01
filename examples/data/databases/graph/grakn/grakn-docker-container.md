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


---

[back to README](./README.md)