### Code snippets

model.summary()

for layer in base_model.layers[:200]:
       layer.trainable = False

# normalize data
X_train = X_train.astype('float32') / 255.
X_test = X_test.astype('float32') / 255.
# create model
model=Sequential()
model.add(Flatten(input_shape=(img_width, img_height)))
model.add(Dense(128, activation="relu"))
model.add(Dense(num_classes, activation="softmax"))
model.compile(loss="categorical_crossentropy", optimizer="adam",
               metrics=['accuracy'])

### --- 

# normalize data
X_test = X_test.astype("float32") / 255.
X_train = X_train.astype("float32") / 255.

# create model
model=Sequential()
model.add(Reshape((28,28,1), input_shape=(28,28)))
model.add(Conv2D(32, (3,3), padding='same', activation='relu'))
model.add(MaxPooling2D())
model.add(Conv2D(64, (3,3), padding='same', activation='relu'))
model.add(MaxPooling2D())
model.add(Conv2D(128, (3,3), padding='same', activation='relu'))
model.add(MaxPooling2D())
model.add(Dropout(0.4))
model.add(Flatten(input_shape=(img_width, img_height)))
model.add(Dropout(0.4))
model.add(Dense(20, activation='relu'))
model.add(Dropout(0.4))
model.add(Dense(num_classes, activation="softmax"))
model.compile(loss=config.loss, optimizer=config.optimizer,
                metrics=['accuracy'])

### --- 
# A very simple perceptron for classifying american sign language letters
import signdata
import numpy as np
from keras.models import Sequential
from keras.layers import Dense, Flatten, Dropout, BatchNormalization, Conv2D, MaxPooling2D
from keras.callbacks import ReduceLROnPlateau, EarlyStopping
from keras.utils import np_utils
import wandb
from wandb.keras import WandbCallback
# logging code
run = wandb.init()
config = run.config
config.loss = "categorical_crossentropy"
config.optimizer = "adam"
config.first_layer_conv_width = 3
config.first_layer_conv_height = 3
config.epochs = 50
# load data
(X_test, y_test) = signdata.load_test_data()
(X_train, y_train) = signdata.load_train_data()
img_width = X_test.shape[1]
img_height = X_test.shape[2]
# one hot encode outputs
y_train = np_utils.to_categorical(y_train)
y_test = np_utils.to_categorical(y_test)
num_classes = y_train.shape[1]
# you may want to normalize the data here..
X_test = X_test.astype('float32') / 255.
X_train = X_train.astype('float32') / 255.
X_test = X_test.reshape((-1,img_width,img_height,1))
X_train = X_train.reshape((-1,img_width,img_height,1))
# create model
model = Sequential()
model.add(Conv2D(64,
   (config.first_layer_conv_width, config.first_layer_conv_height),
   padding='same',
   input_shape=(img_width, img_height,1),
   activation='relu'))
#model.add(BatchNormalization())
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Dropout(0.2))
model.add(Conv2D(64,
   (config.first_layer_conv_width, config.first_layer_conv_height),
   padding='same',
   input_shape=(img_width, img_height,1),
   activation='relu'))
#model.add(BatchNormalization())
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Dropout(0.2))
model.add(Conv2D(64,
   (config.first_layer_conv_width, config.first_layer_conv_height),
   padding='same',
   input_shape=(img_width, img_height,1),
   activation='relu'))
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Dropout(0.2))
model.add(Flatten(input_shape=(img_width, img_height)))
model.add(Dense(128, activation='relu'))
model.add(Dropout(0.2))
model.add(Dense(num_classes, activation='softmax'))
model.compile(loss=config.loss, optimizer=config.optimizer,
               metrics=['accuracy'])
earlystopping = EarlyStopping(monitor='val_loss', min_delta=0, patience=6, verbose=1, mode='auto', baseline=None, restore_best_weights=True)
reduce_lr = ReduceLROnPlateau(monitor='val_loss', factor=0.1, patience=2, verbose=1, mode='auto', min_delta=0.0001, cooldown=0, min_lr=0.0001)
# Fit the model
model.fit(X_train, y_train, epochs=config.epochs, validation_data=(X_test, y_test), callbacks=[WandbCallback(data_type="image", labels=signdata.letters),reduce_lr,earlystopping])

