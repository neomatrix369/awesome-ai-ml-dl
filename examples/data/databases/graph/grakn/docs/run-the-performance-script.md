### Run the performance script in the Grakn docker container

#### Automatically

```bash
Run the performance benchmarking script with default JDK

$ RUN_PERFORMANCE_SCRIPT=true ./runGraknInDocker.sh

or 

Run the performance benchmarking script with GraalVM

$  JDK_TO_USE="GRAALVM" RUN_PERFORMANCE_SCRIPT=true ./runGraknInDocker.sh
```

#### Manually

```bash
Run the performance benchmarking script with default JDK

$ DEBUG=true ./runGraknInDocker.sh
grakn@040eb5bd829c:~$ ./runPerformanceBenchmark.sh    # inside the container

or 

Run the performance benchmarking script with GraalVM

$  JDK_TO_USE="GRAALVM" DEBUG=true ./runGraknInDocker.sh
grakn@040eb5bd829c:~$ ./runPerformanceBenchmark.sh    # inside the container
```

See [successful run console](successful-run-console.md) - includes both outputs from the traditional JDK8 and GraalVM executions. In debug mode, the docker container prompt is returned, the Grakn and Graql instances are not executed. Please check out the history of [successful run console](successful-run-console.md) to see progress with previous runs under various versions of Grakn, GraalVM and other configuration settings.


---

[back to README](./../README.md)