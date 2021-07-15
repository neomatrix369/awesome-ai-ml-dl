# Data Generation

### Generate numeric data fitting a model/distribution (to fit linear model / ring / etc)

- [Website to generate syntheric data](https://www.mockaroo.com)
- [Synthetic data generation — a must-have skill for new data scientists](https://towardsdatascience.com/synthetic-data-generation-a-must-have-skill-for-new-data-scientists-915896c0c1ae)
- [Surprising Uses of Synthetic Random Data Sets](https://www.linkedin.com/posts/data-science-central_surprising-uses-of-synthetic-random-data-activity-6612404601515765760-J0AY)
- [Synthetic Data Vault (SDV): A Python Library to generate complex datasets using statistical & machine learning models](https://www.linkedin.com/posts/philipvollet_machinelearning-datascience-deeplearning-activity-6737635714676219904-CKE0)
- [zpy: Synthetic data in Blender • Collecting, labeling, and cleaning data](https://www.linkedin.com/feed/update/urn:li:activity:6787600161246969856/)
- Synthetic Data for Deep Learning: Sergey I. Nikolenko: [Post 1](https://lnkd.in/dc8DtSw) | [Post 2](https://www.linkedin.com/posts/montrealai_deeplearning-generativemodels-machinelearning-activity-6685175468045418496-XHVp)
- [Python Random Data Generation](https://honingds.com/blog/python-random/)
- [Random Number Generation and Sampling Methods](https://www.codeproject.com/Articles/1190459/Random-Number-Generation-and-Sampling-Methods)
- [How to Generate Test Datasets in Python with scikit-learn](https://machinelearningmastery.com/generate-test-datasets-python-scikit-learn/)
    - Python packages
        - [scikit datasets package](https://scikit-learn.org/stable/modules/classes.html#module-sklearn.datasets)
        - [Generate data using Python libraries](https://stackoverflow.com/questions/47542752/python-generate-random-time-series-data-with-trends-e-g-cyclical-exponential)
    - R packages
        - [Distributions generation package in R](https://www.reddit.com/r/statistics/comments/4trcp4/data_generation_programs/)
        - [sythpop - an R package that generates data](https://www.r-bloggers.com/generating-synthetic-data-sets-with-synthpop-in-r/)
        - [Another R package](https://stackoverflow.com/questions/11820532/generating-synthetic-data-for-unsupervised-learning)
        - [Set of R examples](https://stackoverflow.com/questions/49702979/generate-data-by-using-existing-dataset-as-the-base-dataset)
        - [Very good examples of how R’s packages can be used to generate datasets time series, adjusting correlations and visualise them](https://stackoverflow.com/questions/8972244/artificial-dataset-generator-for-classification-data) 
        - [Examples of how Scikit and R’s packages can be used to generate synthetic data](https://stackoverflow.com/questions/34023177/how-to-create-a-synthetic-dataset)

### Generate random data matching a rule or type (people’s names / phone numbers / etc, financial data, etc)

- [Random database/dataframe generator](https://pydbgen.readthedocs.io/en/latest/#)
- [MyRiad Toolkit](https://github.com/TU-Berlin-DIMA/myriad-toolkit) (Paper: http://vldb.org/pvldb/vol5/p1890_alexanderalexandrov_vldb2012.pdf) - focuses on how to generate massive amounts of data following a database schema (create data for your relational db with users, orders, etc)
- [Generating Synthetic Data to Match Data Mining Patterns](https://www.researchgate.net/publication/3420044_Generating_Synthetic_Data_to_Match_Data_Mining_Patterns)
- [Data Mining Process  ➡ Techniques, Tools & Examples ⬅](https://www.linkedin.com/posts/asif-bhat_data-mining-activity-6621054656615407616-9r8R)
- [Databake: Generate realistic test data for product dev and demos.](https://www.databake.io/)

### Generate data from existing

- [SMOTE with Imbalance Data](https://www.kaggle.com/qianchao/smote-with-imbalance-data)
- SMOTE library:
  - [PyPi](https://pypi.org/search/?q=smote&o=-zscore) 
  - [Docs](https://imbalanced-learn.readthedocs.io/en/stable/generated/imblearn.over_sampling.SMOTE.html)
  - [SMOTE explained](http://rikunert.com/SMOTE_explained)
  - [ML | Handling Imbalanced Data with SMOTE and Near Miss Algorithm in Python](https://www.geeksforgeeks.org/ml-handling-imbalanced-data-with-smote-and-near-miss-algorithm-in-python/)
  - SMOTE for Imbalanced Classification with Python: [original post](https://www.linkedin.com/posts/jasonbrownlee_smote-for-imbalanced-classification-with-activity-6663153292283121664-EBgy) | [blog](https://machinelearningmastery.com/smote-oversampling-for-imbalanced-classification/)
- [imbalanced-learn library](https://imbalanced-learn.readthedocs.io/en/stable/introduction.html)
- [SO discussion on using Python libraries](https://stackoverflow.com/questions/51322554/smote-with-missing-values)
- [Simple example of how stock prices can be generated](https://stackoverflow.com/questions/8597731/are-there-known-techniques-to-generate-realistic-looking-fake-stock-data)
- [How to Combine Oversampling and Undersampling for Imbalanced Classification](https://machinelearningmastery.com/combine-oversampling-and-undersampling-for-imbalanced-classification/)
- [How to deal with the imbalanced class using under-sampling strategy in PyCaret 2.0 👇 👇 👇](https://www.linkedin.com/posts/profile-moez_datascience-machinelearning-opensource-activity-6701323647535075328-4odN)
- [Generate duplicates and null rows from existing dataset](../notebooks/jupyter/data/data-generation/README.md) | [folder with scripts](../notebooks/jupyter/data/data-generation/)

### Generate fake images

- [(Computer Vision example](http://www.csun.io/2017/08/31/synthetic-cv-dataset.html), see [code](https://github.com/csun/syntrain)

### Generate data using GAN 

- [Building a simple Generative Adversarial Network (GAN) using TensorFlow](https://blog.paperspace.com/implementing-gans-in-tensorflow/)
- [GENERATIVE ADVERSARIAL NETWORKS (GANS) FOR TEXT USING WORD2VEC: PART 1](https://akshaybudhkar.com/2018/03/26/generative-adversarial-networks-gans-for-text-using-word2vec/)
- [GAN for 2D data generation](https://subscription.packtpub.com/book/big_data_and_business_intelligence/9781788998079/7/ch07lvl1sec46/gan-for-2d-data-generation)
- [Generative Adversarial Networks (GANs) for Discrete Data](http://lantaoyu.com/files/2017-07-26-gan-for-discrete-data.pdf)
- [Boundary-seeking GANs: A new method for adversarial generation of discrete data](https://www.microsoft.com/en-us/research/blog/boundary-seeking-gans-new-method-adversarial-generation-discrete-data/)
- [Introductory guide to Generative Adversarial Networks (GANs) and their promise!](https://www.analyticsvidhya.com/blog/2017/06/introductory-generative-adversarial-networks-gans/)
- [Private Synthetic Data Generation via GANs (Supporting PDF)](https://d253pvgap36xx8.cloudfront.net/formsbuilder/files/d1990068969211e8a29a0242ac110002/main.pdf)
- [GANs (generative adversarial networks) possible for text as well?](https://datascience.stackexchange.com/questions/24878/gans-generative-adversarial-networks-possible-for-text-as-well)

### Generating Music

- [Generating music in the raw audio domain](https://www.youtube.com/watch?v=y8mOZSJA7Bc) by [Sander Dieleman](http://benanne.github.io/about/)

### Sampling

- [Random Number Generation and Sampling Methods](https://www.codeproject.com/Articles/1190459/Random-Number-Generation-and-Sampling-Methods)
- [Resampling Methods: Bootstrap vs jackknife](https://www.linkedin.com/posts/data-science-central_resampling-methods-bootstrap-vs-jackknife-activity-6610622844785221632-bSXb)
- [Oversampling/Undersampling in Logistic Regression](https://www.linkedin.com/posts/vincentg_oversamplingundersampling-in-logistic-regression-activity-6664247426364252162-Md0U)

## Data Augmentation

- [Data Augmentation for End-to-End Speech Translation](https://www.linkedin.com/posts/towards-data-science_data-augmentation-for-end-to-end-speech-translation-activity-6657598863148482560-yDjz)
- Also see Augmentation libraries under [Library, Framework, Models, Tools, Services](../natural-language-processing/library-framework-models-tools-services.md)

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../CONTRIBUTING.md) guidelines, also have a read about our [licensing](../LICENSE.md) policy.

---

Back to [Data page](./README.md#data) <br/>
Back to [main page (table of contents)](../README.md)
