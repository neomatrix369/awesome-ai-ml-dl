# Data

Page dedicated to data exploratory analysis, preparation, cleaning, pre-processing / wrangling, generation, feature engineering and other related topics

The question to ask ourselves: _Do we know our data...?_

---

### Table of contents

- [Ethics / altruistic motives](./README.md#ethics--altruistic-motives)
- [Datasets and sources of raw data](./README.md#datasets-and-sources-of-raw-data)
- [Data Exploratory Analysis](./README.md#data-exploratory-analysis)
- [Data preparation](./README.md#data-preparation)
    + [Data Cleaning](./README.md#data-cleaning)
    + [Data preprocessing / Data Wrangling](./README.md#data-preprocessing--data-wrangling)
- [Data Generation](./README.md#data-generation)
- [Feature Engineering](./README.md#feature-engineering)
- [Statistics](./README.md#statistics)
- [Visualisation](./README.md#visualisation)
- [Common mistakes when training models (data related)](./README.md#common-mistakes-when-training-models-data-related)
- [Cheatsheets](./README.md#cheatsheets)
- [Course / books](./README.md#course--books)
- [Best practices / rules / an unordered list of high level or low level guidelines](./README.md#best-practices--rules--an-unordered-list-of-high-level-or-low-level-guidelines)
- [Framework(s) / checklist(s)](./README.md#frameworks--checklists)
- [Notebooks](./README.md#notebooks)
- [Programs and Tools](./README.md#programs-and-tools)
- [Databases](./README.md#databases)
- [References](./README.md#eferences)
- [Credits](./README.md#credits)
- [Contributing](./README.md#contributing)

---

## Ethics / altruistic motives

See [Ethics / altruistic motives](../README-details.md#ethics--altruistic-motives)

## Datasets and sources of raw data

### Raw / unclean datasets

- [Boston Housing Dataset (archive contains unclean dataset)](https://github.com/neomatrix369/awesome-ai-ml-dl/releases/tag/v0.1) | [Download](https://github.com/neomatrix369/awesome-ai-ml-dl/releases/download/v0.1/boston_housing_dataset.zip)
- [Datasets for Data cleaning practise](https://makingnoiseandhearingthings.com/2018/04/19/datasets-for-data-cleaning-practice/)
- [Cleaning up and combining data, a dataset for practice](https://www.r-bloggers.com/cleaning-up-and-combining-data-a-dataset-for-practice/)
- [Datasets from various themes and domains: retail, government. Datasets with a good mix of incorrect, wrongly-input, missing data](https://www.ud-intl.com/dataset)
- [(Specific) Web Traffic Time Series Forecasting](https://www.kaggle.com/c/web-traffic-time-series-forecasting)
- [Quora: What are some dirty/untidy datasets to clean for data analysis? I have just finished datacamp's course on cleaning data using R. I want to practice](https://www.quora.com/What-are-some-dirty-untidy-datasets-to-clean-for-data-analysis-I-have-just-finished-datacamps-course-on-cleaning-data-using-R-I-want-to-practice)

### Clean / ready-to-use datasets

- [Boston Housing Dataset (archive contains clean dataset)](https://github.com/neomatrix369/awesome-ai-ml-dl/releases/tag/v0.1) | [Download](https://github.com/neomatrix369/awesome-ai-ml-dl/releases/download/v0.1/boston_housing_dataset.zip)
- [Google Dataset Search](https://toolbox.google.com/datasetsearch)
- [Kaggle Datasets](https://www.kaggle.com/datasets) | Blogs: [1](https://towardsdatascience.com/interesting-datasets-on-kaggle-com-3a4a250b0b85) [2](http://blog.kaggle.com/2016/01/19/introducing-kaggle-datasets/) [3](https://medium.com/@benhamner/introducing-kaggle-datasets-a935f9f76f5) [4](https://stackoverflow.com/questions/52681196/kaggle-datasets-into-jupyter-notebook)
- [Carnegie Mellon University Datasets](http://lib.stat.cmu.edu/datasets/)
- [GeoPlatform Data.gov Search ](https://data.geoplatform.gov/)
- [Data.gov - Data Catalog](https://catalog.data.gov/dataset)
- [TidyTuesday projects on GitHub](https://github.com/rfordatascience/tidytuesday)
- [Enron Email Digest Dataset](https://www.cs.cmu.edu/~enron/)
- [Mathematics Datasets](https://github.com/deepmind/mathematics_dataset)
- [Data.world datasets](https://data.world)
- [Microsoft Research Open Data](https://msropendata.com/)
- [Free Datasets recommended by r-directory](https://r-dir.com/reference/datasets.html)
- [UC Irvine Machine Learning Repository](https://archive.ics.uci.edu/ml/index.php)

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
- [5 Steps to correctly prepare your data for your machine learning model](https://towardsdatascience.com/5-steps-to-correctly-prep-your-data-for-your-machine-learning-model-c06c24762b73?gi=6b4a6895ab1)
- [Introduction to Data Analysis and Cleaning presentation](../presentations/data/Introduction_to_Data_Analysis_and_Cleaning.pdf) by [Mark Bell](http://www.nationalarchives.gov.uk/about/our-research-and-academic-collaboration/our-research-and-people/staff-profiles/mark-bell/)

## Data preparation

### Data cleaning

- [Data cleaning](https://elitedatascience.com/data-cleaning)
- [Spend Less Time Cleaning Data with Machine Learning](https://www.dataversity.net/spend-less-time-cleaning-data-with-machine-learning/#)
- [Helpful Python Code Snippets for Data Exploration in Pandas](https://medium.com/@msalmon00/helpful-python-code-snippets-for-data-exploration-in-pandas-b7c5aed5ecb9) - lots of python snippets to select / clean / prepare
- [Working with missing data](https://pandas.pydata.org/pandas-docs/stable/user_guide/missing_data.html)
- [Journal of Statistical Software - TidyData](https://www.jstatsoft.org/article/view/v059i10/)
- [5 Steps to correctly prepare your data for your machine learning model](https://towardsdatascience.com/5-steps-to-correctly-prep-your-data-for-your-machine-learning-model-c06c24762b73?gi=6b4a6895ab1)
- [Introduction to Data Analysis and Cleaning presentation](../presentations/data/Introduction_to_Data_Analysis_and_Cleaning.pdf) by [Mark Bell](http://www.nationalarchives.gov.uk/about/our-research-and-academic-collaboration/our-research-and-people/staff-profiles/mark-bell/)

### Data preprocessing / Data Wrangling

- [Data Preprocessing vs. Data Wrangling in Machine Learning Projects](https://www.infoq.com/articles/ml-data-processing)
- [Improve Model Accuracy with Data Pre-Processing](https://machinelearningmastery.com/improve-model-accuracy-with-data-pre-processing/)
- [5 Steps to correctly prepare your data for your machine learning model](https://towardsdatascience.com/5-steps-to-correctly-prep-your-data-for-your-machine-learning-model-c06c24762b73?gi=6b4a6895ab1)
- [Introduction to Data Analysis and Cleaning presentation](../presentations/data/Introduction_to_Data_Analysis_and_Cleaning.pdf) by [Mark Bell](http://www.nationalarchives.gov.uk/about/our-research-and-academic-collaboration/our-research-and-people/staff-profiles/mark-bell/)

#### Misc

- See discussion on [how data cleaning/preprocessing](https://www.meetup.com/Kaggle-Days-Meetup-London/events/258570474/comments/500079284/?read=1&_xtd=gatlbWFpbF9jbGlja9oAJDczM2Q5MDExLWYyZTctNDliNy1hZTgzLTk5NjFlMGViOGQ4Mw&itemTypeToken=COMMENT) went wrong resulting in poorly performing model
- [Learning with Limited Labeled Data with Shioulin Sam](https://twimlai.com/twiml-talk-255-learning-with-limited-labeled-data-with-shioulin-sam/)

## Data Generation

See [Data Generation](./data-generation.md)

## Feature engineering

- [Basic Feature Engineering With Time Series Data in Python](http://machinelearningmastery.com/basic-feature-engineering-time-series-data-python/)
- [Zillow Prize - EDA, Data Cleaning & Feature Engineering](https://www.kaggle.com/lauracozma/eda-data-cleaning-feature-engineering)
- [Feature-wise transformations](https://distill.pub/2018/feature-wise-transformations)
- [tsfresh](https://tsfresh.readthedocs.io/en/latest/text/introduction.html) - tsfresh is used to to extract characteristics from time series
- [featuretools](https://github.com/featuretools/featuretools/) - an open source python framework for automated feature engineering
- [5 Steps to correctly prepare your data for your machine learning model](https://towardsdatascience.com/5-steps-to-correctly-prep-your-data-for-your-machine-learning-model-c06c24762b73?gi=6b4a6895ab1)
- [scikit learn's SelectKBest](https://scikit-learn.org/stable/modules/generated/sklearn.feature_selection.SelectKBest.html)
- [Feature selection with mutual information](http://www.simafore.com/blog/bid/105347/Feature-selection-with-mutual-information-Part-2-PCA-disadvantages)
- [mlbox's Feature selection](https://mlbox.readthedocs.io/en/latest/features.html)
- Chi2 test: Feature selection: [Quora](https://www.quora.com/How-is-chi-test-used-for-feature-selection-in-machine-learning) | [NLP Stanford Group](https://nlp.stanford.edu/IR-book/html/htmledition/feature-selectionchi2-feature-selection-1.html) | [Learn for Master](http://www.learn4master.com/machine-learning/chi-square-test-for-feature-selection)
- Forward Feature selection: [Blog on Towards DS](https://towardsdatascience.com/feature-importance-and-forward-feature-selection-752638849962) | [Scikit learn](https://mikulskibartosz.name/forward-feature-selection-in-scikit-learn-f6476e474ddd)
- [What is dimensionality reduction? What is the difference between feature selection and extraction?](https://datascience.stackexchange.com/questions/130/what-is-dimensionality-reduction-what-is-the-difference-between-feature-selecti)
- [Feature engineering and Dimensionality reduction](https://towardsdatascience.com/dimensionality-reduction-for-machine-learning-80a46c2ebb7e)
- [Seven Techniques for Data Dimensionality Reduction](https://www.kdnuggets.com/2015/05/7-methods-data-dimensionality-reduction.html)

## Statistics

- [An Introduction To Statistical Learning with Applications in R](https://github.com/tpn/pdfs/blob/master/An%20Introduction%20To%20Statistical%20Learning%20with%20Applications%20in%20R%20(ISLR%20Sixth%20Printing).pdf)
- Statistical Inferencing
    - [Understanding statistical inference [video]](https://www.youtube.com/watch?v=tFRXsngz4UQ)
    - [Four ideas of Statistical Inference](http://www.bristol.ac.uk/medical-school/media/rms/red/4_ideas_of_statistical_inference.html)
    - [An Introduction to Statistical Learning [book]](http://www-bcf.usc.edu/~gareth/ISL/)
    - [Statistical Inference [course]](https://www.coursera.org/learn/statistical-inference)
- [Understand Your Machine Learning Data With Descriptive Statistics in Python](https://machinelearningmastery.com/understand-machine-learning-data-descriptive-statistics-python/)
- [How to Use Statistics to Identify Outliers in Data](https://machinelearningmastery.com/how-to-use-statistics-to-identify-outliers-in-data/)
- [Applying Physics functions](Trackener-physics-functions-usage-example.pptx)
- [Chapter 2 of Introduction to Statistical Learning](http://www-bcf.usc.edu/~gareth/ISL/)
- [Naked statistics](http://www.nakedstatistics.com/) | [Book on Amazon](https://www.amazon.com/Naked-Statistics-Stripping-Dread-Data/dp/1480590185) [Naked statistics flash cards](https://quizlet.com/90835490/naked-statistics-flash-cards/) | [Summary by Daniel Miessler](https://danielmiessler.com/projects/reading/summary-naked-statistics/)
- [Cartoon Guide to Statistics (Cartoon Guide Series)](https://www.amazon.co.uk/Cartoon-Guide-Statistics/dp/0062731025/ref=sr_1_1?hvadid=80814136501810&hvbmt=bb&hvdev=c&hvqmt=b&keywords=cartoon+guide+statistics&qid=1556047351&s=gateway&sr=8-1)
- [Journal of Statistical Software - TidyData](https://www.jstatsoft.org/article/view/v059i10/)
- Statistics courses at [Coursera](https://www.coursera.org/courses?query=statistics&) | [Udemy](https://www.udemy.com/courses/search/?src=ukw&q=statistics) | [Udacity](https://eu.udacity.com/courses/all) - search for `Statistics` | Harvard University: [Statistics 110](https://www.youtube.com/watch?v=KbB0FjPg0mw&list=PL2SOU6wwxB0uwwH80KTQ6ht66KWxbzTIo) | [more videos on their YouTube channel](https://www.youtube.com/user/Harvard/search?query=statistics) | [Stanford University](https://online.stanford.edu/courses?keywords=statistics)
- For more, see [Mathematics, Statistics, Probability & Probabilistic programming](../README-details.md#mathematics-statistics-probability--probabilistic-programming)

## Visualisation

See [Visualisation](../README-details.md#visualisation-1)

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

- [Python Data Science Handbook on Azure git repo](https://notebooks.azure.com/jakevdp/projects/PythonDataScienceHandbook/tree/notebooks)
- [Python for Data Analysis on Azure git repo](https://notebooks.azure.com/wesm/projects/python-for-data-analysis)
- [Python Data Science Handbook](https://jakevdp.github.io/PythonDataScienceHandbook/)
- House prices
    - [ML End-to-End Tutorial + Pandas notebook](../examples/data/notebooks/DSfIOT_Machine_Learning_End_to_End_Tutorial.ipynb)
    - [Regression example notebook](https://colab.research.google.com/drive/19uoDyGAxJ0zCwPT6cNb1xkYOfySNZChV)
    - [Classification example notebook](https://colab.research.google.com/drive/1i-fOhU87wWrzgnTV0o54MQyHmRVJK0qt)
    - Some explanations of the above Regression & Classification examples: [as a Notebook](https://drive.google.com/file/d/1vR9fOsWkCx0PuiCH0Eiz5FG1AAHuBHa8/view) | [as a PDF file](https://drive.google.com/file/d/1U3GkVgloBd5-w4qSj0KcyhtalhDF7pgC/view)
- [Data science Python notebooks: Deep learning (TensorFlow, Theano, Caffe, Keras), scikit-learn, Kaggle, big data (Spark, Hadoop MapReduce, HDFS), matplotlib, pandas, NumPy, SciPy, Python essentials, AWS, and various command line tools](https://github.com/donnemartin/data-science-ipython-notebooks)
- [Synthetic features and outliers notebook](https://colab.research.google.com/notebooks/mlcc/synthetic_features_and_outliers.ipynb?utm_source=mlcc&utm_campaign=colab-external&utm_medium=referral&utm_content=syntheticfeatures-colab&hl=en#scrollTo=jnKgkN5fHbGy)
- Do we know our data...
  - [Exploratory Data Analysis](../notebooks/jupyter/data/01_Exploratory_Data_Analysis_(Do_we_know_our_data).ipynb)
  - [Data Preparation](../notebooks/jupyter/data/02_Data_Preparation_(Do_we_know_our_data).ipynb)
  - [Feature Engineering](../notebooks/jupyter/data/03_Feature_Engineering_(Do_we_know_our_data).ipynb) 

## Programs and Tools

See [Programs and Tools](programs-and-tools.md)

## Databases
- [Grakn and Graql](http://grakn.ai/) - not just graphs, or graph database knowledge graphs | [Docs | Quick start](https://dev.grakn.ai/docs/general/quickstart) | [GitHub](https://github.com/graknlabs/grakn)
    + See [example](../examples/data/databases/graph/grakn/README.md) in the `../examples/data/databases/graph/grakn` folder
- [Redis Graph](https://oss.redislabs.com/redisgraph/) | [Blogs](https://blog.grakn.ai/?gi=d6874fc57ebb) | [Videos](https://www.youtube.com/channel/UCtZKw0RFof3x23KqGtW3yDA) | [Skillsmatter: how redis enterprise made redis highly available, scalable, durable and cloudnative](https://skillsmatter.com/skillscasts/11886-how-redis-enterprise-made-redis-highly-available-scalable-durable-and-cloudnative)
- [Neo4j](https://neo4j.com/)
- [Gun: A realtime, decentralized, offline-first, mutable graph database engine](https://github.com/amark/gun)
- [Cayley: An open-source graph database](https://github.com/cayleygraph/cayley)

### Time-series databases
- [Time-scale](https://www.timescale.com/)
- [kdb+](https://en.wikipedia.org/wiki/Kdb%2B) - is a column-based relational time series database (TSDB) with in-memory (IMDB) abilities, developed and marketed by [Kx Systems](https://kx.com/)

## References

- [How to build a data science project from scratch](https://www.kdnuggets.com/2018/12/build-data-science-project-from-scratch.html)
- [Common mistakes when carrying out machine learning and data science](https://www.kdnuggets.com/2018/12/common-mistakes-data-science.html)
- [A Rubric for ML Production Readiness - Breck et al. 2017 by Jiameng Gao (28 rules to follow, suggested by Google)](https://docs.google.com/presentation/d/1-4gE9v1X7EP4rsBQlRtGA9IXDnBjlQPAqB3jlDBvUTU/edit#slide=id.p) | [Original Paper by Google](https://ai.google/research/pubs/pub46555)
- [Understanding Data Science Problems - template of questions to ask](http://url4149.bitgrit.net/wf/click?upn=qJT0wq97YSVxi6S9Gi10QGqeT3JSC6xJnYDSgYEwjzRMycP3yLSx2r-2BNxQzJHe9QPJFpU2-2FggIOmAMx4-2FXJyS5Ct5nq0JGa-2BaeTR278cf4Y016UI8tNe1mgRL66MJsyWyvn6y4MQGXNy5SqWqhbPcw-3D-3D_sX8FRvZaj8ntSB52F-2FOI3mORNoWV2VSsIMLOasSO2VX6r5g4xczJm1Y1-2FwGOMI-2BlSq1KNsGohBLZURHm6k60Tf2HtckfAZ6grcZUQF65S5oJU988M9Tw34CKxkXDto40DimsP-2FidGRva8-2F1aqLSRqIqousS4hXEet-2FT5ghzTXSqhZy5rNdfAdgpvrkvvm-2BZIs0VBaYDiakrHtCwc5eIKRA-3D-3D)
- [eBook: How to Succeed in Data Science](https://docs.google.com/document/d/1fvxDOdCjPx0wS4aqSOME3NyATJGN7sASLeEyygIvcJA/edit#)

## Credits

Big thanks to [Jeremie Charlet](https://github.com/jcharlet) for his contributions to many of the resources on this page. Not forgetting the others who have also helped support in the building of the above resources.

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../CONTRIBUTING.md) guidelines, also have a read about our [licensing](../LICENSE.md) policy.

---

Back to [main page (table of contents)](../README.md)