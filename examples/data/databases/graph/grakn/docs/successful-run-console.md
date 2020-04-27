# Successful run console

## Traditional JDK (JDK8)

**Command**
```
 ./grakn-runner.sh --runContainer
```

**Output**

``` 
-~~~ Running Grakn in a Docker container using the Traditional JDK (version 1.8)
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
JAVA_HOME=/usr/local/graalvm-ce-java8-19.3.1
openjdk version "1.8.0_242"
OpenJDK Runtime Environment (build 1.8.0_242-b06)
OpenJDK 64-Bit GraalVM CE 19.3.1 (build 25.242-b06-jvmci-19.3-b07, mixed mode)
Grakn version: (see bottom of the startup text banner)
STORAGE_JAVAOPTS=-XX:+UseJVMCINativeLibrary
SERVER_JAVAOPTS=-XX:+UseJVMCINativeLibrary
GRAKN_DAEMON_JAVAOPTS=-XX:+UseJVMCINativeLibrary
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

real  0m34.494s
user  0m13.108s
sys 0m7.925s
^^^^^^^^^^^^^^^^^ Time taken for the Grakn server to startup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Grakn server is running...
Starting Graql console...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Welcome to Grakn Console. You are now in Grakn Wonderland!
Copyright (C) 2019 Grakn Labs Limited


real  0m22.735s
user  0m2.902s
sys 0m2.390s

Total execution time (container)

real  0m58.691s
user  0m0.131s
sys 0m0.102s
```

Execution times at different stages are recorded and displayed. Other environment specific details are also printed in the console.

## Polyglot JDK (GraalVM) - JVMCI disabled

This version of GraalVM is based on JDK8. With JVMCI disabled (via -XX:-UseJVMCINativeLibrary).

**Command**

```
 ./grakn-runner.sh --javaopts="-XX:-UseJVMCINativeLibrary" --jdk GRAALVM --runContainer 
```

**Output**

```
~~~ Running Grakn in a Docker container using the GraalVM CE (java8 version 19.3.1), JVMCI disabled

JAVA_HOME=/usr/local/graalvm-ce-java8-19.3.1
openjdk version "1.8.0_242"
OpenJDK Runtime Environment (build 1.8.0_242-b06)
OpenJDK 64-Bit GraalVM CE 19.3.1 (build 25.242-b06-jvmci-19.3-b07, mixed mode)
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
Starting Grakn Core Server................................SUCCESS

real  0m47.685s
user  0m20.373s
sys 0m13.850s
^^^^^^^^^^^^^^^^^ Time taken for the Grakn server to startup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Grakn server is running...
Starting Graql console...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Welcome to Grakn Console. You are now in Grakn Wonderland!
Copyright (C) 2019 Grakn Labs Limited

real  0m22.317s
user  0m3.472s
sys 0m2.948s


real  1m11.565s
user  0m0.157s
sys 0m0.136s

```

Execution times at different stages are recorded and displayed. Other environment specific details are also printed in the console.

## Polyglot JDK (GraalVM) - JVMCI enabled

This version of GraalVM is based on JDK8, run with JVMCI enabled (default setting).

**Command**

```
 ./grakn-runner.sh --javaopts="-XX:+UseJVMCINativeLibrary" --jdk GRAALVM --runContainer 
```

```
~~~ Running Grakn in a Docker container using the GraalVM CE (java8 version 19.3.1), JVMCI enabled
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
JAVA_HOME=/usr/local/graalvm-ce-java8-19.3.1
openjdk version "1.8.0_242"
OpenJDK Runtime Environment (build 1.8.0_242-b06)
OpenJDK 64-Bit GraalVM CE 19.3.1 (build 25.242-b06-jvmci-19.3-b07, mixed mode)
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

real  0m51.592s
user  0m22.501s
sys 0m15.031s
^^^^^^^^^^^^^^^^^ Time taken for the Grakn server to startup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Grakn server is running...
Starting Graql console...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Welcome to Grakn Console. You are now in Grakn Wonderland!
Copyright (C) 2019 Grakn Labs Limited

real  0m25.230s
user  0m4.429s
sys 0m3.617s


real  1m18.604s
user  0m0.160s
sys 0m0.143s
```

---

[Back to Grakn Main Page](./../README.md)