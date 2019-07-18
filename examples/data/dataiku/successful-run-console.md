# Successful run console

## Traditional JDK (JDK8)

**Command**
```
 DETACHED_MODE=true JDK_TO_USE="" ./runDssInDocker.sh
```

**Output**

```

~~~ Running DSS in a Docker container using the Traditional JDK (version 1.8)
+ docker run --rm --detach -p 10000:10000 --workdir /home/dataiku --env JDK_TO_USE=Traditional-JDK --env DSS_VERSION=5.1.4 --env JAVA_OPTS= --env DSS_PORT=10000 --env HOME=/home/dataiku --env DSS_DATADIR=/home/dataiku/dss --user dataiku neomatrix369/dataiku-dss:5.1.4
+ set +x
Traditional-JDK: DSS in the container is now starting (id = 1c47c5a)
........................................................................................................
Traditional-JDK: DSS in the container is now running.
Traditional-JDK: Shutting down DSS in the container (id = 1c47c5a).
1c47c5a
Traditional-JDK: DSS in the container (id = 1c47c5a) has been shutdown.


real  0m24.883s
user  0m17.316s
sys 0m3.013s

```

Control waits at the Graql prompt. Execution times at different stages are recorded and displayed. Other environment specific details are also printed in the console.

## Polyglot JDK (GraalVM)

This version of GraalVM is based on JDK8, run with JVMCI disabled.

**Command**

```
 DETACHED_MODE=true JDK_TO_USE="GRAALVM" JAVA_OPTS=-XX:-UseJVMCINativeLibrary ./runDssInDocker.sh
```

```

~~~ Running DSS in a Docker container using the GraalVM (version 1.8), JVMCI disabled
+ docker run --rm --detach -p 10000:10000 --workdir /home/dataiku --env JDK_TO_USE=GRAALVM --env DSS_VERSION=5.1.4 --env JAVA_OPTS=-XX:-UseJVMCINativeLibrary --env DSS_PORT=10000 --env HOME=/home/dataiku --env DSS_DATADIR=/home/dataiku/dss --user dataiku neomatrix369/dataiku-dss:5.1.4
+ set +x
GRAALVM: DSS in the container is now starting (id = a4f3abb)
....................................................................................................
GRAALVM: DSS in the container is now running.
GRAALVM: Shutting down DSS in the container (id = a4f3abb)
a4f3abb
GRAALVM: DSS in the container (id = a4f3abb) has been shutdown.


real  0m23.913s
user  0m16.658s
sys 0m3.257s

``` 

## Polyglot JDK (GraalVM)

This version of GraalVM is based on JDK8, run with JVMCI enabled (default setting).

**Command**

```
 DETACHED_MODE=true JDK_TO_USE="GRAALVM" JAVA_OPTS=-XX:+UseJVMCINativeLibrary ./runDssInDocker.sh
```

```

~~~ Running DSS in a Docker container using the GraalVM (version 1.8), JVMCI enabled
+ docker run --rm --detach -p 10000:10000 --workdir /home/dataiku --env JDK_TO_USE=GRAALVM --env DSS_VERSION=5.1.4 --env JAVA_OPTS=-XX:+UseJVMCINativeLibrary --env DSS_PORT=10000 --env HOME=/home/dataiku --env DSS_DATADIR=/home/dataiku/dss --user dataiku neomatrix369/dataiku-dss:5.1.4
+ set +x
GRAALVM: DSS in the container is now starting (id = 46a0a22)
....................................................................................................
GRAALVM: DSS in the container is now running.
GRAALVM: Shutting down DSS in the container (id = 46a0a22)
46a0a22
GRAALVM: DSS in the container (id = 46a0a22) has been shutdown.


real  0m24.398s
user  0m17.135s
sys 0m3.332s

``` 