# Data preparation, cleaning, validation, model creation, training resources

## Data Exploratory Analysis

- https://elitedatascience.com/python-seaborn-tutorial
- https://elitedatascience.com/exploratory-analysis
- https://machinelearningmastery.com/understand-machine-learning-data-descriptive-statistics-python/
- https://machinelearningmastery.com/visualize-machine-learning-data-python-pandas/
- https://machinelearningmastery.com/tactics-to-combat-imbalanced-classes-in-your-machine-learning-dataset/
- https://dzone.com/articles/exploring-amp-transforming-h2o-data-frame-in-r-and
- https://www.slideshare.net/0xdata/machine-learning-with-h2o-114163519 (slide 20 onwards)
- https://machinelearningmastery.com/how-to-use-statistics-to-identify-outliers-in-data/  
- https://serialmentor.com/dataviz/
- https://medium.com/@msalmon00/helpful-python-code-snippets-for-data-exploration-in-pandas-b7c5aed5ecb9 

## Data preparation

### Data cleaning

- https://elitedatascience.com/data-cleaning
- https://www.dataversity.net/spend-less-time-cleaning-data-with-machine-learning/# - give tips on which tools to use
- https://medium.com/@msalmon00/helpful-python-code-snippets-for-data-exploration-in-pandas-b7c5aed5ecb9 lots of python snippets to select / clean / prepare
- https://pandas.pydata.org/pandas-docs/stable/user_guide/missing_data.html

### Data preprocessing / Data Wrangling

- https://www.infoq.com/articles/ml-data-processing
- https://machinelearningmastery.com/improve-model-accuracy-with-data-pre-processing/

### Misc

