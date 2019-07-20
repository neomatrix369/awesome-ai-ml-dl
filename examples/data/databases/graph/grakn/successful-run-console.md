# Successful run console

## Traditional JDK (JDK8)

**Command**
```
 ./runGraknInDocker.sh
```

**Output**

``` 
~~~ Running Grakn in a Docker container using the Traditional JDK (version 1.8)
Traditional-JDK: Grakn in the container is now starting (id = 226c76c)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
openjdk version "1.8.0_111"
OpenJDK Runtime Environment (build 1.8.0_111-8u111-b14-2~bpo8+1-b14)
OpenJDK 64-Bit Server VM (build 25.111-b14, mixed mode)
Grakn version: (see bottom of sartup text banner)
COMMON_JAVAOPTS=
GRAKN_PORT=4567
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
====================================================================================================
      ________  _____     _______  __    __  __    __      _______  _______  _____     _______
     |   __   ||   _  \  |   _   ||  |  /  /|  \  |  |    |   _   ||   _   ||   _  \  |   ____|
     |  |  |__||  | |  | |  | |  ||  | /  / |   \ |  |    |  | |__||  | |  ||  | |  | |  |
     |  | ____ |  |_| /  |  |_|  ||  |/  /  |    \|  |    |  |     |  | |  ||  |_| /  |  |____
     |  ||_   ||   _  \  |   _   ||   _  \  |   _    |    |  |  __ |  | |  ||   _  \  |   ____|
     |  |__|  ||  | \  \ |  | |  ||  | \  \ |  | \   |    |  |_|  ||  |_|  ||  | \  \ |  |____
     |________||__|  \__\|__| |__||__|  \__\|__|  \__|    |_______||_______||__|  \__\|_______|

                                         THE KNOWLEDGE GRAPH
====================================================================================================
                                                                                      Version: 1.5.7
Starting Storage......SUCCESS
Starting Grakn Core Server................SUCCESS

real  0m53.110s
user  0m22.880s
sys 0m1.470s
^^^^^^^^^^^^^^^^^ Time taken for the Grakn server to startup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Grakn server is running...
Dashboard: http://localhost:4567
Starting Graql console...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Welcome to Grakn Console. You are now in Grakn Wonderland!
Copyright (C) 2019 Grakn Labs Limited


real  0m10.279s
user  0m2.040s
sys 0m0.210s
Traditional-JDK: Shutting down Grakn in the container (id = 226c76c)
Traditional-JDK: Grakn in the container (id = 226c76c) has been shutdown.


real  1m5.196s
user  0m0.170s
sys 0m0.113s
```

Execution times at different stages are recorded and displayed. Other environment specific details are also printed in the console.

## Polyglot JDK (GraalVM) - JVMCI disabled

This version of GraalVM is based on JDK8. With JVMCI disabled (via -XX:-UseJVMCINativeLibrary).

**Command**

```
 COMMON_JAVAOPTS=-XX:-UseJVMCINativeLibrary JDK_TO_USE="GRAALVM" ./runGraknInDocker.sh
```

**Output**

```
~~~ Running Grakn in a Docker container using the GraalVM (version 1.8), JVMCI disabled
GRAALVM: Grakn in the container is now starting (id = cdd9a0a)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
JAVA_HOME=/usr/lib/jvm/graalvm-ce-19.1.1
openjdk version "1.8.0_222"
OpenJDK Runtime Environment (build 1.8.0_222-20190711120915.buildslave.jdk8u-src-tar--b08)
OpenJDK 64-Bit GraalVM CE 19.1.1 (build 25.222-b08-jvmci-19.1-b01, mixed mode)
Grakn version: (see bottom of sartup text banner)
STORAGE_JAVAOPTS=-XX:+UseJVMCINativeLibrary
SERVER_JAVAOPTS=-XX:+UseJVMCINativeLibrary
COMMON_JAVAOPTS=-XX:+UseJVMCINativeLibrary
GRAKN_DAEMON_JAVAOPTS=-XX:+UseJVMCINativeLibrary
GRAKN_PORT=4567
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
====================================================================================================
      ________  _____     _______  __    __  __    __      _______  _______  _____     _______
     |   __   ||   _  \  |   _   ||  |  /  /|  \  |  |    |   _   ||   _   ||   _  \  |   ____|
     |  |  |__||  | |  | |  | |  ||  | /  / |   \ |  |    |  | |__||  | |  ||  | |  | |  |
     |  | ____ |  |_| /  |  |_|  ||  |/  /  |    \|  |    |  |     |  | |  ||  |_| /  |  |____
     |  ||_   ||   _  \  |   _   ||   _  \  |   _    |    |  |  __ |  | |  ||   _  \  |   ____|
     |  |__|  ||  | \  \ |  | |  ||  | \  \ |  | \   |    |  |_|  ||  |_|  ||  | \  \ |  |____
     |________||__|  \__\|__| |__||__|  \__\|__|  \__|    |_______||_______||__|  \__\|_______|

                                         THE KNOWLEDGE GRAPH
====================================================================================================
                                                                                      Version: 1.5.7
Starting Storage......SUCCESS
Starting Grakn Core Server.............SUCCESS
^^^^^^^^^^^^^^^^^ Time taken for the Grakn server to startup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

real  0m37.590s
user  0m12.010s
sys 0m3.280s
Grakn server is running...
Dashboard: http://localhost:4567
Starting Graql console...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Welcome to Grakn Console. You are now in Grakn Wonderland!
Copyright (C) 2019 Grakn Labs Limited


real  0m13.161s
user  0m2.300s
sys 0m0.490s
grakn> GRAALVM: Shutting down Grakn in the container (id = cdd9a0a)
GRAALVM: Grakn in the container (id = cdd9a0a) has been shutdown.


real  0m53.225s
user  0m0.166s
sys 0m0.118s
```

