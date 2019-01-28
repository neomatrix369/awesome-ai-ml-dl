# JuPyteR

[JuPyteR notebooks](https://jupyter.org/) also gives us the facility to write notebooks using Java, Scala and other JVM and non-JVM languages in addition to Python, R and Julia.

In theory, the below instructions should work for all operating systems i.e. Linux, MacOS and Windows. Although it has been only tested for Linux and MacOS.

### Kernels
These are provided using via kernels, for e.g. the [IJava kernel](https://github.com/SpencerPark/IJava) when installed, provides Java language support in Jupyter notebooks. Take a look at the docs and examples provided on [https://github.com/SpencerPark/IJava]().

Pre-requisite: only supports JDK versions 9 and higher

Graal compiler can be enabled for JDK 9 and higher, for platforms where it is supported, see table below:

|JDK/JRE Version  | Platforms             | 
|----------------:|:----------------------|
|Java 9           | Linux only            |
|Java 10          | Linux and MacOS       |
|Java 11 or higher| Linux, MacOS, Windows |

### Additional source of kernels
[beakerx](http://beakerx.com/) Is another source where a wider range of kernels can be found.

## Get started: Automated (via scripts)

### Local environment

```
./install-java-kernel.sh
```

We should see the below output:

```
A list of already installed kernels in your jupyter environment
Available kernels:
  python2    /[User home]/[path/to]/jupyter/kernels/python2
Downloading the Java kernel version 1.2.0
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100   606    0   606    0     0   1419      0 --:--:-- --:--:-- --:--:--  1415
100 5397k  100 5397k    0     0  2321k      0  0:00:02  0:00:02 --:--:-- 4213k
Unzipping the Java kernel version 1.2.0
Archive:  ijava-1.2.0.zip
   creating: java/
  inflating: java/ijava-1.2.0.jar
  inflating: java/kernel.json
   creating: java/dependency-licenses/
   creating: java/dependency-licenses/commons-io-2.5.jar/
   [...snipped...]
  inflating: install.py
Using the install.py command to install Java kernel version 1.2.0.
[InstallKernelSpec] Installed kernelspec java in /[path/to]/jupyter/kernels/java
A list of already installed kernels in your jupyter environment
Available kernels:
  java       /[User home]/[path/to]/jupyter/kernels/java
  python2    /[User home]/[path/to]/share/jupyter/kernels/python2
```

### Docker container

See [Docker container instructions](Docker-container-instructions.md)

## Get started: Manual steps (via CLI)

### Check for available kernels

Let's find out what exists in our development environment:

```
$ jupyter kernelspec list
```

Here is a sample output depending on what is installed in our development environment:

```
Available kernels:
  python2    /[User home]/[path/to]/jupyter/kernels/python2
```

Output might vary slightly depending on how your `python` environment has been setup.

### Download and unzip the kernel (from pre-compiled binary release)

Download the [IJava kernel](https://github.com/SpencerPark/IJava) version 1.2.0 with:

```
$ curl -L https://github.com/SpencerPark/IJava/releases/download/v1.2.0/ijava-1.2.0.zip -O ijava-1.2.0.zip

### ~~~ choose a destination to unzip the archive ~~~

$ unzip ijava-1.2.0.zip
```

### Install the kernel

**Pre-requisite:** _Java 9_ should be the current JDK your *JAVA_HOME* should point to, when installing the pre-compiled binary from [https://github.com/SpencerPark/IJava/releases/]()

#### Method 1: via the `jupyter` command on the command-line

```    
$ jupyter kernelspec install java
```

```
[InstallKernelSpec] Installed kernelspec java in /[path/to]/jupyter/kernels/java
```

Note: destination paths may vary hence `[path/to]`.

#### Method 2: via the `python3` command on the command-line

```
$ python3 install.py --sys-prefix
```

```
Installed java kernel into "/[path/to]/jupyter/kernels/java"
```

Note: destination paths may vary hence `[path/to]`.

### Recheck for the now available kernels

Let's find out if the installation was successful:

```
$ jupyter kernelspec list
```

We could expect an output like the below:

```
Available kernels:
  java       /[User home]/[path/to]/jupyter/kernels/java
  python2    /[User home]/[path/to]/jupyter/kernels/python2
```

Output might vary slightly depending on how your `python` environment has been setup.

### Kernel installation: variety of combinations of environments and JDKs 

See [Other kernel installation methods](Other-kernel-installation-methods.md)

Please take a glance at the above link, especially if `jupiter-notebook` or `jupyter-lab` has trouble locating the kernels.

### Removing the installed kernel

```    
$ jupyter kernelspec remove java
```

Interaction to confirm removal of the kernel:

```
Kernel specs to remove:
  java                  /[User home]/[path/to]/jupyter/kernels/java
Remove 1 kernel specs [y/N]: y
[RemoveKernelSpec] Removed /[User home]/[path/to]/jupyter/kernels/java
```

Note: destination paths may vary hence `[path/to]`.

Ensure you are currently in the right python environment to be able to remove the kernel installed in the said environment.

### Usage and examples

See [README section on SpencerPark/IJava](https://github.com/SpencerPark/IJava) for a whole number of examples and usages.

Also checkout the live links (JuPyteR notebooks online).

**Enjoy writing prototypes, experiments or do some real work with it, in Java, Scala or any other kernel of your choice.**
