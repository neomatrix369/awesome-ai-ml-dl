## Building the model

### Keras Sequential model API

[https://keras.io/models/sequential/]()

### Dense layer 

Each neuron in one layer will be fully connected to all neurons in the next layer

[https://keras.io/layers/core/]()

**Parameters**

- the dimensionality of the layer’s output (number of neurons)
- the shape of the input data

**Dimensionality**

512 dimension layer: power of 2 as the number of dimensions, is a common practice

**Batch size**

Number of rows in the input data = number of posts to be passed to the model at each training step

Number of columns = vocabulary size (top 1000 most commonly used words)

### Activation function 

Tells our model how to calculate the output of a layer, see [ReLU](http://cs231n.github.io/neural-networks-1/)

**Softmax Activation function**

The model will normalize the evidence for each possible label into a probability (from 0 to 1). In the context of the posts, the probabilities assigned to the 20 tags for a given comment will sum up to 1. Each tag will have a probability between 0 and 1.

[https://en.wikipedia.org/wiki/Softmax_function]()

```python
[continuation from previous snippet]
.
.
.
model = Sequential()
model.add(Dense(512, input_shape=(vocabulary_size,)))
model.add(Activation('relu'))

# The model will take the vocabulary_size input, 
# transform it to a 512-dimensional layer, 
# and transform that into an output layer with 20 probability neurons
# with the help of Keras, provided with shape of the input data,
# the shape of the output data, and the type of each layer
num_labels = 20
model.add(Dense(num_labels))
model.add(Activation('softmax'))
```

Input shape v/s unit v/s dim: [https://gitlab.com/gdgcloud/tensorflow/issues/15#note_100912332]()
