# Successful run console

## Traditional JDK (JDK8)

**Command**
```
 ./runGraknInDocker.sh
```

**Output**

``` 
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
openjdk version "1.8.0_111"
OpenJDK Runtime Environment (build 1.8.0_111-8u111-b14-2~bpo8+1-b14)
OpenJDK 64-Bit Server VM (build 25.111-b14, mixed mode)
Grakn version:Usage: grakn server COMMAND

COMMAND:
start [server|storage|--benchmark] Start Grakn (or optionally, only one of the component, or with benchmarking enabled)
stop [server|storage]   Stop Grakn (or optionally, only one of the component)
status                         Check if Grakn is running
clean                          DANGEROUS: wipe data completely

Tips:
- Start Grakn with 'grakn server start'
- Start or stop only one component with, e.g. 'grakn server start storage' or 'grakn server stop storage', respectively
- Start Grakn with Zipkin-enabled benchmarking with `grakn server start --benchmark`
GRAKN_PORT=4567~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
Starting Storage.....
SUCCESS
Starting Grakn Core Server.........................SUCCESS

real    1m34.970s
user    0m8.440s
sys 0m36.020s
^^^^^^^^^^^^^^^^^ Time taken for the Grakn server to startup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Grakn server is running...
Dashboard: http://localhost:4567
Starting Graql console...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Welcome to Grakn Console. You are now in Grakn Wonderland!
Copyright (C) 2019 Grakn Labs Limited

grakn>

real    0m13.466s
user    0m2.050s
sys 0m2.090s

real    1m52.302s
user    0m0.055s
sys 0m0.036s
```

Control waits at the Graql prompt. Execution times at different stages are recorded and displayed. Other environment specific details are also printed in the console.

## Polyglot JDK (GraalVM)

This version of GraalVM is based on JDK8. With JVMCI disabled (via -XX:-UseJVMCINativeLibrary).

**Command**

```
 COMMON_JAVAOPTS=-XX:-UseJVMCINativeLibrary JDK_TO_USE="GRAALVM" ./runGraknInDocker.sh
```

**Output**

```
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
JAVA_HOME=/usr/lib/jvm/graalvm-ce-19.1.0
openjdk version "1.8.0_212"
OpenJDK Runtime Environment (build 1.8.0_212-20190523183340.buildslave.jdk8u-src-tar--b03)
OpenJDK 64-Bit GraalVM CE 19.1.0 (build 25.212-b03-jvmci-20-b04, mixed mode)
Grakn version: (see bottom of sartup text banner)
STORAGE_JAVAOPTS=-XX:-UseJVMCINativeLibrary
SERVER_JAVAOPTS=-XX:-UseJVMCINativeLibrary
GRAKN_DAEMON_JAVAOPTS=-XX:-UseJVMCINativeLibrary
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
Starting Storage.......exit
SUCCESS
Starting Grakn Core Server.................SUCCESS

real  1m6.669s
user  0m22.970s
sys 0m13.210s
^^^^^^^^^^^^^^^^^ Time taken for the Grakn server to startup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Grakn server is running...
Dashboard: http://localhost:4567
Starting Graql console...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Welcome to Grakn Console. You are now in Grakn Wonderland!
Copyright (C) 2019 Grakn Labs Limited

grakn>

real  0m17.702s
user  0m3.090s
sys 0m2.740s

real  1m26.861s
user  0m0.048s
sys 0m0.040s
```

Control waits at the Graql prompt. Execution times at different stages are recorded and displayed. Other environment specific details are also printed in the console.


## Polyglot JDK (GraalVM)

This version of GraalVM is based on JDK8, run with JVMCI enabled (default setting).

**Command**

```
 JDK_TO_USE="GRAALVM" ./runGraknInDocker.sh
```

```
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
JAVA_HOME=/usr/lib/jvm/graalvm-ce-19.1.0
openjdk version "1.8.0_212"
OpenJDK Runtime Environment (build 1.8.0_212-20190523183340.buildslave.jdk8u-src-tar--b03)
OpenJDK 64-Bit GraalVM CE 19.1.0 (build 25.212-b03-jvmci-20-b04, mixed mode)
Grakn version: (see bottom of sartup text banner)
STORAGE_JAVAOPTS=-XX:+UseJVMCINativeLibrary
SERVER_JAVAOPTS=-XX:+UseJVMCINativeLibrary
GRAKN_DAEMON_JAVAOPTS=-XX:+UseJVMCINativeLibrary
GRAKN_PORT=4567~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
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
Starting Grakn Core Server...................SUCCESS

real  1m4.756s
user  0m15.070s
sys 0m10.220s
^^^^^^^^^^^^^^^^^ Time taken for the Grakn server to startup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Grakn server is running...
Dashboard: http://localhost:4567
Starting Graql console...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Welcome to Grakn Console. You are now in Grakn Wonderland!
Copyright (C) 2019 Grakn Labs Limited

grakn>

real  0m20.491s
user  0m2.970s
sys 0m2.570s

real  1m27.417s
user  0m0.062s
sys 0m0.043s
```