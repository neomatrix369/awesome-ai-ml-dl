# Better NLP [![Better NLP](https://img.shields.io/docker/pulls/neomatrix369/better-nlp.svg)](https://hub.docker.com/r/neomatrix369/better-nlp) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

This is a wrapper program/library that encapsulates a couple of NLP libraries that are popular among the AI and ML communities.

Examples have been used to illustrate the usage as much as possible. Not all the APIs of the underlying libraries have been covered.

The idea is to keep the API language as high-level as possible, so its easier to use and stays human-readable.

Libraries / frameworks covered:

- SpaCy ([site](https://spacy.io/) | [docs](https://spacy.io/usage/))
- Textacy ([github](https://github.com/chartbeat-labs/textacy) | [docs]https://textacy.readthedocs.io)
- nltk ([site](http://www.nltk.org/) | [docs](https://buildmedia.readthedocs.org/media/pdf/nltk/latest/nltk.pdf))

Non-NLP related libraries / frameworks used:
- numpy ([site](https://www.numpy.org/) | [docs](https://docs.scipy.org/doc/))
- networkx ([site](https://networkx.github.io/) | [docs](https://networkx.github.io/documentation/stable/index.html))

## Requirements

- Python 3.7.x or higher
- Docker (optional)
- Diskspace: 2-3GB

## Get started

### Linux / MacOS (Docker environment)

- Clone the repo: `git clone https://github.com/neomatrix369/awesome-ai-ml-dl`
- `cd /path/to/awesome-ai-ml-dl/examples/better-nlp`
- Ensure the Docker daemon is running in the background
- Run `runDockerImage.sh`
- Wait for the docker image to download (first time, one-off)
- Wait for the container to get started with the JuPyter notebook running
- Copy the notebook's url published in the console, should be of the form `http://....?token....)` - you will have to do a tiny bit of amendment to make the url look like `http://localhost:8888?token....`
- Go to the browser and paste the corrected url: `http://localhost:8888?token....`, you should see the screen as described in [Jupyter Notebook](./docs/Jupyter_notebook.md).

### Linux / MacOS (local environment)

- Clone the repo: `git clone https://github.com/neomatrix369/awesome-ai-ml-dl`
- `cd /path/to/awesome-ai-ml-dl/examples/better-nlp/build`
- Run `install-linux.sh` or `install-macos.sh` depending on the OS you are running on
- Run `install-dependencies.sh`
- Run `cd ..`
- Run `jupyter-lab notebooks/jupyter/better_nlp_spacy_texacy_examples.ipynb`
- Wait for the JuPyter lab to open in the browser
- You should see the screen as described in [Jupyter Notebook](./docs/Jupyter_notebook.md).

In theory, the above should work for Windows as well, if run via `git-bash` or `cgywin` with all the necessary requirements installed and available - although it has not been tested, please provide feedback or fixes if you find any.

### Notebooks

#### Jupyter

See [Jupyter Notebook](./docs/Jupyter_notebook.md) 

#### Google Colab

You can open these notebooks directly into Google Colab:
- [better_nlp_spacy_texacy_examples.ipynb](./notebooks/google-colab/better_nlp_spacy_texacy_examples.ipynb) 
- [better_nlp_summarisers.ipynb](./notebooks/google-colab/better_nlp_summarisers.ipynb)

#### Kaggle kernels

- Better NLP: **[Notebook/Kernel](https://www.kaggle.com/neomatrix369/better-nlp-class-notebook)** | [Scripts](https://www.kaggle.com/neomatrix369/betternlpclass)

![](https://www.googleapis.com/download/storage/v1/b/kaggle-user-content/o/inbox%2F2620712%2F7f251565a07399d0367d0401f3b9e498%2FScreen%20Shot%202019-10-06%20at%2020.25.45.png?generation=1570390145278471&alt=media)

- Better NLP Summarisers: **[Notebook/Kernel](https://www.kaggle.com/neomatrix369/better-nlp-summarisers-notebook)** | Scripts: [Summariser_Cosine_Class](https://www.kaggle.com/neomatrix369/summarisercosineclass) | [Summariser_TFIDF_Class](https://www.kaggle.com/neomatrix369/summarisertfidfclass) | [Summariser_TFIDF_VariationClass](https://www.kaggle.com/neomatrix369/summarisertfidfvariationclass) | [Summariser_PyTextRank_Class](https://www.kaggle.com/neomatrix369/summariser-pytextrank-class)

![](https://www.googleapis.com/download/storage/v1/b/kaggle-user-content/o/inbox%2F2620712%2F7073603b0cf742ab00417ed7502bc2a4%2FScreen%20Shot%202019-10-06%20at%2020.28.09.png?generation=1570390178748534&alt=media)

[Utility Script Competition! (September 23rd - Oct 7th): submission, discussion topic](https://www.kaggle.com/general/109651#642354)

- NLP Profiler:
**[Library](https://github.com/neomatrix369/nlp_profiler)** | [![Gitter](https://badges.gitter.im/nlp_profiler/community.svg)](https://gitter.im/nlp_profiler/community?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge) |[Notebook/Kernel](https://www.kaggle.com/neomatrix369/nlp-profiler-simple-dataset) | [Script](https://www.kaggle.com/neomatrix369/nlp-profiler-class) | [Other related links](https://www.kaggle.com/general/166954)

<table>
  <tr>
    <td align="center">
        <a href="https://youtu.be/sdPOyqMfK7M?t=2274"><img alt="Demo of the NLP Profiler library (Abhishek talks #6)" src=https://user-images.githubusercontent.com/1570917/88474968-8fb48980-cf23-11ea-944d-0a1069174ede.png></a> or you find the rest of the <a href=https://www.youtube.com/watch?v=sdPOyqMfK7M>talk here</a> or here for <a href="https://github.com/neomatrix369/awesome-ai-ml-dl/blob/master/presentations/awesome-ai-ml-dl/02-abhishektalks-2020/README.md">slides</a>
    </td>
    <td align="center">
        <a href="https://youtu.be/wHIcQWeOugI?t=808"><img alt="Demo of the NLP Profiler library (NLP Zurich talk)" src=https://secure.meetupstatic.com/photos/event/5/7/3/highres_492541395.jpeg></a> or you find the rest of the <a href=https://www.youtube.com/watch?v=wHIcQWeOugI>talk here or here for <a href="https://github.com/neomatrix369/nlp_profiler/blob/master/presentations/01-nlp-zurich-2020/README.md">slides</a>
    </td>
  </tr>
</table>

## Installation

Setup an environment needed to be able to run these programs without having to worry about the dependencies they use.

Please be aware that even though we are install only a few components, the installation process takes some time (irrespective if you are running in via your local environment or inside a docker container). Give it about 20-30 minutes depending on network bandwidth and overall machine performance. Or you can use a pre-built docker image, see [Docker environment](README.md#docker_environment.md) for more details.

### Local environment

For the brave at heart, install the dependencies in your local environment.

#### Linux

```bash
./install-linux.sh
```

#### MacOS

```bash
./install-macos.sh
```

Alternatively please refer to the **Docker environment** section.

#### Windows

In principle, the `install-linux.sh` script should work in the `cygwin` or `git bash` environments - although it has not been tested, please raise PR with fixes if any. Alternatively please refer to the **Docker environment** section.

### Docker environment

See [Docker environment](./docs/Docker_environment.md)

## Example code

See [Examples and results](./docs/Examples.md)

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../../CONTRIBUTING.md) guidelines, also have a read about our [licensing](./LICENSE.md) (and warranty) policy.

---

Back to [NLP page](../../natural-language-processing/README.md#natural-language-processing-nlp) </br>
Back to [main page (table of contents)](../../README.md)