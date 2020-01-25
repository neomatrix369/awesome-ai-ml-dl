# Successful run console

## Traditional JDK (JDK8)

**Command**
```
 ./runGraknInDocker.sh
```

**Output**

``` 
-~~~ Running Grakn in a Docker container using the Traditional JDK (version 1.8)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
JAVA_HOME=/usr/local/openjdk-8/
openjdk version "1.8.0_222"
OpenJDK Runtime Environment (build 1.8.0_222-b10)
OpenJDK 64-Bit Server VM (build 25.222-b10, mixed mode)
Grakn version: (see bottom of the startup text banner)

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
Starting Storage.......SUCCESS
Starting Grakn Core Server.......................SUCCESS

real  1m42.084s
user  0m32.994s
sys 0m20.214s
^^^^^^^^^^^^^^^^^ Time taken for the Grakn server to startup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Grakn server is running...
Starting Graql console...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Welcome to Grakn Console. You are now in Grakn Wonderland!
Copyright (C) 2019 Grakn Labs Limited

grakn> exit

real  0m56.431s
user  0m3.860s
sys 0m3.103s
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
JAVA_HOME=/usr/local/graalvm-ce-19.1.1
openjdk version "1.8.0_222"
OpenJDK Runtime Environment (build 1.8.0_222-20190711120915.buildslave.jdk8u-src-tar--b08)
OpenJDK 64-Bit GraalVM CE 19.1.1 (build 25.222-b08-jvmci-19.1-b01, mixed mode)
Grakn version: (see bottom of the startup text banner)
STORAGE_JAVAOPTS=-XX:-UseJVMCINativeLibrary
SERVER_JAVAOPTS=-XX:-UseJVMCINativeLibrary
GRAKN_DAEMON_JAVAOPTS=-XX:-UseJVMCINativeLibrary

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
Starting Storage.......SUCCESS
Starting Grakn Core Server................................SUCCESS

real  2m22.149s
user  0m48.548s
sys 0m27.036s
^^^^^^^^^^^^^^^^^ Time taken for the Grakn server to startup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Grakn server is running...
Starting Graql console...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Welcome to Grakn Console. You are now in Grakn Wonderland!
Copyright (C) 2019 Grakn Labs Limited

grakn> exit

real  0m27.021s
user  0m5.300s
sys 0m4.252s
      172.06 real         0.09 user         0.23 sys
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
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
JAVA_HOME=/usr/local/graalvm-ce-19.1.1
openjdk version "1.8.0_222"
OpenJDK Runtime Environment (build 1.8.0_222-20190711120915.buildslave.jdk8u-src-tar--b08)
OpenJDK 64-Bit GraalVM CE 19.1.1 (build 25.222-b08-jvmci-19.1-b01, mixed mode)
Grakn version: (see bottom of the startup text banner)
STORAGE_JAVAOPTS=-XX:+UseJVMCINativeLibrary
SERVER_JAVAOPTS=-XX:+UseJVMCINativeLibrary
GRAKN_DAEMON_JAVAOPTS=-XX:+UseJVMCINativeLibrary

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
Starting Storage.......SUCCESS
Starting Grakn Core Server......................SUCCESS

real  1m31.834s
user  0m31.986s
sys 0m19.860s
^^^^^^^^^^^^^^^^^ Time taken for the Grakn server to startup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Grakn server is running...
Starting Graql console...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Welcome to Grakn Console. You are now in Grakn Wonderland!
Copyright (C) 2019 Grakn Labs Limited

grakn> exit

real  1m18.217s
user  0m4.908s
sys 0m3.960s
      173.51 real         0.11 user         0.31 sys
```


[Back to Grakn Main Page](./README.md)