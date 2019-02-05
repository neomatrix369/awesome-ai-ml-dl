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

# Read our dataset using pandas
data = pd.read_csv("stack-overflow.csv")

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

encoder = LabelBinarizer()
encoder.fit(train_tags)
y_train = encoder.transform(train_tags)

# training dataset: one-hot vectors of the tags per post
# [[0 0 0 ... 0 1 0]
#  [0 0 0 ... 0 0 0]
#  [0 0 0 ... 0 0 0]
#  ...
#  [0 0 0 ... 0 0 0]
#  [0 0 0 ... 1 0 0]
#  [0 0 0 ... 0 0 0]]

y_test = encoder.transform(test_tags)

# test dataset: one-hot vectors of the tags per post
# [[0 0 0 ... 0 0 1]
#  [0 0 0 ... 0 0 0]
#  [0 0 0 ... 0 0 0]
#  ...
#  [0 0 0 ... 0 0 0]
#  [0 0 0 ... 0 0 0]
#  [0 0 0 ... 0 0 0]]

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

# compile model: using loss function crossentropy, optimizer adam, evaluating the accuracy metrics
model.compile(loss='categorical_crossentropy', 
              optimizer='adam', 
              metrics=['accuracy'])

# x_train = training data (features) 
# y_train = labels (target)
# Train the model using the training set and various training parameters: batch_size, epoch, validation_split
batch_size=40000
history = model.fit(x_train, y_train, 
                    batch_size=batch_size, 
                    epochs=2, 
                    verbose=1, 
                    validation_split=0.1)

# Accuracy: applying the test training set on the model
score = model.evaluate(x_test, y_test, 
                       batch_size=batch_size, verbose=1)
print('Test score:', score[0])
print('Test accuracy:', score[1])
# model defined in 5 lines of code (above)

# This utility function is from the sklearn docs: http://scikit-learn.org/stable/auto_examples/model_selection/plot_confusion_matrix.html
def plot_confusion_matrix(cm, classes,
                          title='Confusion matrix',
                          cmap=plt.cm.Blues):
    """
    This function prints and plots the confusion matrix.
    Normalization can be applied by setting `normalize=True`.
    """

    cm = cm.astype('float') / cm.sum(axis=1)[:, np.newaxis]

    plt.imshow(cm, interpolation='nearest', cmap=cmap)
    plt.title(title, fontsize=30)
    plt.colorbar()
    tick_marks = np.arange(len(classes))
    plt.xticks(tick_marks, classes, rotation=45, fontsize=22)
    plt.yticks(tick_marks, classes, fontsize=22)

    fmt = '.2f'
    thresh = cm.max() / 2.
    for i, j in itertools.product(range(cm.shape[0]), range(cm.shape[1])):
        plt.text(j, i, format(cm[i, j], fmt),
                 horizontalalignment="center",
                 color="white" if cm[i, j] > thresh else "black")

    plt.ylabel('True label', fontsize=25)
    plt.xlabel('Predicted label', fontsize=25)

# Prepare and apply the confusion matrix on the training and test set results
y_softmax = model.predict(x_test)

y_test_1d = []
y_pred_1d = []

for i in range(len(y_test)):
    probs = y_test[i]
    index_arr = np.nonzero(probs)
    one_hot_index = index_arr[0].item(0)
    y_test_1d.append(one_hot_index)

for i in range(0, len(y_softmax)):
    probs = y_softmax[i]
    predicted_index = np.argmax(probs)
    y_pred_1d.append(predicted_index)

text_labels = encoder.classes_
cnf_matrix = confusion_matrix(y_test_1d, y_pred_1d)
plt.figure(figsize=(24,20))
plot_confusion_matrix(cnf_matrix, classes=text_labels, title="Confusion matrix")
plt.show()

# Generating predictions from our test set (10 posts):
print()
print("*** Predictions using 10 posts from the test set ***")
for i in range(10):
    prediction = model.predict(np.array([x_test[i]]))
    predicted_label = text_labels[np.argmax(prediction)]
    print(test_posts.iloc[i][:50], "...")
    print("Actual label: " + test_tags.iloc[i])
    print("Predicted label: " + predicted_label + "\n")