### ---

from keras.optimizers import RMSprop
trainX = trainX[:, :, np.newaxis]
testX = testX[:, :, np.newaxis]
config.look_back=4
# create and fit the RNN
model = Sequential()
model.add(SimpleRNN(5, input_shape=(config.look_back,1 )))
model.add(Dense(1))
model.compile(loss='mae', optimizer=RMSprop(lr=0.1))
model.fit(trainX, trainY, epochs=1000, batch_size=20, validation_data=(testX, testY),  callbacks=[WandbCallback(), PlotCallback(trainX, trainY, testX, testY, config.look_back)])

### ---

cd ~/ml-class
cat **/*.py > ml-class/lstm/text-gen/code.txt
cd ml-class/lstm/text-gen
python char-gen.py code.txt

### ---

model = Sequential()
model.add(GRU(config.hidden_nodes, input_shape=(config.maxlen, len(chars))))
model.add(Dense(len(chars), activation='softmax'))
model.compile(loss='categorical_crossentropy', optimizer="rmsprop")

### ---

model.add(Bidirectional(LSTM(config.hidden_dims, activation="sigmoid")))

### ---

from keras.layers import Conv1D, Flatten, MaxPool1D
​
​
model = Sequential()
model.add(Embedding(config.vocab_size,
                    config.embedding_dims,
                    input_length=config.maxlen))
model.add(Dropout(0.5))
model.add(Conv1D(config.filters,
                 config.kernel_size,
                 padding='valid',
                 activation='relu'))
#~~~~~~~custom maxpool and Con1D
model.add((MaxPool1D(4)))
model.add(Dropout(0.5))
model.add(Conv1D(config.filters,
                 config.kernel_size,
                 padding='valid',
                 activation='relu'))
model.add((MaxPool1D(4)))
model.add(Dropout(0.5))
#~~~~~~~~~~custom LSTM layer~~~~~~
​
model.add(LSTM(config.hidden_dims, activation="relu", , return_sequences=True))

--

from keras.preprocessing import sequence
from keras.models import Sequential
from keras.layers import Dense, Dropout, Activation, MaxPooling1D
from keras.layers import Embedding, LSTM
from keras.layers import Conv1D, Flatten
from keras.datasets import imdb
import wandb
from wandb.keras import WandbCallback
import imdb
import numpy as np
from keras.preprocessing import text

wandb.init()
config = wandb.config

# set parameters:
config.vocab_size = 1000
config.maxlen = 1000
config.batch_size = 32
config.embedding_dims = 50
config.filters = 250
config.kernel_size = 3
config.hidden_dims = 250
config.epochs = 10

(X_train, y_train), (X_test, y_test) = imdb.load_imdb()
print("Review", X_train[0])
print("Label", y_train[0])

tokenizer = text.Tokenizer(num_words=config.vocab_size)
tokenizer.fit_on_texts(X_train)
X_train = tokenizer.texts_to_sequences(X_train)
X_test = tokenizer.texts_to_sequences(X_test)

X_train = sequence.pad_sequences(X_train, maxlen=config.maxlen)
X_test = sequence.pad_sequences(X_test, maxlen=config.maxlen)
print(X_train.shape)
print("After pre-processing", X_train[0])

model = Sequential()
model.add(Embedding(config.vocab_size,
                    config.embedding_dims,
                    input_length=config.maxlen))
model.add(Dropout(0.5))

model.add(Conv1D(config.filters,
                 config.kernel_size,
                 padding='valid',
                 activation='relu'))

model.add(MaxPooling1D((2))) # size is 499,250

model.add(Conv1D(config.filters,
                 config.kernel_size,
                 padding='valid',
                 activation='relu'))

model.add(Flatten())

model.add(Dropout(0.5)) #


model.add(Dense(config.hidden_dims, activation='relu'))
model.add(Dropout(0.5))


model.add(Dense(1, activation='sigmoid'))

model.compile(loss='binary_crossentropy',
              optimizer='adam',
              metrics=['accuracy'])

model.fit(X_train, y_train,
          batch_size=config.batch_size,
          epochs=config.epochs,
          validation_data=(X_test, y_test), callbacks=[WandbCallback()])

### ---

# create model
model=Sequential()
#model.add(Flatten(input_shape=(img_width, img_height)))
model.add(Reshape((28,28,1), input_shape=(img_width, img_height)))
model.add(Conv2D(8, (3,3) ))
model.add(Dropout(0.3))
model.add(Dense(100, activation="relu"))
model.add(Dropout(0.3))
model.add(Dense(num_classes, activation="softmax"))
model.compile(loss=config.loss, optimizer=config.optimizer,
                metrics=['accuracy'])


# A very simple perceptron for classifying american sign language letters
import signdata
import numpy as np
from keras.models import Sequential
from keras.layers import Dense, Flatten, Dropout, Conv2D, Reshape, MaxPooling2D
from keras.utils import np_utils
import wandb
from wandb.keras import WandbCallback
# logging code
run = wandb.init()
config = run.config
config.loss = "categorical_crossentropy"
config.optimizer = "adam"
config.epochs = 10
# load data
(X_test, y_test) = signdata.load_test_data()
(X_train, y_train) = signdata.load_train_data()
img_width = X_test.shape[1]
img_height = X_test.shape[2]
# one hot encode outputs
y_train = np_utils.to_categorical(y_train)
y_test = np_utils.to_categorical(y_test)
num_classes = y_train.shape[1]
X_train = X_train.astype('float32') / 255.
X_test = X_test.astype('float32') / 255.
# create model
model=Sequential()
#model.add(Flatten(input_shape=(img_width, img_height)))
model.add(Reshape((28,28,1), input_shape=(img_width, img_height)))
model.add(Dropout(0.3))
model.add(Conv2D(8, (3,3) ))
model.add(MaxPooling2D(2,2))
model.add(Dropout(0.3))
model.add(Conv2D(8, (3,3) ))
model.add(MaxPooling2D(2,2))
model.add(Flatten())
model.add(Dropout(0.3))
model.add(Dense(50, activation="relu"))
model.add(Dropout(0.3))
model.add(Dense(num_classes, activation="softmax"))
model.compile(loss=config.loss, optimizer=config.optimizer,
                metrics=['accuracy'])
# Fit the model
model.fit(X_train, y_train, epochs=config.epochs, validation_data=(X_test, y_test), callbacks=[WandbCallback(data_type="image", labels=signdata.letters)])
#print(model.predict(X_train[:2]))

### @vanpelt we add the empty 3rd dimension because Conv2D always 
### expects 3 dimensions. This is because your doing convolutions 
### on multiple channels. For instance color images have Red Green 
### and Blue channels as the 3rd dimension.
### ---
cd ~/ml-class/lstm/imdb-classifier

bash download-imdb.sh
### ---

from keras.preprocessing import sequence
from keras.models import Sequential
from keras.layers import Dense, Dropout, Activation
from keras.layers import Embedding, LSTM
from keras.layers import Conv1D, Flatten, MaxPooling1D, TimeDistributed
from keras.datasets import imdb
import wandb
from wandb.keras import WandbCallback
import imdb
import numpy as np
from keras.preprocessing import text
wandb.init()
config = wandb.config
# set parameters:
config.vocab_size = 1000
config.maxlen = 1000
config.batch_size = 50
config.embedding_dims = 50
config.filters = 250
config.kernel_size = 3
config.hidden_dims = 250
config.epochs = 10
(X_train, y_train), (X_test, y_test) = imdb.load_imdb()
print("Review", X_train[0])
print("Label", y_train[0])
tokenizer = text.Tokenizer(num_words=config.vocab_size)
tokenizer.fit_on_texts(X_train)
X_train = tokenizer.texts_to_sequences(X_train)
X_test = tokenizer.texts_to_sequences(X_test)
X_train = sequence.pad_sequences(X_train, maxlen=config.maxlen)
X_test = sequence.pad_sequences(X_test, maxlen=config.maxlen)
print(X_train.shape)
print("After pre-processing", X_train[0])
cnn = Sequential()
cnn.add(Embedding(config.vocab_size,
                    config.embedding_dims,
                    input_length=config.maxlen))
cnn.add(Dropout(0.5))
cnn.add(Conv1D(config.filters,
                 config.kernel_size,
                 padding='valid',
                 activation='relu'))
cnn.add(Dropout(0.5))
cnn.add(MaxPooling1D((2)))
cnn.add(Flatten())
        
model = Sequential()
model.add(TimeDistributed(cnn))
model.add(LSTM(config.hidden_dims, activation="sigmoid"))
model.add(Dense(1, activation='sigmoid'))
model.compile(loss='binary_crossentropy',
              optimizer='adam',
              metrics=['accuracy'])
model.fit(X_train, y_train,
          batch_size=config.batch_size,
          epochs=config.epochs,
          validation_data=(X_test, y_test), callbacks=[WandbCallback()])

### --- 

# A very simple perceptron for classifying american sign language letters
import signdata
import numpy as np
from keras.models import Sequential
from keras.layers import Dense, Flatten, Dropout, Conv2D, MaxPooling2D, Reshape
from keras.utils import np_utils
import wandb
from wandb.keras import WandbCallback

# logging code
run = wandb.init()
config = run.config
config.loss = "categorical_crossentropy"
config.optimizer = "adam"
config.epochs = 10

# load data
(X_test, y_test) = signdata.load_test_data()
(X_train, y_train) = signdata.load_train_data()

img_width = X_test.shape[1]
img_height = X_test.shape[2]

# one hot encode outputs
y_train = np_utils.to_categorical(y_train)
y_test = np_utils.to_categorical(y_test)

num_classes = y_train.shape[1]

# you may want to normalize the data here..

# normalize data
X_train = X_train.astype('float32') / 255.
X_test = X_test.astype('float32') / 255.

# create model
model=Sequential()
model.add(Reshape((28,28,1),input_shape=(28, 28)))
model.add(Conv2D(32,
    (3,3),
    activation='relu'))
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Flatten(input_shape=(img_width, img_height)))
model.add(Dense(num_classes, activation="softmax"))
model.compile(loss=config.loss, optimizer=config.optimizer,
                metrics=['accuracy'])

# Fit the model
model.fit(X_train, y_train, epochs=10, validation_data=(X_test, y_test), 
          callbacks=[WandbCallback(data_type="image", labels=signdata.letters)])
#print("Target", y_train[:2])
#print("Predictions", model.predict(X_train[:2]))

### ---

# create and fit the RNN
model = Sequential()
model.add(SimpleRNN(100, input_shape=(config.look_back,1)))
model.compile(loss='mae', optimizer='rmsprop')
model.fit(trainX, trainY, epochs=1000, batch_size=20, validation_data=(testX, testY),  callbacks=[WandbCallback(), PlotCallback(trainX, trainY, testX, testY, config.look_back)])

@Lukas suggests:
# create and fit the RNN
model = Sequential()
model.add(SimpleRNN(5, input_shape=(config.look_back,1 )))
model.add(Dense(1))

### ---

wget http://www.gutenberg.org/cache/epub/50742/pg50742.txt 

### ---

model.add(LSTM(25, activation="sigmoid", return_sequences=True))
model.add(LSTM(25, activation="sigmoid", go_backwards=True))

###
### Shows only one layer
### The interface doesn’t show non sequential parts of the graph
### It's just a simplification in the implementation
###

### ---

lstm with drop out code:
## create model
model = Sequential()
model.add(Embedding(config.vocab_size, 100, input_length=config.maxlen, weights=[embedding_matrix], trainable=False))
#
model.add(Bidirectional(LSTM(50, activation="sigmoid", dropout=0.50, recurrent_dropout=0.50)))
model.add(Dense(1, activation='sigmoid'))
model.compile(loss='binary_crossentropy',
             optimizer='rmsprop',
             metrics=['accuracy'])

### ---

X_test = tokenizer.texts_to_sequences(["great movie"])
X_test = sequence.pad_sequences(X_test, maxlen=config.maxlen)
model.predict(X_test)

### ---

phraselist = ['great movie', 'terrible movie']
phrasetokens = tokenizer.texts_to_sequences(phraselist)
phraseseq = sequence.pad_sequences(phrasetokens, maxlen=config.maxlen)
model.predict(phraseseq)
result = model.predict(X_train)
res_error = [val1 - val2 for val1, val2, in zip (y_train, result)]
res_idx_max_error = res_error.index(max(res_error))
res_idx_min_error = res_error.index(min(res_error))
print(str(res_idx_max_error), str(res_idx_min_error))
(X_train2, y_train2), (X_test2, y_test2) = imdb.load_imdb()
print(X_train2[res_idx_max_error])
print(X_train2[res_idx_min_error])
print(X_train2[5244]) ; This is simply the funniest movie I've seen in a long time. The bad acting, bad script, bad scenery, bad costumes, bad camera work and bad special effects are so stupid that you find yourself reeling with laughter.<br /><br />So it's not gonna win an Oscar but if you've got beer and friends round then you can't go wrong.
:joy:
1

print(X_train2[20143]) ; I very much looked forward to this movie. Its a good family movie; however, if Michael Landon Jr.'s editing team did a better job of editing, the movie would be much better. Too many scenes out of context. I do hope there is another movie from the series, they're all very good. But, if another one is made, I beg them to take better care at editing. This story was all over the place and didn't seem to have a center. Which is unfortunate because the other movies of the series were great. I enjoy the story of Willie and Missy; they're both great role models. Plus, the romantic side of the viewers always enjoy a good love story.

### ---

x_train = (counts[0:6000])
y_train = pd.get_dummies(fixed_target[0:6000])
y_train.values

x_test = (counts[6000:])
y_test = pd.get_dummies(fixed_target[6000:])


from keras.datasets import mnist
from keras.models import Sequential
from keras.layers import Dense, Flatten
import wandb
from wandb.keras import WandbCallback

num_classes = 4
length=counts.shape[1]
# create model
model = Sequential()
model.add(Dense(num_classes, input_shape=(length,),activation='softmax'))
model.compile(loss='categorical_crossentropy', optimizer='adam',
              metrics=['accuracy'])

# Fit the model
model.fit(x_train,y_train, epochs=10, validation_data=(x_test, y_test))

### ---

git clone https://github.com/lukas/keras-audio

### ---

config.epochs = 400
config.batch_size = 100
config.first_layer_conv_width = 5
num_conv = 64
model.add(Conv2D(num_conv,
    (config.first_layer_conv_width, config.first_layer_conv_height),
    input_shape=(config.buckets, config.max_len, channels),
    activation='relu', padding='same'))
model.add(Dropout(0.2))
model.add(Conv2D(num_conv,
    (config.first_layer_conv_width, config.first_layer_conv_height),
    #input_shape=(config.buckets, config.max_len, channels),
    activation='relu', padding='same'))
model.add(MaxPooling2D(pool_size=(2, 2)))

model.add(Dropout(0.2))

model.add(Conv2D(num_conv,
    (config.first_layer_conv_width, config.first_layer_conv_height),
    #input_shape=(config.buckets, config.max_len, channels),
    activation='relu', padding='same'))

model.add(Dropout(0.2))
model.add(Conv2D(num_conv,
    (config.first_layer_conv_width, config.first_layer_conv_height),
    #input_shape=(config.buckets, config.max_len, channels),
    activation='relu', padding='same'))
model.add(MaxPooling2D(pool_size=(2, 2)))

model.add(Dropout(0.2))

model.add(Conv2D(num_conv,
    (config.first_layer_conv_width, config.first_layer_conv_height),
    #input_shape=(config.buckets, config.max_len, channels),
    activation='relu', padding='same'))

model.add(Dropout(0.2))
model.add(Conv2D(num_conv,
    (config.first_layer_conv_width, config.first_layer_conv_height),
    #input_shape=(config.buckets, config.max_len, channels),
    activation='relu', padding='same'))
model.add(MaxPooling2D(pool_size=(2, 2)))

model.add(Dropout(0.2))
model.add(Flatten())
model.add(Dense(num_dense, activation='relu'))
model.add(Dropout(0.2))
model.add(Dense(num_dense, activation='relu'))
model.add(Dropout(0.2))
model.add(Dense(num_classes, activation='softmax'))
model.compile(loss="categorical_crossentropy",
                  optimizer="adam",
                  metrics=['accuracy'])



### ---

from preprocess import *
import keras
from keras.models import Sequential
from keras.layers import Dense, Dropout, Flatten, Conv2D, MaxPooling2D, Reshape
from keras.layers import Activation, BatchNormalization
from keras import regularizers
from keras.callbacks import LearningRateScheduler, ReduceLROnPlateau
from keras.utils import to_categorical
import wandb
from wandb.keras import WandbCallback
def lr_schedule(epoch):
   lrate = 0.001
   if epoch > 75:
       lrate = 0.0005
   elif epoch > 100:
       lrate = 0.0003
   return lrate
reduce_lr = ReduceLROnPlateau(monitor='val_loss', factor=0.2, patience=5, min_lr=0.001)
wandb.init()
config = wandb.config
config.max_len = 11
config.buckets = 20
config.filters = 250
config.kernel_size = 3
# Save data to array file first
#save_data_to_array(max_len=config.max_len, n_mfcc=config.buckets)
labels=["bed", "happy", "cat"]
# # Loading train set and test set
X_train, X_test, y_train, y_test = get_train_test()
# # Feature dimension
channels = 1
config.epochs = 50
config.batch_size = 100
num_classes = 3
X_train = X_train.reshape(X_train.shape[0], config.buckets, config.max_len, channels)
X_test = X_test.reshape(X_test.shape[0], config.buckets, config.max_len, channels)
y_train_hot = to_categorical(y_train)
y_test_hot = to_categorical(y_test)
weight_decay = 1e-4
model = Sequential()
model.add(Conv2D(config.filters, (3,3), padding='same', kernel_regularizer=regularizers.l2(weight_decay), input_shape=X_train.shape[1:], activation='relu'))
model.add(BatchNormalization())
model.add(Conv2D(config.filters, (3,3), padding='same', kernel_regularizer=regularizers.l2(weight_decay), activation='relu'))
model.add(BatchNormalization())
model.add(MaxPooling2D(pool_size=(2,2)))
model.add(Dropout(0.3))
model.add(Conv2D(config.filters, (3,3), padding='same', kernel_regularizer=regularizers.l2(weight_decay), input_shape=X_train.shape[1:], activation='relu'))
model.add(BatchNormalization())
model.add(Conv2D(config.filters, (3,3), padding='same', kernel_regularizer=regularizers.l2(weight_decay), activation='relu'))
model.add(BatchNormalization())
model.add(MaxPooling2D(pool_size=(2,2)))
model.add(Dropout(0.3))
model.add(Flatten(input_shape=(config.buckets, config.max_len, channels)))
model.add(Dense(num_classes, activation='softmax'))
model.compile(loss="categorical_crossentropy",
                 optimizer="rmsprop",
                 metrics=['accuracy'])
model.fit(X_train, y_train_hot, batch_size=config.batch_size, epochs=config.epochs, validation_data=(X_test, y_test_hot), callbacks=[WandbCallback(data_type="image", labels=labels), reduce_lr])

### ---

def create_categorical_decoder():
    '''
    Create the decoder with an optional class appended to the input.
    '''
    decoder_input = layers.Input(shape=(wandb.config.latent_dim,))
    label_input = layers.Input(shape=(len(wandb.config.labels),))
    if wandb.config.conditional:
        x = layers.concatenate([decoder_input, label_input], axis=-1)
    else:
        x = decoder_input
    x = layers.Dense(128, activation='relu')(x)
    x = layers.Dense(img_size * img_size, activation='relu')(x)
    x = layers.Reshape((img_size, img_size, 1))(x)
    x = layers.Conv2D(64, 3, activation="relu", padding="same")(x)
    x = layers.Conv2D(1, 3, activation="sigmoid", padding="same")(x)
​
    return Model([decoder_input, label_input], x, name='decoder')

def create_encoder(input_shape):
    '''
    Create an encoder with an optional class append to the channel.
    '''
    encoder_input = layers.Input(shape=input_shape)
    label_input = layers.Input(shape=(len(wandb.config.labels),))
    #x = layers.Flatten()(encoder_input)
    if wandb.config.conditional:
        x = layers.Lambda(concat_label, name="c")([encoder_input, label_input])
        #x = layers.concatenate([x, label_input], axis=-1)
​
    x = layers.Conv2D(64, 3, activation="relu")(x)
    x = layers.MaxPooling2D()(x)
    x = layers.Conv2D(32, 3, activation="relu")(x)
    x = layers.Flatten()(x)
    x = layers.Dense(128, activation="relu")(x)
    output = layers.Dense(wandb.config.latent_dim, activation="relu")(x)
​
    return Model([encoder_input, label_input], output, name='encoder')

### ---

# A very simple perceptron for classifying american sign language letters
import signdata
import numpy as np
from keras.models import Sequential
from keras.layers import Dense, Flatten, Dropout, Conv2D, MaxPooling2D, Reshape
from keras.utils import np_utils
import wandb
from wandb.keras import WandbCallback

# logging code
run = wandb.init()
config = run.config
config.loss = "categorical_crossentropy"
config.optimizer = "adam"
config.epochs = 10

# load data
(X_test, y_test) = signdata.load_test_data()
(X_train, y_train) = signdata.load_train_data()

img_width = X_test.shape[1]
img_height = X_test.shape[2]

# one hot encode outputs
y_train = np_utils.to_categorical(y_train)
y_test = np_utils.to_categorical(y_test)

num_classes = y_train.shape[1]

# you may want to normalize the data here..

# normalize data
X_train = X_train.astype('float32') / 255.
X_test = X_test.astype('float32') / 255.

X_train = X_train.reshape(
    X_train.shape[0], img_width, img_height, 1)
X_test = X_test.reshape(
    X_test.shape[0], img_width, img_height, 1)

# create model
model = Sequential()
model.add(Conv2D(32, (3,3), input_shape=(img_width, img_height, 1)))
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Conv2D(32, (3,3)))
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Flatten())
model.add(Dense(100, activation="relu"))
model.add(Dropout(0.2))
model.add(Dense(num_classes, activation="softmax"))
model.compile(loss=config.loss, optimizer=config.optimizer,
              metrics=['accuracy'])

# Fit the model
model.fit(X_train, y_train, epochs=10, validation_data=(X_test, y_test),
          callbacks=[WandbCallback(data_type="image", labels=signdata.letters)])


### ---

# create and fit the RNN
model = Sequential()
model.add(SimpleRNN(10, input_shape=(config.look_back, 1)))
model.add(Dense(1))
model.compile(loss='mae', optimizer='rmsprop', metrics=['accuracy'])
model.fit(trainX, 
          trainY, 
          epochs=100, 
          batch_size=20, 
          validation_data=(testX, testY),  
          callbacks=[
              
              PlotCallback(trainX, trainY, testX, testY, config.look_back),
              WandbCallback()]
         )

### ---

import keras
​
model = keras.models.Sequential()
#TO stack multiple LSTM's add return_sequences=True
model.add(keras.layers.LSTM(128, return_sequences=True, input_shape=(10,1))
model.add(keras.layers.LSTM(64))
model.add(Dense(1, activation='sigmoid'))


### ---

self.model.add(LSTM(self.nb_units, 
                        input_shape=(X_scl_re.shape[1], X_scl_re.shape[2])))
self.model.add(Dense(1))
self.model.compile(loss='mae', optimizer='adam')
self.model.fit(X_scl_re, y_scl, 
                   epochs    =self.epochs, 
                   batch_size=self.batch_size, 
                   verbose   =self.verbose, 
                   shuffle   =False)

### ---