### Run the Grakn docker container

```bash
$ ./grakn-runner.sh --runContainer

or

$ ./grakn-runner.sh --dockerUserName "your_docker_username" --runContainer

or

$ GRAKN_VERSION="x.y.z" ./grakn-runner.sh --runContainer

or in debug mode

$ ./grakn-runner.sh --debug --runContainer

or run Grakn server only (not run the Console: Graql)

$ ./grakn-runner.sh --run-grakn-only --runContainer

or run in GraalVM mode

$ ./grakn-runner.sh --jdk GRAALVM --runContainer

or run by switching off JVMCI flag (default: on)

$ ./grakn-runner.sh --jdk GRAALVM --javaopts "-XX:-UseJVMCINativeLibrary" JDK_TO_USE="GRAALVM" --runContainer
```

### Run the scripts in the Grakn docker container

```
$ ./grakn-runner.sh --debug --runContainer
$ startGraknAndGraql.sh

Exiting the Graql Console takes you into the Docker container prompt. Also another way to run Grakn server but not use the Graql console prompt.    

or 

$  RUN_GRAKN_ONLY=true startGraknAndGraql.sh
```


---

[back to README](./../README.md)