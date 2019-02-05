### Processing input features

**Install pandas**

```bash
pip2.7 install --user pandas
or
pip3 install --user pandas
```

**Install Scikit-learn**

```bash
pip2.7 install numpy scipy scikit-learn
or
pip3 install numpy scipy scikit-learn
```
**Install matplotlib**

```bash
pip2.7 install matplotlib
or
pip3 install matplotlib
```

**Input CSV file**

[https://storage.googleapis.com/tensorflow-workshop-examples/stack-overflow-data.csv]()

**Source code**

```python
import itertools

import pandas as pd

from keras.preprocessing import text
from keras.models import Sequential
from keras.layers import Dense, Activation

from sklearn.preprocessing import LabelBinarizer
from sklearn.metrics import confusion_matrix

import numpy as np

import matplotlib.pyplot as plt

some_array = ['listview', 'strftime', 'studio', 'isnan', 'script']
 
some_sentence = "How to make a ListView in Android Studio"

# dense vector representation of contents of the tokens in 'some_sentence' and in 'some_array'
dense_vector_array = [1, 0, 1, 0, 0]
# 1 = presence of a tokens in 'some_array' in the 'some_sentence'
# 0 = absence of a tokens in 'some_array' in the 'some_sentence'

# Read our dataset using pandas - contains 100,000 unique words
data = pd.read_csv("stack-overflow-data.csv")
```

#### Tokeniser class in Keras

[https://keras.io/preprocessing/text/#tokenizer]()

```python
[continuation from previous snippet]
.
.
.
# Split dataset into 80% training data and 20% test data
EIGHTY_PERCENT = 80 / 100       
train_size = int(len(data) * EIGHTY_PERCENT)
train_posts = data['post'][:train_size]
train_tags = data['tags'][:train_size]
# which means 20% will be test data 
test_posts = data['post'][train_size:]
test_tags = data['tags'][train_size:]

# the vocabulary size for our model - the top 1000 most commonly used words
vocabulary_size = 1000

# Use Kera's Tokenizer class
tokenize = text.Tokenizer(num_words=vocabulary_size)
tokenize.fit_on_texts(train_posts)

# Create the training data from the collection of posts to pass to the model
# Creates a vocabulary_size “bag” array, with 1s indicating the indices 
# where words in a question are present in the vocabulary
x_train = tokenize.texts_to_matrix(train_posts)

# training dataset: 1s and 0s representation of the tokens in the StackOverflow posts data
# 
# [[0. 1. 1. ... 0. 0. 0.]
#  [0. 1. 1. ... 0. 0. 0.]
#  [0. 1. 1. ... 0. 0. 0.]
#  ...
#  [0. 1. 1. ... 0. 0. 0.]
#  [0. 1. 1. ... 0. 0. 1.]
#  [0. 0. 1. ... 0. 0. 0.]]
# 

# Similarly, tokenize the test data set
x_test = tokenize.texts_to_matrix(test_posts)

# test dataset: 1s and 0s representation of the tokens in the StackOverflow posts data
# [[0. 1. 1. ... 0. 0. 0.]
#  [0. 1. 1. ... 0. 0. 0.]
#  [0. 0. 1. ... 0. 0. 0.]
#  ...
#  [0. 0. 1. ... 0. 0. 0.]
#  [0. 1. 1. ... 0. 0. 0.]
#  [0. 1. 1. ... 0. 0. 0.]]
```
