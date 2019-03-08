# Better NLP

This is a wrapper program/library that encapsulates a couple of NLP libraries that are popular among the AI and ML communities.

Examples have been used to illustrate the usage as much as possible. Not all the APIs of the underlying libraries have been covered.

The idea is to keep the API language as high-level as possible, so its easier to use it easily and stays human-readable.

Libraries covered:
- SpaCey
- Texacy

## Requirements

- Python 3.7.x or higher
- Docker (optional)

## Installation

Setup an environment needed to be able to run these programs without having to worry about the dependencies they use.

### Local environment

For the brave at heart, install the dependencies in your local environment.

### Docker environment

Build a docker image with the necessary dependencies:

```
    ./buildDockerImage.sh
```

Run the docker container to start running the programs:

```
    ./runDockerImage.sh
```

## Example code

### Extract noun chunks from text

```
    python3 extract-noun-chunks-from-text.py
```

### Extracts facts from text

```
    python3 gather-facts-from-text.py
```

### Extracts entities from text

```
    python3 extract-entities-from-text.py            
```

### Obfuscate details from text for privacy

```
    python3 obfuscate-privacy-details-in-the-text.py
```