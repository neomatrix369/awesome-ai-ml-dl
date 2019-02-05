## Processing output labels

### Representations

Post: Write once, run anywhere.....

Tag: Java

**5-tags index**
```
[javascript, python, cobol, java, ruby]
```
**One-hot vector**

Representation of tag in the post
```
[0 0 0 1 0]
```

**A vector of probabilities**
```
[ 0.08078627  0.24490279  0.21754906  0.23220219  0.22455971 ]
```

### LabelBinarizer class of scikit-learn

Makes it easy to build these one-hot vectors

```python
[continuation from previous snippet]
.
.
.
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
```