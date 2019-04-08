# Data

Page dedicated to data exploratory analysis, preparation, cleaning, pre-processing / wrangling, generation, feature engineering and other related topics

---

## Data Exploratory Analysis

- [The Ultimate Python Seaborn Tutorial: Gotta Catch ‘Em All](https://elitedatascience.com/python-seaborn-tutorial)
- [Exploratory Analysis](https://elitedatascience.com/exploratory-analysis)
- [Understand Your Machine Learning Data With Descriptive Statistics in Python](https://machinelearningmastery.com/understand-machine-learning-data-descriptive-statistics-python/)
- [Visualize Machine Learning Data in Python With Pandas](https://machinelearningmastery.com/visualize-machine-learning-data-python-pandas/)
- [8 Tactics to Combat Imbalanced Classes in Your Machine Learning Dataset](https://machinelearningmastery.com/tactics-to-combat-imbalanced-classes-in-your-machine-learning-dataset/)
- [Exploring and Transforming H2O DataFrame in R and Python](https://dzone.com/articles/exploring-amp-transforming-h2o-data-frame-in-r-and)
- [ML with H2O by Sudalai Rajkumar](https://www.slideshare.net/0xdata/machine-learning-with-h2o-114163519) (slide 20 onwards)
- [How to Use Statistics to Identify Outliers in Data](https://machinelearningmastery.com/how-to-use-statistics-to-identify-outliers-in-data/)
- [Fundamentals of Data Visualization](https://serialmentor.com/dataviz/)
- [Helpful Python Code Snippets for Data Exploration in Pandas](https://medium.com/@msalmon00/helpful-python-code-snippets-for-data-exploration-in-pandas-b7c5aed5ecb9)

## Data preparation

### Data cleaning

- [Data cleaning](https://elitedatascience.com/data-cleaning)
- [Spend Less Time Cleaning Data with Machine Learning](https://www.dataversity.net/spend-less-time-cleaning-data-with-machine-learning/#)
- [Helpful Python Code Snippets for Data Exploration in Pandas](https://medium.com/@msalmon00/helpful-python-code-snippets-for-data-exploration-in-pandas-b7c5aed5ecb9) - lots of python snippets to select / clean / prepare
- [Working with missing data](https://pandas.pydata.org/pandas-docs/stable/user_guide/missing_data.html)
- [Journal of Statistical Software - TidyData](https://www.jstatsoft.org/article/view/v059i10/)

### Data preprocessing / Data Wrangling

- [Data Preprocessing vs. Data Wrangling in Machine Learning Projects](https://www.infoq.com/articles/ml-data-processing)
- [Improve Model Accuracy with Data Pre-Processing](https://machinelearningmastery.com/improve-model-accuracy-with-data-pre-processing/)

#### Misc

- See discussion on [how data cleaning/preprocessing](https://www.meetup.com/Kaggle-Days-Meetup-London/events/258570474/comments/500079284/?read=1&_xtd=gatlbWFpbF9jbGlja9oAJDczM2Q5MDExLWYyZTctNDliNy1hZTgzLTk5NjFlMGViOGQ4Mw&itemTypeToken=COMMENT) went wrong resulting in poorly performing model

## Data Generation

### Generate numeric data fitting a model/distribution (to fit linear model / ring / etc)

- [Synthetic data generation — a must-have skill for new data scientists](https://towardsdatascience.com/synthetic-data-generation-a-must-have-skill-for-new-data-scientists-915896c0c1ae)
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

### Generate data from existing

- [SMOTE with Imbalance Data](https://www.kaggle.com/qianchao/smote-with-imbalance-data)
- [imbalanced-learn library](https://imbalanced-learn.readthedocs.io/en/stable/introduction.html)
- [SO discussion on using Python libraries](https://stackoverflow.com/questions/51322554/smote-with-missing-values)
- [Simple example of how stock prices can be generated](https://stackoverflow.com/questions/8597731/are-there-known-techniques-to-generate-realistic-looking-fake-stock-data)

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

## Feature engineering  / selection
- [Basic Feature Engineering With Time Series Data in Python](http://machinelearningmastery.com/basic-feature-engineering-time-series-data-python/)
- [Zillow Prize - EDA, Data Cleaning & Feature Engineering](https://www.kaggle.com/lauracozma/eda-data-cleaning-feature-engineering)
- [Feature-wise transformations](https://distill.pub/2018/feature-wise-transformations)

## Statistics

- [An Introduction To Statistical Learning with Applications in R](https://github.com/tpn/pdfs/blob/master/An%20Introduction%20To%20Statistical%20Learning%20with%20Applications%20in%20R%20(ISLR%20Sixth%20Printing).pdf)
- Statistical Inferencing
    - [Understanding statistical inference [video]](https://www.youtube.com/watch?v=tFRXsngz4UQ)
    - [Four ideas of Statistical Inference](http://www.bristol.ac.uk/medical-school/media/rms/red/4_ideas_of_statistical_inference.html)
    - [An Introduction to Statistical Learning [book]](http://www-bcf.usc.edu/~gareth/ISL/)
    - [Statistical Inference [course]](https://www.coursera.org/learn/statistical-inference)

## Common mistakes when training models (data related)

- Having a lot more training examples of one type of object than the other types
- Accidentally testing the neural network using images that were in the training set
- Training the neural network on data that is easier to recognize or more consistent than the real-world data it will be used to classify later on

## Cheatsheets

See under [Cheatsheets](../README-details.md#cheatsheets)

## Course / books

- [Data Science Primer](https://elitedatascience.com/primer)
- [27 Amazing Data Science Books Every Data Scientist Should Read](https://www.analyticsvidhya.com/blog/2019/01/27-amazing-data-science-books-every-data-scientist-should-read/)
- [Coursera course: Getting and Cleaning Data](https://www.coursera.org/learn/data-cleaning?recoOrder=20&utm_medium=email&utm_source=recommendations&utm_campaign=u0faoCsqEemEkbug8nMVQQ)
- [Data Science courses on Coursera](https://www.coursera.org/learn/competitive-data-science)
- [Data courses on Udemy](https://www.udemy.com/courses/search/?ref=home&src=ukw&q=data)
- [Data courses on Udacity](https://eu.udacity.com/courses/school-of-data-science)
- [Latest Machine learning, visualization, data mining techniques. Online Masters in Data Analytic from Penn State](https://twitter.com/analyticbridge/status/1102667686302179336)
- [Data Science Handbook](https://github.com/RishiSankineni/Data-Science-Swag/blob/master/The%20Data%20Science%20Handbook.pdf)

## Best practices / rules / an unordered list of high level or low level guidelines
- [12 Best Practices for Modern Data Ingestion](https://go.streamsets.com/dzone-wp-12-best-practices-modern-data-ingestion)
    - [PDF](https://streamsets.com/wp-content/uploads/2018/01/WP-12-best-practices-for-modern-data-ingestion.pdf)
- [A Rubric for ML Production Readiness - by Jiameng Gao from Applied Deep Learning Meetup in Feb 2019](https://docs.google.com/presentation/d/1-4gE9v1X7EP4rsBQlRtGA9IXDnBjlQPAqB3jlDBvUTU/edit#slide=id.p) (Paper: https://ai.google/research/pubs/pub46555)
- [Rules of Machine Learning: Best Practices for ML Engineering](https://developers.google.com/machine-learning/guides/rules-of-ml/)

## Framework(s) / checklist(s)

- [Data Science Primer](https://elitedatascience.com/primer)
- [How to Prepare Data For Machine Learning](https://machinelearningmastery.com/how-to-prepare-data-for-machine-learning/)
- [What is Data Mining and KDD](https://machinelearningmastery.com/what-is-data-mining-and-kdd/)
- [The KDD process for extracting useful knowledge from volumes of data](http://shawndra.pbworks.com/f/The%20KDD%20process%20for%20extracting%20useful%20knowledge%20from%20volumes%20of%20data.pdf)
- [Data Mining: Practical ML Tools and Techniques by Witten, Frank and Mark 3rd edition](https://www.wi.hs-wismar.de/~cleve/vorl/projects/dm/ss13/HierarClustern/Literatur/WittenFrank-DM-3rd.pdf)
- [Foundational Methodology for Data Science - IBM Analytics Whitepaper](https://tdwi.org/~/media/64511A895D86457E964174EDC5C4C7B1.PDF)
- [Coursera Data Science Methodology course](https://www.coursera.org/learn/data-science-methodology?aid=true)
    - From Problem to Approach and From Requirements to Collection
        - Business Understanding
        - Analytic Approach
        - Data Requirements
        - Data Collection
    - From Understanding to Preparation and From Modeling to Evaluation
        - Data Understanding
        - Data Preparation
        - Modeling 
        - Model Evaluation

## Notebooks

- [Python Data Science Handbook on Azure git repo](https://noteboo ks.azure.com/jakevdp/projects/PythonDataScienceHandbook/tree/notebooks)
- [Python for data analysis](https://notebooks.azure.com/wesm/projects/python-for-data-analysis)
- [Python Data Science Handbook](https://jakevdp.github.io/PythonDataScienceHandbook/)
- House prices
    - Old example notebook: [examples/data/notebooks](examples/data/notebooks/)
    - Regression example: https://colab.research.google.com/drive/19uoDyGAxJ0zCwPT6cNb1xkYOfySNZChV
    - Classification example: https://colab.research.google.com/drive/1i-fOhU87wWrzgnTV0o54MQyHmRVJK0qt

## Programs and Tools

See [Programs and Tools](programs-and-tools.md)

## Databases
- [Grakn and Graql](http://grakn.ai/) - not just graphs, or graph database knowledge graphs | [Docs | Quick start](https://dev.grakn.ai/docs/general/quickstart) | [GitHub](https://github.com/graknlabs/grakn)
    + See [example](../examples/data/databases/graph/grakn/README.md) in the `../examples/data/databases/graph/grakn` folder
- [Redis Graph](https://oss.redislabs.com/redisgraph/) | [Blogs](https://blog.grakn.ai/?gi=d6874fc57ebb) | [Videos](https://www.youtube.com/channel/UCtZKw0RFof3x23KqGtW3yDA)
- [Neo4j](https://neo4j.com/)
- [Gun: A realtime, decentralized, offline-first, mutable graph database engine](https://github.com/amark/gun)
- [Cayley: An open-source graph database](https://github.com/cayleygraph/cayley)

#### References

- [How to build a data science project from scratch](https://www.kdnuggets.com/2018/12/build-data-science-project-from-scratch.html)
- [Common mistakes when carrying out machine learning and data science](https://www.kdnuggets.com/2018/12/common-mistakes-data-science.html)
- [A Rubric for ML Production Readiness - Breck et al. 2017 by Jiameng Gao (28 rules to follow, suggested by Google)](https://docs.google.com/presentation/d/1-4gE9v1X7EP4rsBQlRtGA9IXDnBjlQPAqB3jlDBvUTU/edit#slide=id.p) | [Original Paper by Google](https://ai.google/research/pubs/pub46555)

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../CONTRIBUTING.md) guidelines, also have a read about our [licensing](../LICENSE.md) policy.

---

Back to [main page (table of contents)](../README.md)