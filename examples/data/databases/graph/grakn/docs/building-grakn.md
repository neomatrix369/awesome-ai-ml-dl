## Building Grakn

Run the Grakn docker container:

```
$ ./grakn-runner.sh --debug --runContainer 
```

When the docker prompt appears, continue doing one of the actions below.

#### Building uberjar inside the container

It's done from inside the container, or the host machine or even on the cloud.

```
grakn@c74ed490582e:~$ ./builder.sh --buildUberJar
```
This process can take a bit of time as bazel builds our uberjar.

#### Building native-image inside the container

## Building native-image inside the container

It's done in two steps and can be run from inside the container, or the host machine or even on the cloud.

**Extract META-INF from the jar before proceeding with the build process**
```
grakn@c74ed490582e:~$ ./builder.sh --grakn-home [/path/to/grakn/home] --extract 
```

**Building `native-image` using the extracted META-INF of the jar and the jar file**
```
grakn@c74ed490582e:~$ ./builder.sh --jarfile [/path/with/filename.jar] --buildNativeImage
or 
grakn@c74ed490582e:~$ ./builder.sh --grakn-home [/path/to/grakn/home] --buildNativeImage
```

This process can take a bit of time as the `native-image` building process is a lengthy one.

---

[back to README](./../README.md)