## Kernel installation: variety of combinations of environments and JDKs 

JuPyteR kernels can be installed multiple ways and on variety of JDKs.

**Pre-Java 9 / GraalVM**
Unfortunately, not possible to build sources under these versions as the source is targeted for **Java 9 and higher**.

**Java 9 or higher**

```
### Switch to JDK 9 or higher (ensure JAVA_HOME and PATH point to the right JDK)
$ git clone https://github.com/SpencerPark/IJava
$ cd IJava
$ chmod +x gradlew
$ ./gradlew tasks
$ ./gradlew clean build

$ ./gradlew installKernel
```

Note: please raise any build or installation issues at [https://github.com/SpencerPark/IJava/issues](https://github.com/SpencerPark/IJava/issues)

***Python 2 or 3 (vanilla)***

This step is applicable for both the pre-compiled binary or binary create from above step.

Check the version of the current version of `python` on your path.

```
$ python install.py --sys-prefix
```

or

```
$ python2 install.py --sys-prefix
$ python2.7 install.py --sys-prefix
```

or

```
$ python3 install.py --sys-prefix
$ python3.7 install.py --sys-prefix
```

The above will install the kernel in the respective `python` environment.

***Python 2 or 3 (anaconda)***

This step is applicable for both the pre-compiled binary or binary create from above step.

Check the version of the current version of `python` on your path and also which python environ `anaconda` is pointing to.

```
source activate [python 2 environment]
$ python2 install.py --sys-prefix
$ python2.7 install.py --sys-prefix
```

or

```
source activate [python 3 environment]
$ python3 install.py --sys-prefix
$ python3.7 install.py --sys-prefix
```

The above will install the kernel in the respective `python` environment. For e.g.:

Available kernels:
  java       /path/to/anaconda2/share/jupyter/kernels/java
  python2    /path/to/anaconda2/share/jupyter/kernels/python2

or

Available kernels:
  java       /path/to/anaconda3/share/jupyter/kernels/java
  python3    /path/to/anaconda3/share/jupyter/kernels/python3

You can install the kernel in both python2 and python3 environments.