# Intro to text classification with Keras: automatically tagging Stack Overflow posts - an expanded version

Inspiration and original work by the good folks from Google: [Intro to text classification with Keras: automatically tagging Stack Overflow posts](https://cloud.google.com/blog/products/gcp/intro-to-text-classification-with-keras-automatically-tagging-stack-overflow-posts)

## Complete code on GitHub

[https://github.com/tensorflow/workshops/tree/master/extras/keras-bag-of-words]()

## Installations

### Install TensorFlow

An open source machine learning framework - [https://keras.io/]()

```bash
pip2.7 install --user tensorflow
or
pip3 install --user tensorflow
```

### Install Keras

A high-level API built in to TensorFlow - [https://keras.io/]()

```bash
pip2.7 install --user keras
or
pip3 install --user keras
```

## Getting the comment data

### BigQuery

See [Google BigQuery steps to follow](google-bigquery/README.md)

## Bag of words model

### Preprocessing data

See [Preprocessing data steps](preprocessing-data.md)

### Processing input features

See [Processing input features steps](processing-input-features.md)

## Processing output labels

See [Processing output labels steps](processing-output-labels.md)

## Building the model

See [Building the model steps](building-the-model.md)

## Training and evaluating the model

### Cross entropy loss function

[https://en.wikipedia.org/wiki/Cross_entropy]()

Each of the comments (on the post) can only belong to one post

### Optimisers (e.g. gradient descent)

An Optimizer is a function the model uses to minimize loss

**Adam optimizer**

[https://arxiv.org/abs/1412.6980]()

**More on optimizers**

[https://en.wikipedia.org/wiki/Hyperparameter_(machine_learning)]()

### Metrics

See [Metrics](metrics.md)

## Generating predictions

See [Generating predictions steps](generating-predictions.md)

## Next Steps

### Improve accuracy by experimenting with hyperparameters

#### Vocabulary size

Changing the vocabulary size of the BOW model (Bag Of Words model) uses

#### Other parameters

Changing batch size, number of epochs, or the dimensionality of the input layer

#### Dataset Size

Increasing the size of the training dataset

#### Dropout

Adding dropout to one of the layers to prevent the model from overfitting - [https://keras.io/layers/core/]()

## Resources

Original and improvised versions of the notebook, python scripts and data can be found in the folder [data-scripts-notebooks](./data-scripts-notebooks). Also, includes a version with the [Weights and Biases](http://wandb.com) package implemented.

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../../CONTRIBUTING.md) guidelines, also have a read about our [licensing](../../LICENSE.md) policy.

---

Back to [main page (table of contents)](../../README.md)