Execution times at different stages are recorded and displayed. Other environment specific details are also printed in the console.


## Polyglot JDK (GraalVM) - JVMCI enabled

This version of GraalVM is based on JDK8, run with JVMCI enabled (default setting).

**Command**

```
 JDK_TO_USE="GRAALVM" ./runGraknInDocker.sh
```

```
~~~ Running Grakn in a Docker container using the GraalVM (version 1.8), JVMCI enabled
GRAALVM: Grakn in the container is now starting (id = ea49cc4)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
JAVA_HOME=/usr/lib/jvm/graalvm-ce-19.1.1
openjdk version "1.8.0_222"
OpenJDK Runtime Environment (build 1.8.0_222-20190711120915.buildslave.jdk8u-src-tar--b08)
OpenJDK 64-Bit GraalVM CE 19.1.1 (build 25.222-b08-jvmci-19.1-b01, mixed mode)
Grakn version: (see bottom of sartup text banner)
STORAGE_JAVAOPTS=-XX:+UseJVMCINativeLibrary
SERVER_JAVAOPTS=-XX:+UseJVMCINativeLibrary
COMMON_JAVAOPTS=-XX:+UseJVMCINativeLibrary
GRAKN_DAEMON_JAVAOPTS=-XX:+UseJVMCINativeLibrary
GRAKN_PORT=4567
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
====================================================================================================
      ________  _____     _______  __    __  __    __      _______  _______  _____     _______
     |   __   ||   _  \  |   _   ||  |  /  /|  \  |  |    |   _   ||   _   ||   _  \  |   ____|
     |  |  |__||  | |  | |  | |  ||  | /  / |   \ |  |    |  | |__||  | |  ||  | |  | |  |
     |  | ____ |  |_| /  |  |_|  ||  |/  /  |    \|  |    |  |     |  | |  ||  |_| /  |  |____
     |  ||_   ||   _  \  |   _   ||   _  \  |   _    |    |  |  __ |  | |  ||   _  \  |   ____|
     |  |__|  ||  | \  \ |  | |  ||  | \  \ |  | \   |    |  |_|  ||  |_|  ||  | \  \ |  |____
     |________||__|  \__\|__| |__||__|  \__\|__|  \__|    |_______||_______||__|  \__\|_______|

                                         THE KNOWLEDGE GRAPH
====================================================================================================
                                                                                      Version: 1.5.7
Starting Storage......SUCCESS
Starting Grakn Core Server..............SUCCESS

real  0m38.734s
user  0m12.610s
sys 0m2.110s
^^^^^^^^^^^^^^^^^ Time taken for the Grakn server to startup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Grakn server is running...
Dashboard: http://localhost:4567
Starting Graql console...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Welcome to Grakn Console. You are now in Grakn Wonderland!
Copyright (C) 2019 Grakn Labs Limited


real  0m10.760s
user  0m2.220s
sys 0m0.320s
GRAALVM: Shutting down Grakn in the container (id = ea49cc4)
GRAALVM: Grakn in the container (id = ea49cc4) has been shutdown.


real  0m51.649s
user  0m0.170s
sys 0m0.111s
```


[Back to Grakn Main Page](./README.md)