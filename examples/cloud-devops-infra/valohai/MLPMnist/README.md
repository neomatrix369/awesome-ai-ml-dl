# [![MLPMNist using DL4J](https://img.shields.io/docker/pulls/neomatrix369/dl4j-mnist-single-layer.svg)](https://hub.docker.com/r/neomatrix369/dl4j-mnist-single-layer)

Open built-in Terminal from the Android Studio or IntelliJ IDEA. 
If you prefer, use the terminal app on your computer.
In the terminal window, `cd` to the project root directory `MLPMnist` if not already in.
(_you can use IDE's run-configuration green run button, if you like._)

### Build app

```
mvn package -Djavacpp.platform=linux-x86_64
or
mvn package -Djavacpp.platform=macos-x86_64
or
mvn package -Djavacpp.platform=windows-x86_64
```

### Build app for the docker image


#### Build docker image

```
./buildUberJar.sh
./buildDockerImage.sh
```

#### Push to docker hub

```
./push-docker-image-to-hub.sh
```

### Run app local

```
./runMLPMnist.sh --action train --output-dir /path/to/model/creation/folder
```

followed by

```
./runMLPMnist.sh --action evaluate --output-dir /path/to/model/folder
```

Model file created and seeked for in the respective cases, is called `mlpmnist-single-layer.pb`.

### Run app in docker container

```
./runDockerContainer.sh
```

At the prompt in the container, do the same as mentioned in section [Run app local](#run-app-local).

## Credits

This example has been inspired by the [MLPMNist example](https://github.com/deeplearning4j/dl4j-examples/tree/master/dl4j-examples/src/main/java/org/deeplearning4j/examples/feedforward/mnist) example from DL4J. Credits to the original authors of this example on https://github.com/deeplearning4j/dl4j-examples. 

## License

Original authors of this DL4J example project remain the license holders of the work, although the original work has been modified to a good extent, and the Apache 2.0 License is cited for all those file/files in the matter (see [License.txt](License.txt) in the root of the project). Exception to the above: four bash scripts have been authored by Mani Sarkar and have been cited under the Apache 2.0 license.

### Resources

- [Awesome AI/ML/DL resources](https://github.com/neomatrix369/awesome-ai-ml-dl/)
- [Java AI/ML/DL resources](https://github.com/neomatrix369/awesome-ai-ml-dl/blob/master/README-details.md#java)
- [Deep Learning and DL4J Resources](https://github.com/neomatrix369/awesome-ai-ml-dl/blob/master/README-details.md#deep-learning)
- Additional DL4J resources
  - Loss functions
    - [Loss function Interface by DL4J](https://deeplearning4j.org/api/latest/org/nd4j/linalg/lossfunctions/ILossFunction.html)
    - [5 Regression Loss Functions All Machine Learners Should Know](https://heartbeat.fritz.ai/5-regression-loss-functions-all-machine-learners-should-know-4fb140e9d4b0)
  - Evaluation
    - [https://deeplearning4j.org/docs/latest/deeplearning4j-nn-evaluation]()
- Valohai resources
  - [valohai](https://valohai.com/) | [docs](https://docs.valohai.com/) | [blogs](https://blog.valohai.com/) | [GitHub](https://github.com/valohai) | [Videos](https://www.youtube.com/channel/UCiR8Fpv6jRNphaZ99PnIuFg) | [Showcase](https://valohai.com/showcase/) | [About Valohai](https://github.com/neomatrix369/awesome-ai-ml-dl/blob/master/data/about-Valohai.md#valohai) | [Slack](http://community-slack.valohai.com/)
  - Blog posts on how to use the CLI tool: [1](https://blog.valohai.com/from-zero-to-hero-with-valohai-cli) | [2](https://blog.valohai.com/from-zero-to-hero-with-valohai-part-2)
- Other resources
  - [Awesome Graal](https://github.com/neomatrix369/awesome-graal) | [graalvm.org](https://www.graalvm.org/)

---

Back to [main page (table of contents)](../../../../README.md#awesome-ai-ml-dl-)