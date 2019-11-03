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
- [Feature Selection](./README.md#feature-selection)
- [Feature Engineering](./README.md#feature-engineering)
- [Post model-creation analysis, ML interpretation/explainability](./README.md#post-model-creation-analysis-ml-interpretationexplainability)
- [Statistics](./README.md#statistics)
- [Visualisation](./README.md#visualisation)
- [Common mistakes when training models (data related)](./README.md#common-mistakes-when-training-models-data-related)
- [Presentations](./README.md#presentations)
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

See [Datasets](./datasets.md)

## Data Exploratory Analysis

See [Data Exploratory Analysis](./data-exploratory-analysis.md)

## Data preparation

See [Data preparation](./data-preparation.md)

## Data Generation

See [Data Generation](./data-generation.md#data-generation)

## Feature Selection

See [Feature Selection](./feature-selection.md)

## Feature engineering

See [Feature engineering](./feature-engineering.md)

## Post model-creation analysis, ML interpretation/explainability

See [Post model-creation analysis, ML interpretation/explainability](./model-analysis-interpretation-explainability.md)

## Statistics

See [Statistics.md](statistics.md#statistics)

## Visualisation

See [Visualisation](../README-details.md#visualisation-1)

## Common mistakes when training models (data related)

- Having a lot more training examples of one type of object than the other types
- Accidentally testing the neural network using images that were in the training set
- Training the neural network on data that is easier to recognize or more consistent than the real-world data it will be used to classify later on

## Presentations

- [A Rubric for ML Production Readiness - by Jiameng Gao from Applied Deep Learning Meetup in Feb 2019](https://docs.google.com/presentation/d/1-4gE9v1X7EP4rsBQlRtGA9IXDnBjlQPAqB3jlDBvUTU/edit#slide=id.p) (Paper: https://ai.google/research/pubs/pub46555)
- [Introduction to Data Analysis and Cleaning presentation](../presentations/data/01-mam-ml-study-group-meetup/Introduction_to_Data_Analysis_and_Cleaning.pdf) by [Mark Bell](http://www.nationalarchives.gov.uk/about/our-research-and-academic-collaboration/our-research-and-people/staff-profiles/mark-bell/)
- [Do we know our data, as good as we know our tools](../presentations/data/02-devoxx-uk-2019/README.md) by [Jeremie Charlet](http://twitter.com/jeremiecharlet) and [Mani Sarkar](http://github.com/neomatrix369)

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
- [Coursera Course: Probability and distribution](
https://media.licdn.com/dms/document/C511FAQGFKgIKuW_EEA/feedshare-document-pdf-analyzed/0?e=1571785200&v=beta&t=XyEEqUgi3y4L1hiZ7CxlxbAXyZmM_zcCCdn-Lr04ns8)

## Best practices / rules / an unordered list of high level or low level guidelines

- [12 Best Practices for Modern Data Ingestion](https://go.streamsets.com/dzone-wp-12-best-practices-modern-data-ingestion)
    - [PDF](https://streamsets.com/wp-content/uploads/2018/01/WP-12-best-practices-for-modern-data-ingestion.pdf)
- [A Rubric for ML Production Readiness - by Jiameng Gao from Applied Deep Learning Meetup in Feb 2019](https://docs.google.com/presentation/d/1-4gE9v1X7EP4rsBQlRtGA9IXDnBjlQPAqB3jlDBvUTU/edit#slide=id.p) (Paper: https://ai.google/research/pubs/pub46555)
- [Rules of Machine Learning: Best Practices for ML Engineering](https://developers.google.com/machine-learning/guides/rules-of-ml/)

## Framework(s) / checklist(s)

See [Framework(s) / checklist(s)](./frameworks-checklists.md)

## Notebooks

See [Notebooks](./notebooks.md)

## Programs and Tools

See [Programs and Tools](programs-and-tools.md#programs-and-tools)

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