# normalize data
X_train = X_train.astype('float32') / 255.
X_test = X_test.astype('float32') / 255.
N_train = X_train.shape[0]
N_test = X_test.shape[0]
X_train = X_train.reshape(N_train, 28,28,1)
X_test = X_test.reshape(N_test, 28,28,1)

# create model
print ('test dimension:....', X_train.shape)
model=Sequential()
#model.add(Flatten(input_shape=(img_width, img_height)))
#model.add(Dense(128, activation="relu"))
#model.add(Dense(num_classes, activation="softmax"))

#~~~~~~~~~~~~

con_width = 16
conv_height = 16
model.add(Conv2D(32,(con_width, conv_height), input_shape=(28, 28,1), activation='relu'))
model.add(MaxPooling2D(pool_size=(2, 2)))
model.add(Flatten())
dense_layer_size = 128
model.add(Dense(dense_layer_size, activation='relu'))
model.add(Dense(num_classes, activation='softmax'))
#~~~~~~~~~~~~~~~~
# create model
#model=Sequential()
#model.add(Flatten(input_shape=(img_width, img_height)))
#model.add(Dense(num_classes))
#model.compile(loss=config.loss, optimizer=config.optimizer,
#                metrics=['accuracy'])

model.compile(loss="categorical_crossentropy", optimizer="adam",
               metrics=['accuracy'])