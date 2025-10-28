## Generating predictions
		
Generating predictions from our test set (10 posts):

**Prediction is a 1 x 20 array**

- 1 row for the individual question and 
- 20 columns for the softmax probability that the question belongs to each tag

```python
                      Soft-max probability 
                      1          2          3 ............................................................................................................17         18         19         20

Post / question 1: [[ 0.035122   0.0525143  0.04665482 0.03087421 0.04945755 0.04454953  0.05538891 0.04946503 0.05209111 0.04382939 0.06006313 0.03791315 0.04654749 0.0567143  0.0612176  0.04509009 0.04057882 0.05607563 0.04742542 0.08842764 ]]
...
Post / question 10: [[ 0.0514174  0.05988472 0.03506042 0.05510889 0.057019   0.07015759 0.03882108 0.04200881 0.05806141 0.04159576 0.03317482 0.06504709 0.03825157 0.0375072  0.05470523 0.04853171 0.0327369  0.05431218 0.05853014 0.06806804 ]]
```

**Source code**

```python
[continuation from previous snippet]
.
.
.
print()
print("*** Predictions using 10 posts from the test set ***")
for i in range(10):
    prediction = model.predict(np.array([x_test[i]]))
    predicted_label = text_labels[np.argmax(prediction)]
    print(test_posts.iloc[i][:50], "...")
    print("Actual label:" + test_tags.iloc[i])
    print("Predicted label: " + predicted_label + "\n")
```

**Output**
```text
*** Predictions using 10 posts from the test set ***
sql join with count and group  would you please be ...
Actual label:sql
Predicted label: sql

error when calling a method that returns a string  ...
Actual label:c#
Predicted label: angularjs

how can i define how long a client was visiting a  ...
Actual label:php
Predicted label: c#

how to apply the navigation bar color to the statu ...
Actual label:ios
Predicted label: css

performance issue on mysql database  i have table  ...
Actual label:mysql
Predicted label: sql

how do i make my links appear as images  and have  ...
Actual label:css
Predicted label: css

why public variables cannot be declared as var typ ...
Actual label:c#
Predicted label: c#

keytool error java.io.ioexception invalid keystore ...
Actual label:android
Predicted label: css

python: lambda function  i m relatively new to lam ...
Actual label:python
Predicted label: sql

how to pass information to the view layer during a ...
Actual label:c#
Predicted label: objective-c
```

## Source file of the notebook

[https://github.com/tensorflow/workshops/blob/master/extras/keras-bag-of-words/keras-bow-model.ipynb](https://github.com/tensorflow/workshops/blob/master/extras/keras-bag-of-words/keras-bow-model.ipynb)

[keras-bow-model.ipynb](./data-scripts-notebooks/keras-bow-model.ipynb)