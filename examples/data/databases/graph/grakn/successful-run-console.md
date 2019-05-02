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
Grakn version:====================================================================================================
      ________  _____     _______  __    __  __    __      _______  _______  _____     _______
     |   __   ||   _  \  |   _   ||  |  /  /|  \  |  |    |   _   ||   _   ||   _  \  |   ____|
     |  |  |__||  | |  | |  | |  ||  | /  / |   \ |  |    |  | |__||  | |  ||  | |  | |  |
     |  | ____ |  |_| /  |  |_|  ||  |/  /  |    \|  |    |  |     |  | |  ||  |_| /  |  |____
     |  ||_   ||   _  \  |   _   ||   _  \  |   _    |    |  |  __ |  | |  ||   _  \  |   ____|
     |  |__|  ||  | \  \ |  | |  ||  | \  \ |  | \   |    |  |_|  ||  |_|  ||  | \  \ |  |____
     |________||__|  \__\|__| |__||__|  \__\|__|  \__|    |_______||_______||__|  \__\|_______|

                                         THE KNOWLEDGE GRAPH
====================================================================================================

1.5.2
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

Starting Storage.....SUCCESS
Starting Grakn Core Server........................SUCCESS

real    1m34.650s
user    0m9.200s
sys 0m36.000s
^^^^^^^^^^^^^^^^^ Time taken for the Grakn server to startup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Grakn server is running...
Dashboard: http://localhost:4567
Starting Graql console...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Welcome to Grakn Console. You are now in Grakn Wonderland!
Copyright (C) 2019 Grakn Labs Limited

grakn>
```

Control waits at the Graql prompt. Execution times at different stages are recorded and displayed. Other environment specific details are also printed in the console.

## Polyglot JDK (GraalVM)

This version of GraalVM is based on JDK8.

**Command**

```
 JDK_TO_USE="GRAALVM" ./runGraknInDocker.sh
```

**Output**

```
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
JAVA_HOME=/usr/lib/jvm/graalvm-ce-1.0.0-rc15
openjdk version "1.8.0_202"
OpenJDK Runtime Environment (build 1.8.0_202-20190206132807.buildslave.jdk8u-src-tar--b08)
OpenJDK GraalVM CE 1.0.0-rc15 (build 25.202-b08-jvmci-0.58, mixed mode)
Grakn version:====================================================================================================
      ________  _____     _______  __    __  __    __      _______  _______  _____     _______
     |   __   ||   _  \  |   _   ||  |  /  /|  \  |  |    |   _   ||   _   ||   _  \  |   ____|
     |  |  |__||  | |  | |  | |  ||  | /  / |   \ |  |    |  | |__||  | |  ||  | |  | |  |
     |  | ____ |  |_| /  |  |_|  ||  |/  /  |    \|  |    |  |     |  | |  ||  |_| /  |  |____
     |  ||_   ||   _  \  |   _   ||   _  \  |   _    |    |  |  __ |  | |  ||   _  \  |   ____|
     |  |__|  ||  | \  \ |  | |  ||  | \  \ |  | \   |    |  |_|  ||  |_|  ||  | \  \ |  |____
     |________||__|  \__\|__| |__||__|  \__\|__|  \__|    |_______||_______||__|  \__\|_______|

                                         THE KNOWLEDGE GRAPH
====================================================================================================

1.5.2
STORAGE_JAVAOPTS=-XX:-UseJVMCINativeLibrary
SERVER_JAVAOPTS=-XX:-UseJVMCINativeLibrary
GRAKN_DAEMON_JAVAOPTS=-XX:-UseJVMCINativeLibrary
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

Starting Storage.......SUCCESS
Starting Grakn Core Server..................SUCCESS

real    1m4.887s
user    0m21.880s
sys 0m12.630s
^^^^^^^^^^^^^^^^^ Time taken for the Grakn server to startup
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Grakn server is running...
Dashboard: http://localhost:4567
Starting Graql console...
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Welcome to Grakn Console. You are now in Grakn Wonderland!
Copyright (C) 2019 Grakn Labs Limited

grakn>
```

Control waits at the Graql prompt. Execution times at different stages are recorded and displayed. Other environment specific details are also printed in the console.