- See discussion on [how data cleaning/preprocessing](https://www.meetup.com/Kaggle-Days-Meetup-London/events/258570474/comments/500079284/?read=1&_xtd=gatlbWFpbF9jbGlja9oAJDczM2Q5MDExLWYyZTctNDliNy1hZTgzLTk5NjFlMGViOGQ4Mw&itemTypeToken=COMMENT) went wrong resulting in poorly performing model

## Data Generation

### Generate numeric data fitting a model/distribution (to fit linear model / ring / etc)

- https://towardsdatascience.com/synthetic-data-generation-a-must-have-skill-for-new-data-scientists-915896c0c1ae
- https://machinelearningmastery.com/generate-test-datasets-python-scikit-learn/
    - Python packages
        - https://scikit-learn.org/stable/modules/classes.html#module-sklearn.datasets
        - https://stackoverflow.com/questions/47542752/python-generate-random-time-series-data-with-trends-e-g-cyclical-exponential (Python libraries)
    - R packages
        - https://www.reddit.com/r/statistics/comments/4trcp4/data_generation_programs/ (Refers to a distribution package in R)
        - https://www.r-bloggers.com/generating-synthetic-data-sets-with-synthpop-in-r/ (Example of sythpop, an R package that generates data)
        - https://stackoverflow.com/questions/11820532/generating-synthetic-data-for-unsupervised-learning (Another example of how it can be done in R, using existing package(s))
        - https://stackoverflow.com/questions/49702979/generate-data-by-using-existing-dataset-as-the-base-dataset (Another set of R examples)
        - https://stackoverflow.com/questions/8972244/artificial-dataset-generator-for-classification-data (very good examples of how R’s packages can be used to generate datasets time series, adjusting correlations and visualise them)
        - https://stackoverflow.com/questions/34023177/how-to-create-a-synthetic-dataset (Examples of how Scikit and R’s packages can be used to generate synthetic data)

### Generate random data matching a rule or type (people’s names / phone numbers / etc, financial data, etc)

- https://pydbgen.readthedocs.io/en/latest/#
- https://github.com/TU-Berlin-DIMA/myriad-toolkit (Paper: http://vldb.org/pvldb/vol5/p1890_alexanderalexandrov_vldb2012.pdf) - focuses on how to generate massive amounts of data following a database schema (create data for your relational db with users, orders, etc)
- https://www.researchgate.net/publication/3420044_Generating_Synthetic_Data_to_Match_Data_Mining_Patterns

### Generate data from existing

- https://www.kaggle.com/qianchao/smote-with-imbalance-data
- https://imbalanced-learn.readthedocs.io/en/stable/introduction.html
- https://stackoverflow.com/questions/51322554/smote-with-missing-values (Python libraries)
- https://stackoverflow.com/questions/8597731/are-there-known-techniques-to-generate-realistic-looking-fake-stock-data (Simple example of how stock prices can be generated)

### Generate fake images

- http://www.csun.io/2017/08/31/synthetic-cv-dataset.html (Computer Vision example may or may not help, see code https://github.com/csun/syntrain)

### Generate data using GAN: 

- https://blog.paperspace.com/implementing-gans-in-tensorflow/
- https://akshaybudhkar.com/2018/03/26/generative-adversarial-networks-gans-for-text-using-word2vec/
- https://subscription.packtpub.com/book/big_data_and_business_intelligence/9781788998079/7/ch07lvl1sec46/gan-for-2d-data-generation
- http://lantaoyu.com/files/2017-07-26-gan-for-discrete-data.pdf
- https://www.microsoft.com/en-us/research/blog/boundary-seeking-gans-new-method-adversarial-generation-discrete-data/
- https://www.analyticsvidhya.com/blog/2017/06/introductory-generative-adversarial-networks-gans/
- https://d253pvgap36xx8.cloudfront.net/formsbuilder/files/d1990068969211e8a29a0242ac110002/main.pdf
- https://datascience.stackexchange.com/questions/24878/gans-generative-adversarial-networks-possible-for-text-as-well

## Feature engineering  / selection
- https://machinelearningmastery.com/start-here/
- http://machinelearningmastery.com/basic-feature-engineering-time-series-data-python/
- https://www.kaggle.com/lauracozma/eda-data-cleaning-feature-engineering
- https://distill.pub/2018/feature-wise-transformations

## Common mistakes when training models (data related):
- Having a lot more training examples of one type of object than the other types
- Accidentally testing the neural network using images that were in the training set
- Training the neural network on data that is easier to recognize or more consistent than the real-world data it will be used to classify later on

## Course / books

- https://elitedatascience.com/primer
- https://www.analyticsvidhya.com/blog/2019/01/27-amazing-data-science-books-every-data-scientist-should-read/
- https://www.coursera.org/learn/data-cleaning?recoOrder=20&utm_medium=email&utm_source=recommendations&utm_campaign=u0faoCsqEemEkbug8nMVQQ
- https://www.udemy.com/courses/search/?ref=home&src=ukw&q=data
- https://eu.udacity.com/courses/school-of-data-science
- https://twitter.com/analyticbridge/status/1102667686302179336
- https://www.coursera.org/learn/competitive-data-science

## Notebooks

- https://notebooks.azure.com/jakevdp/projects/PythonDataScienceHandbook/tree/notebooks
- A example notebook: [examples/data/notebooks](examples/data/notebooks/)
- https://notebooks.azure.com/wesm/projects/python-for-data-analysis
- Regression example: https://colab.research.google.com/drive/19uoDyGAxJ0zCwPT6cNb1xkYOfySNZChV
- Classification example: https://colab.research.google.com/drive/1i-fOhU87wWrzgnTV0o54MQyHmRVJK0qt
- https://jakevdp.github.io/PythonDataScienceHandbook/

## Programs and Tools

### H2O Driverless AI

See [About H2O Driverless AI](about-H2O-Driverless-AI.md)

### Microstrategy

See [About Microstrategy](about-Microstrategy.md)

### Tableau Prep

See [Tableau Prep](about-Tableau-Prep.md)

### Dataiku

See [About Dataiku](about-Dataiku.md)

### Pipeline.ai

See [About Pipeline.ai](about-Pipeline.ai.md)

### Weights & Biases

See [About Weights & Biases](about-Weights-and-Biases.md)

### ModeAnalytics

See [About ModeAnalytics](about-ModeAnalytics.md)

### fast.ai

See [About fast.ai](about-fast.ai.md)

### Google Data Studio

See [About Google Data Studio](about-Google-Data-Studio.md)

### Redis modules
- [neural-redis](https://github.com/antirez) - Online trainable neural networks as Redis data types
- [RedisML](https://github.com/RedisLabs) -  Machine Learning Model Server, also see [shaynativ](https://github.com/shaynativ)
- [RedisTimeSeries](https://github.com/danni-m) - Time-series data structure for redis
- [RedisAI](https://github.com/lantiga) - A Redis module for serving tensors and executing deep learning graphs
- [(many other related modules)](https://redis.io/modules)

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
- [Synthetic data generation — a must-have skill for new data scientists](https://towardsdatascience.com/synthetic-data-generation-a-must-have-skill-for-new-data-scientists-915896c0c1ae)
- [A Rubric for ML Production Readiness - Breck et al. 2017 by Jiameng Gao (28 rules to follow, suggested by Google)](https://docs.google.com/presentation/d/1-4gE9v1X7EP4rsBQlRtGA9IXDnBjlQPAqB3jlDBvUTU/edit#slide=id.p) | [Original Paper by Google](https://ai.google/research/pubs/pub46555)

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](CONTRIBUTING.md) guidelines, also have a read about our [licensing](LICENSE.md) policy.

---

Back to [main page (table of contents)](../README.md)