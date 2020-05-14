# Data

Page dedicated to data exploratory analysis, preparation, cleaning, pre-processing / wrangling, generation, feature engineering and other related topics

The question to ask ourselves: _Do we know our data...?_

---

- [Ethics / altruistic motives](./README.md#ethics--altruistic-motives)
- [Data Science](./README.md#data-science)
- [Datasets and sources of raw data](./README.md#datasets-and-sources-of-raw-data)
- [Data Collection](./README.md#data-collection)
- [Hypothesis](./README.md#hypothesis)
- [Data Exploratory Analysis](./README.md#data-exploratory-analysis)
- [Data preparation](./README.md#data-preparation)
    + [Data Cleaning](./data-preparation.md#data-cleaning)
    + [Data preprocessing / Data Wrangling](./data-preparation.md#data-preprocessing--data-wrangling)
- [Data Generation](./README.md#data-generation)
- [Feature Selection](./README.md#feature-selection)
- [Feature Importance](./README.md#feature-importance)
- [Feature Engineering](./README.md#feature-engineering)
- [Post model-creation analysis, ML interpretation/explainability](./README.md#post-model-creation-analysis-ml-interpretationexplainability)
- [Model deployment](./README.md#model-deployment)
- [Statistics](./README.md#statistics)
- [Visualisation](./README.md#visualisation)
- [Common mistakes when training models (data related)](./README.md#common-mistakes-when-training-models-data-related)
- [Presentations](./README.md#presentations)
- [Cheatsheets](./README.md#cheatsheets)
- [Course / books](./README.md#course--books)
- [Best practices / rules / an unordered list of high level or low level guidelines](./README.md#best-practices--rules--an-unordered-list-of-high-level-or-low-level-guidelines)
- [Framework(s) / checklist(s)](./README.md#frameworks--checklists)
- [Notebooks](../notebooks/README.md#notebooks)
- [Programs and Tools](./README.md#programs-and-tools)
- [Databases](./README.md#databases)
- [References](./README.md#eferences)
- [Credits](./README.md#credits)
- [Contributing](./README.md#contributing)

---

## Ethics / altruistic motives

See [Ethics / altruistic motives](../README-details.md#ethics--altruistic-motives)

## Data Science

- [The Data Science Process](https://github.com/virgili0/Virgilio/blob/master/serving/purgatorio/fundamentals/the-data-science-process/the-data-science-process.md)
  - [Frame The Problem](https://github.com/virgili0/Virgilio/blob/master/serving/purgatorio/define-the-scope-and-ask-questions/frame-the-problem/frame-the-problem.md)
  - [Usage and Integration](https://github.com/virgili0/Virgilio/blob/master/serving/purgatorio/define-the-scope-and-ask-questions/usage-and-integration/usage-and-integration.md)
  - [Starting a Data Project](https://github.com/virgili0/Virgilio/blob/master/serving/purgatorio/define-the-scope-and-ask-questions/starting-a-data-project/starting-a-data-project.md)
  - [WorkSpace Setup and Cloud Computing](https://github.com/virgili0/Virgilio/blob/master/serving/purgatorio/define-the-scope-and-ask-questions/workspace-setup-and-cloud-computing/workspace-setup-and-cloud-computing.md)
- [JustCause package/framework - framework to foster good scientific practice in the research of causality methods](https://www.linkedin.com/posts/florianwilhelm_introduction-activity-6624318058347405312-fdBa) | [PyPu](https://pypi.org/project/JustCause/) | [GitHub](https://github.com/inovex/justcause)
- [“Metaflow is a human-friendly Python library”](https://github.com/Netflix/metaflow) [LinkedIn Post](https://www.linkedin.com/posts/eric-feuilleaubois-ph-d-43ab0925_netflixmetaflow-activity-6638658912201527296-1QqW)

## Datasets and sources of raw data

See [Datasets](./datasets.md)

## Data Collection

- [👉 Effective Data Collection 👈](https://www.linkedin.com/posts/asif-bhat_data-collection-activity-6625312371869089793-4LrM)

## Hypothesis

- [How to approach Hypothesis Testing](https://medium.com/@dhruvaggarwal6/how-to-approach-hypothesis-testing-6257d03bcfee)
- [Does Your Hypothesis Development Canvas Tell a Story?](https://www.linkedin.com/posts/data-science-central_does-your-hypothesis-development-canvas-tell-activity-6618701060817108993-EKjQ)

## Data Exploratory Analysis

See [Data Exploratory Analysis](./data-exploratory-analysis.md)

## Data preparation

- [Data preparation](https://github.com/virgili0/Virgilio/blob/master/serving/purgatorio/collect-and-prepare-data/data-preparation/data-preparation.md)
- See [Data preparation](./data-preparation.md)

## Data Generation

See [Data Generation](./data-generation.md#data-generation)

## Feature Selection

See [Feature Selection](./feature-selection.md)

## Feature Importance

- [Example: Feature Importance implementation (python)](../examples/data/feature-importance-filtering)
- [How to Calculate Feature Importance With Python](https://machinelearningmastery.com/calculate-feature-importance-with-python/)
- RFPimp:
   - [RF Importance](https://explained.ai/rf-importance/index.html)
   - [Explaining Feature Importance by example of a Random Forest](https://towardsdatascience.com/explaining-feature-importance-by-example-of-a-random-forest-d9166011959e)
- [Catboost model and W&B](../examples/cloud-devops-infra/wandb/feature-importance/catboost_feature_importance_tutorial.ipynb)
- [LightGBM model and W&B](../examples/cloud-devops-infra/wandb/feature-importance/lightgbm_feature_importance_tutorial.ipynb)

## Feature engineering

See [Feature engineering](./feature-engineering.md)

## Post model-creation analysis, ML interpretation/explainability

See [Post model-creation analysis, ML interpretation/explainability](./model-analysis-interpretation-explainability.md)

## Model deployment

- [Model Deployment Methods and Techniques - Part 1](https://lnkd.in/ghaTe_d)
- [Model Deployment Methods and Techniques - Part 2](https://lnkd.in/gk3cpzH)
- [Model Deployment Methods and Techniques - Part 3](https://lnkd.in/gV_cQJ2)
- [Model Deployment Methods and Techniques - Part 4](https://lnkd.in/g5zCV6w)
- [Model Deployment Methods and Techniques - Part 5](https://www.linkedin.com/posts/srivatsan-srinivasan-b8131b_datascience-ml-machinelearning-activity-6615447096793407488-sN1y)

## Statistics

See [Statistics.md](statistics.md#statistics)

## Visualisation

- [Data Visualization](https://github.com/virgili0/Virgilio/blob/master/serving/purgatorio/collect-and-prepare-data/data-visualization/data-visualization.md)
- See [Visualisation](../details/visualisation.md#visualisation)

## Common mistakes when training models (data related)

- Having a lot more training examples of one type of object than the other types
- Accidentally testing the neural network using images that were in the training set
- Training the neural network on data that is easier to recognize or more consistent than the real-world data it will be used to classify later on

## Presentations

- [A Rubric for ML Production Readiness - by Jiameng Gao from Applied Deep Learning Meetup in Feb 2019](https://docs.google.com/presentation/d/1-4gE9v1X7EP4rsBQlRtGA9IXDnBjlQPAqB3jlDBvUTU/edit#slide=id.p) (Paper: https://ai.google/research/pubs/pub46555)
- [Introduction to Data Analysis and Cleaning presentation](../presentations/data/01-mam-ml-study-group-meetup/Introduction_to_Data_Analysis_and_Cleaning.pdf) by [Mark Bell](http://www.nationalarchives.gov.uk/about/our-research-and-academic-collaboration/our-research-and-people/staff-profiles/mark-bell/)
- [Do we know our data, as good as we know our tools](../presentations/data/02-devoxx-uk-2019/README.md) by [Jeremie Charlet](http://twitter.com/jeremiecharlet) and [Mani Sarkar](http://github.com/neomatrix369)

## Cheatsheets

See under [Cheatsheets](../details/cheatsheets.md#cheatsheets)

## Courses / books

See [Courses / books](./courses-books.md)

## Best practices / rules / an unordered list of high level or low level guidelines

- [12 Best Practices for Modern Data Ingestion](https://go.streamsets.com/dzone-wp-12-best-practices-modern-data-ingestion)
    - [PDF](https://streamsets.com/wp-content/uploads/2018/01/WP-12-best-practices-for-modern-data-ingestion.pdf)
- [A Rubric for ML Production Readiness - by Jiameng Gao from Applied Deep Learning Meetup in Feb 2019](https://docs.google.com/presentation/d/1-4gE9v1X7EP4rsBQlRtGA9IXDnBjlQPAqB3jlDBvUTU/edit#slide=id.p) (Paper: https://ai.google/research/pubs/pub46555)
- [Rules of Machine Learning: Best Practices for ML Engineering](https://developers.google.com/machine-learning/guides/rules-of-ml/)

## Framework(s) / checklist(s)

See [Framework(s) / checklist(s)](./frameworks-checklists.md)

## Notebooks

See [Notebooks](../notebooks/README.md#notebooks)

## Programs and Tools

See [Programs and Tools](programs-and-tools.md#programs-and-tools)

## Databases

See [Databases](./databases.md)

## References

- [How to build a data science project from scratch](https://www.kdnuggets.com/2018/12/build-data-science-project-from-scratch.html)
- [Common mistakes when carrying out machine learning and data science](https://www.kdnuggets.com/2018/12/common-mistakes-data-science.html)
- [A Rubric for ML Production Readiness - Breck et al. 2017 by Jiameng Gao (28 rules to follow, suggested by Google)](https://docs.google.com/presentation/d/1-4gE9v1X7EP4rsBQlRtGA9IXDnBjlQPAqB3jlDBvUTU/edit#slide=id.p) | [Original Paper by Google](https://ai.google/research/pubs/pub46555)
- [Understanding Data Science Problems - template of questions to ask](http://url4149.bitgrit.net/wf/click?upn=qJT0wq97YSVxi6S9Gi10QGqeT3JSC6xJnYDSgYEwjzRMycP3yLSx2r-2BNxQzJHe9QPJFpU2-2FggIOmAMx4-2FXJyS5Ct5nq0JGa-2BaeTR278cf4Y016UI8tNe1mgRL66MJsyWyvn6y4MQGXNy5SqWqhbPcw-3D-3D_sX8FRvZaj8ntSB52F-2FOI3mORNoWV2VSsIMLOasSO2VX6r5g4xczJm1Y1-2FwGOMI-2BlSq1KNsGohBLZURHm6k60Tf2HtckfAZ6grcZUQF65S5oJU988M9Tw34CKxkXDto40DimsP-2FidGRva8-2F1aqLSRqIqousS4hXEet-2FT5ghzTXSqhZy5rNdfAdgpvrkvvm-2BZIs0VBaYDiakrHtCwc5eIKRA-3D-3D)
- [eBook: How to Succeed in Data Science](https://docs.google.com/document/d/1fvxDOdCjPx0wS4aqSOME3NyATJGN7sASLeEyygIvcJA/edit#) [deadlink]
- [Data Fallacies by Nabih Bawazir](https://www.linkedin.com/posts/nabihbawazir_data-fallacies-to-avoid-ugcPost-6600634052464742400-fmlf)

## Credits

Big thanks to [Jeremie Charlet](https://github.com/jcharlet) for his contributions to many of the resources on this page. Not forgetting the others who have also helped support in the building of the above resources.

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../CONTRIBUTING.md) guidelines, also have a read about our [licensing](../LICENSE.md) policy.

---

Back to [main page (table of contents)](../README.md)