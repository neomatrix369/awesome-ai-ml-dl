## Scripts provided

**See in [the current folder](../../grakn) to find the below scripts**

- [grakn_version.txt](../grakn_version.txt) - save the version of Grakn used to build and run the docker container
- [graalvm_version.txt](../graalvm_version.txt) - save the version of GraalVM used to build and run the docker container
- [Dockerfile](..//Dockerfile): a dockerfile script to help build a docker image of Grakn and Graql in an isolated environment with the necessary dependencies.
- [grakn-runner.sh](../grakn-runner.sh) - one script does it all, using CLI args, see script usage text:
```
$ ./grakn-runner.sh --help

       Usage: grakn-runner.sh --dockerUserName [Docker user name]
                                 --detach
                                 --debug
                                 --run-perf-scripts
                                 --jdk [GRAALVM]
                                 --javaopts [java opt arguments]
                                 --cleanup
                                 --buildImage
                                 --runContainer
                                 --pushImageToHub
                                 --help

       --dockerUserName      your Docker user name as on Docker Hub
                             (mandatory with build, run and push commands)
       --detach              run container and detach from it,
                             return control to console
       --debug               run docker container in interactive mode
                             (gives command-prompt to run commands inside the container)
       --run-perf-scripts    run performance script in interactive mode (can take a long time)
       --run-grakn-only      run the Grakn docker container in interacive mode
                             but do not start the Graql console, just the Grakn server
       --jdk                 name of the JDK to use (currently supports
                             GRAALVM only, default is blank which
                             enables the traditional JDK)
       --javaopts            sets the JAVA_OPTS environment variable
                             inside the container as it starts
       --cleanup             (command action) remove exited containers and
                             dangling images from the local repository
       --buildImage          (command action) build the docker image
       --runContainer        (command action) run the docker image as a docker container,
                             container will run without this command with selected and default params, in most cases
       --pushImageToHub      (command action) push the docker image built to Docker Hub
       --help                shows the script usage help text

```
The [grakn-runner.sh](../grakn-runner.sh) script runs the container which then calls the respective scripts inside the container and the rest you can see by examing the script. It exposes the Grakn port 48555, so Workbase can be used to connect to http://localhost:48555. The graql console is also available in the window running the docker instance via a separate command (see usage text above).
- Run inside the Grakn docker container
    - [startGraknAndGraql.sh](..//startGraknAndGraql.sh) - entry point script baked into the docker image
    - [grakn-jar-runner.sh](../grakn-jar-runner.sh) - run the Grakn server or console jar files (based on the grakn script provided with the distributable - modified to be able to run the individual jars with the right parameters)
    - [builder.sh](..//builder.sh) - build uberjar and native image from the uberjar for standalone execution (target for native-image is OS specific, uberjar can run on any JVM target), see script usage text:
    ```
            Usage: ./builder.sh --grakn-home   [/path/to/grak/home]
                 --jarfile      [/path/to/JAR file]
                 --buildUberJar
                 --extract
                 --build
                 --test         [/path/to/native-image file]
                 --help

       --grakn-home        [/path/to/grak/home]          where the grakn scripts, jar file and
                                                         other executables can be found
       --jarfile           [/path/to/JAR file]           path to jar file inside Grakn Home or elsewhere
       --buildUberJar                                    (command) build the Uber jar before building
                                                         the native image
       --extract                                         (command) extract the Jar file configuration
                                                         information and save into the META-INF folder
       --buildNativeImage                                (command) build the native image from the Jar
                                                         file provided
       --test              [/path/to/native-image file]  test the native image
       --help                                            shows the script usage help text
     ```


---

[back to README](../README.md)