## Time-series / anomaly detection

- [Time-series](#timeseries)
  - [Notebooks](#notebooks)
- [Anomaly detection](#anomaly-detection)
- [Contributing](#contributing)

---

### Time-series

- [Introductory](time-series.md#introductory)
- [Classification](time-series.md#classification)
- [Feature engineering](time-series.md#feature-engineering)
- [ES-RNN](time-series.md#es-rnn)
- [WaveNet](time-series.md#wavenet)
- [DeepAR](time-series.md#deepar)
- [Methods: ARMA/ARIMA/SARIMA and others](time-series.md#methods-armaarimasarima-and-others)
- [Non-stationary Time-series](time-series.md#non-stationary-time-series)
- [Generalized Additive Models](time-series.md#generalized-additive-models)
- [Courses / Tutorials / Workshops](time-series.md#courses--tutorials--workshops)
- [Applied Time series](time-series.mdapplied-time-series)
- [Gaussian process](time-series.md#gaussian-process)
- [Neural Networks & Deep Learning](time-series.md#neural-networks--deep-learning)
- [Forecasting](time-series.md#forecasting)
- [Forecasting using Prophet](time-series.md#forecasting-using-prophet)
- [Prediction](time-series.md#prediction)
- [Trend estimation / trend analysis](time-series.md#trend-estimation--trend-analysis)
- [Notebooks](time-series.md#notebooks)
- [Tools, libraries, frameworks](#tools,-libraries,-frameworks)
- [Misc](time-series.md#misc)

#### Notebooks

See [Notebooks under more time-series resources](./time-series.md#notebooks)

### Anomaly detection
  - H2O
    - [Unsupervised anomaly detection, using H2O-3's Deep Learning autoencoders](http://docs.h2o.ai/h2o/latest-stable/h2o-docs/booklets/DeepLearningBooklet.pdf)
    - [Anomaly Detection via H2O Deep Learning Model](http://docs.h2o.ai/h2o/latest-stable/h2o-r/docs/reference/h2o.anomaly.html)
    - [Anomaly Detection: Increasing Classification Accuracy with H2O's Autoencoder and R](http://amunategui.github.io/anomaly-detection-h2o/)
    - [H2O - Autoencoders and anomaly detection (Python)](https://www.kaggle.com/imrandude/h2o-autoencoders-and-anomaly-detection-python)
    - [Anomaly Detection Using H2O Deep Learning ](https://dzone.com/articles/dive-deep-into-deep-learning-using-h2o-1)
    - [How to create a model for anomaly detection in H2O-R](https://stackoverflow.com/questions/46243483/how-to-create-a-model-for-anomaly-detection-in-h2o-r)
    - [Anomaly Detection with Deep Learning in R with H2O](https://aichamp.wordpress.com/2017/06/30/anomaly-detection-with-deep-learning-in-r-with-h2o/)
    - [H2O: A hybrid and hierarchical outlier detection method for large scale data protection](https://www.semanticscholar.org/paper/H2O%3A-A-hybrid-and-hierarchical-outlier-detection-Zhang-Qiao/ab481acc3493e6d640883f2fe007444d852be5b8)
    - [(Video) Anomaly Detection: Increasing Classification Accuracy with H2O's Autoencoder and R](https://www.youtube.com/watch?v=bRbrOQHpvNc)
    - [Applying Machine Learning Using H2O](https://www.youtube.com/watch?v=9W_c2Ec23PM)
    - [(Video) Using H2O for Mobile Transaction Forecasting & Anomaly Detection - Capital One](https://www.youtube.com/watch?v=e0vOTY6QdO4)
    - [(Video) Using H2O Two Ways for Mobile Transaction Forecasting & Anomaly Detection - Rahul Gupta, Capital One](https://www.youtube.com/watch?v=DzP-ppiSX_0)
    - [(Video) Anomaly Detection and Feature Engineering by Arno Candel](https://www.youtube.com/watch?v=fUSbljByXak)
  - [Anomaly Detection for Time Series Data with Deep Learning](https://www.infoq.com/articles/deep-learning-time-series-anomaly-detection)
  - [Unsupervised Anomaly Detection](https://www.kaggle.com/victorambonati/unsupervised-anomaly-detection)
  - [Anomaly/Fraud Detection in Credit Card Transactions](https://rpubs.com/mr148/316143)
  - [Autoencoders and anomaly detection with machine learning in fraud analytics](https://www.r-bloggers.com/autoencoders-and-anomaly-detection-with-machine-learning-in-fraud-analytics/)
  - [Introduction to Anomaly Detection](https://www.datascience.com/blog/python-anomaly-detection)
  - [Machine Learning Basics — Part 4 — Anomaly Detection, Recommender Systems and Scaling](https://towardsdatascience.com/machine-learning-basics-part-4-anomaly-detection-recommender-systems-and-scaling-b8bbf0413aa9)
  - [Outlier Detection and Anomaly Detection with Machine Learning](https://medium.com/@mehulved1503/outlier-detection-and-anomaly-detection-with-machine-learning-caa96b34b7f6)
  - [Open source Anomaly Detection in Python](https://datascience.stackexchange.com/questions/6547/open-source-anomaly-detection-in-python)
  - [learnmachinelearning on Reddit.com](https://www.reddit.com/r/learnmachinelearning/duplicates/9wju66/anomaly_detection_part_1_machine_learning_tutorial)
  - [Anomaly detection resources on Medium.com](https://medium.com/search?q=anomaly%20detection)
  - [Videos by Ashrith Barthur on Security, Time-series and Anomaly detection](https://www.youtube.com/results?search_query=h2o+ashrith)
  - [(Video) A review of machine learning techniques for anomaly detection - Dr David Green](https://www.youtube.com/watch?v=LRqX5uO5StA)
  - [(Video) Unsupervised Anomaly Detection with Isolation Forest by Elena Sharova](https://www.youtube.com/watch?v=5p8B2Ikcw-k)
  - [(Video) Anomaly Detection: Algorithms, Explanations, Applications](https://www.youtube.com/watch?v=12Xq9OLdQwQ)
  - [How to use machine learning for anomaly detection and condition monitoring](https://towardsdatascience.com/how-to-use-machine-learning-for-anomaly-detection-and-condition-monitoring-6742f82900d7?source=---------13---------------------)
  - [AnomalyDetection R package by @Twitter](https://github.com/twitter/AnomalyDetection)
  - [Pycularity - Python port of @Twitter's AnomalyDetection](https://github.com/zrnsm/pyculiarity)
  - [Accurate anomaly detection](https://www.linkedin.com/posts/data-science-central_accurate-anomaly-detection-with-machine-learning-activity-6621433059633958912-2Ccp)
  - [Introduction to Anomaly Detection in Python with PyCaret](https://towardsdatascience.com/introduction-to-anomaly-detection-in-python-with-pycaret-2fecd7144f87?source=search_post)
  - [Automated Anomaly Detection Using PyCaret](https://towardsdatascience.com/automated-anomaly-detection-using-pycaret-5e40df75fe36?source=search_post)
  - [A Simplified approach using PyCaret for Anomaly Detection](https://towardsdatascience.com/a-simplified-approach-using-pycaret-for-anomaly-detection-7d33aca3f066?source=search_post)
  - [Anomaly Detection Using PyCaret!!!](https://medium.com/@insaid/anomaly-detection-using-pycaret-38b267ed638b?source=search_post)

### [Tools, libraries, frameworks](#tools,-libraries,-frameworks)

- [STUMPY is a powerful and scalable library that efficiently computes something called the matrix profile, which can be used for a variety of time series data mining tasks](https://stumpy.readthedocs.io/en/latest/)
- [Introduction to Matrix Profiles](https://towardsdatascience.com/introduction-to-matrix-profiles-5568f3375d90)
- Time Series data mining using the Matrix Profile: 
[1](https://www.cs.ucr.edu/~eamonn/MatrixProfile.html) | 
[2](https://www.cs.ucr.edu/~eamonn/Matrix_Profile_Tutorial_Part1.pdf) | 
[3](https://www.cs.ucr.edu/~eamonn/Matrix_Profile_Tutorial_Part2.pdf)
- [A lot of detailed tutorials about using Stumpy for the matrix profile](https://medium.com/@seanmylaw/stumpy-fdb9f8f1f261)
- [Greykite lib by LinkedIN: forecasting library](https://www.kaggle.com/misalraj/greykite-a-library-for-time-series-forecasting)
- [GluonTS: Probabilistic time series forecasting](https://www.kaggle.com/c/m5-forecasting-uncertainty/discussion/133762)
- [Auto_TS: Auto_TimeSeries](https://github.com/AutoViML/Auto_TS)
- [Sktime: A unified framework for machine learning with time series](https://github.com/alan-turing-institute/sktime) | [site](https://www.sktime.org/en/latest/)
  + [sktime-dl](https://github.com/sktime/sktime-dl)
  + [SKTime - How to get started](https://www.sktime.org/en/latest/how_to_get_started.html)
  + [Loading data in SKTime](https://www.sktime.org/en/latest/examples/loading_data.html)
  + [SKTime - Examples](https://github.com/alan-turing-institute/sktime/tree/master/examples)
+ [TSLearn](https://github.com/tslearn-team/tslearn)



# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../CONTRIBUTING.md) guidelines, also have a read about our [licensing](../LICENSE.md) policy.

---

Back to [main page (table of contents)](../README.md)