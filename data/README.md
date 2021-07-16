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
- [Feature Extraction](./README.md#feature-extraction)
- [Feature Importance](./README.md#feature-importance)
- [Feature Engineering](./README.md#feature-engineering)
- [Feature Selection](./README.md#feature-selection)
- [Hyperparameter tuning](#hyperparameter-tuning)
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
- [5 free books for learning Python for DS](https://towardsdatascience.com/5-free-books-for-learning-python-for-data-science-87be443c084)
- [7 advanced tricks in pandas for data science](https://www.linkedin.com/posts/towards-data-science_7-advanced-tricks-in-pandas-for-data-science-activity-6655303741224423424-SJtU)
- [The Ultimate NumPy Tutorial for Data Science Beginners](https://www.analyticsvidhya.com/blog/2020/04/the-ultimate-numpy-tutorial-for-data-science-beginners/)
- [Top 10 Data science podcast must follow for learn new things](https://www.linkedin.com/posts/ashishpatel2604_datascience-deeplearning-machinelearning-activity-6667325165476675585-NM-9)
- [Top 20 Youtube Channels for Data Science](https://www.linkedin.com/posts/nabihbawazir_statistics-data-datascience-activity-6673538746262142976-iPim)
- [Advanced Data Science from IBM](https://youtu.be/qx242g9kHtY)
- [𝟏𝟐 𝐒𝐭𝐞𝐩𝐬 𝐭𝐨 𝐏𝐫𝐨𝐝𝐮𝐜𝐭𝐢𝐨𝐧-𝐐𝐮𝐚𝐥𝐢𝐭𝐲 𝐃𝐚𝐭𝐚 𝐒𝐜𝐢𝐞𝐧𝐜𝐞 𝐂𝐨𝐝𝐞](https://www.linkedin.com/posts/ashishpatel2604_production-quality-code-activity-6656451504498675712-0Wq3)
- [Top 10 Popular GitHub Repositories to learn about Data Science](https://www.linkedin.com/posts/towards-data-science_top-10-popular-github-repositories-to-learn-activity-6657344687885688832-TVf7)
- [The difference between Statistics and Data Science: Big Data and Inferential Statistics](https://www.datasciencecentral.com/profiles/blogs/the-difference-between-statistics-and-data-science-big-data-and)
- [DataScience resources (in the form of a book) from Eric](https://github.com/EricSchles/datascience_book)
- [Data Exploration and API First Design: Deep Learning Hands-On Series with Eric Schles](https://gist.github.com/lidderupk/f6562beadd39406a033c738201f46c12)
- [Augmented Analytics Engine](https://www.linkedin.com/posts/data-science-central_augmented-analytics-engine-activity-6648764149864153088-dZWX)
- [Putting an end to Unreliable Analytics by David Yaffe](https://www.linkedin.com/posts/towards-data-science_putting-an-end-to-unreliable-analytics-activity-6717020155261587456-0hyA)
- The Fundamentals of end-to-end Data Strategy: [video](https://www.youtube.com/watch?v=hAE12zICkLI&feature=youtu.be) | [slides](https://drive.google.com/drive/folders/1LV_gP1muLbbXesJISrTqebpyrpRfTjbq?usp=sharing) | [Resources](http://nicolejaneway.com/data-strategy/resources/) | [Feedback](https://docs.google.com/forms/d/e/1FAIpQLSfZsLIIdFJSS_fRwzj_trDF_iM6-EnfPT329GfCj-tPNr_DJA/viewform)

## Datasets and sources of raw data

See [Datasets](./datasets.md)

## Data Collection

- [👉 Effective Data Collection 👈](https://www.linkedin.com/posts/asif-bhat_data-collection-activity-6625312371869089793-4LrM)
- [The Ultimate Guide to Effective Data Collection](https://www.linkedin.com/posts/iamsivab_the-ultimate-guide-to-effective-data-collection-activity-6656175779732381697-lv6X)

## Hypothesis

- [Correlation, causation, multicollinearity, confounding features or variables](https://otexts.com/fpp2/causality.html)
- [How to approach Hypothesis Testing](https://medium.com/@dhruvaggarwal6/how-to-approach-hypothesis-testing-6257d03bcfee)
- [Does Your Hypothesis Development Canvas Tell a Story?](https://www.linkedin.com/posts/data-science-central_does-your-hypothesis-development-canvas-tell-activity-6618701060817108993-EKjQ)
- [A Complete Guide to Hypothesis Testing](https://towardsdatascience.com/a-complete-guide-to-hypothesis-testing-2e0279fa9149)
- [An introduction to Statistical Inference and Hypothesis testing](https://twitter.com/DataScienceCtrl/status/1261325769155973122)
- [A set of descriptive statistics and hypothesis tests across different types of data](https://github.com/EricSchles/describer_ml)
- [The statistical analysis t-test explained for beginners and experts](https://towardsdatascience.com/the-statistical-analysis-t-test-explained-for-beginners-and-experts-fd0e358bbb62)
- [The book of why" by Judea Pearl : A great overview and presents many relevant techniques](https://www.amazon.com/Book-Why-Science-Cause-Effect/dp/046509760X)
- [Craig's presentation: Visualizing the Why — Strategy and Roadmaps in Context](https://www.dropbox.com/s/knagl9f7u9hxvr7/Strategy%20Maps%20Agile%20Evangelists.pdf?dl=0](https://www.youtube.com/watch?v=LOjsuYzzOkA)
- [Correlation & Causation: The Couple That Wasn’t](https://www.linkedin.com/posts/analytics-india-magazine_statistics-data-strategy-activity-6821324490719555584-9uyy)

## Data Exploratory Analysis

See [Data Exploratory Analysis](./data-exploratory-analysis.md)

## Data preparation

- [Data preparation](https://github.com/virgili0/Virgilio/blob/master/serving/purgatorio/collect-and-prepare-data/data-preparation/data-preparation.md)
- See [Data preparation](./data-preparation.md)

## Data Generation

See [Data Generation](./data-generation.md#data-generation)

## Feature Extraction

- [Hierarchical Feature Extraction for Compact Representation and Classification of Datasets](doc.ml.tu-berlin.de/publications/publications/SchKoh08.pdf)
- [Guide to Feature Extraction Approaches for Text Data](https://rumankhan1.medium.com/guide-to-feature-extraction-approaches-for-text-data-1ebdcc4b9834)

## Feature Importance

- [Example: Feature Importance implementation (python)](../examples/data/feature-importance-filtering)
- [How to Calculate Feature Importance With Python](https://machinelearningmastery.com/calculate-feature-importance-with-python/)
- RFPimp:
   - [RF Importance](https://explained.ai/rf-importance/index.html)
   - [Explaining Feature Importance by example of a Random Forest](https://towardsdatascience.com/explaining-feature-importance-by-example-of-a-random-forest-d9166011959e)
- [Catboost model and W&B](../examples/cloud-devops-infra/wandb/feature-importance/catboost_feature_importance_tutorial.ipynb)
- [LightGBM model and W&B](../examples/cloud-devops-infra/wandb/feature-importance/lightgbm_feature_importance_tutorial.ipynb)
- [The 4 types of additive Feature Importances](https://twitter.com/TDataScience/status/1264958410405171202)
- [The Math of Random Forests and Feature Importance in Scikit-learn and Spark](https://www.linkedin.com/posts/data-science-central_the-math-of-decision-trees-random-forest-activity-6656775689431240705-kwf_)
- Path Explain - toolkit for feature attributions: [GitHub](https://github.com/suinleelab/path_explain) | [PyPI](https://pypi.org/project/path-explain/) | [Path Explain on MWML](https://madewithml.com/projects/1931/path-explain/)
- [Open Machine Learning Course: Feature Importance](https://mlcourse.ai/articles/topic5-part3-feature-importance/)

## Feature engineering

See [Feature engineering](./feature-engineering.md)

## Feature Selection

See [Feature Selection](./feature-selection.md)

## Hyperparameter tuning

- [Ray Tune Sweeps](https://docs.wandb.com/sweeps/ray-tune)
- [W&B Sweeps](https://docs.wandb.com/sweeps)
- [Automated Machine Learning Hyperparameter Tuning in Python](https://www.linkedin.com/posts/vincentg_automated-machine-learning-hyperparameter-activity-6693176296077348864-7Ihf)
- Bayesian hyperparameter optimisation by Akinkunle: [Original Notebook](https://colab.research.google.com/drive/1akyJnd7O-lqA5I8mbR2gDG_VsjOBSp05?usp=sharing) | [Saved Notebook](https://colab.research.google.com/drive/1Nic2155ulaYDRrGUPDKNhY49j2xrZ99B) | [Slides](https://www.dropbox.com/sh/q0v0k3ida37thyn/AAB6wXMge7C6fvqKIZmGFXVQa?dl=0)
- [Hyperparameter optimization for Neural Networks](http://neupy.com/2016/12/17/hyperparameter_optimization_for_neural_networks.html#id24)
- [Tune Hyperparameters Easily with W&B Sweeps](https://www.youtube.com/watch?v=9zrmUIlScdY)


## Post model-creation analysis, ML interpretation/explainability
- [Pruning: DL models](https://www.subhadityamukherjee.me/2020/09/25/Pruning.html)
- [Pruning models](https://app.wandb.ai/authors/pruning/reports/Plunging-into-Model-Pruning-in-Deep-Learning--VmlldzoxMzcyMDg](https://app.wandb.ai/authors/pruning/reports/Scooping-into-Model-Pruning-in-Deep-Learning--VmlldzoxMzcyMDg?utm_source=social_slack&utm_medium=slack&utm_campaign=report_author)
- [Poor Man’s BERT • Exploring Pruning as an Alternative to Knowledge Distillation.](https://www.linkedin.com/posts/philipvollet_nlp-nlproc-innovation-activity-6693396556227473408--3Ro)
See [Post model-creation analysis, ML interpretation/explainability](./model-analysis-interpretation-explainability.md)

## Model deployment

- [Model Deployment Methods and Techniques - Part 1](https://lnkd.in/ghaTe_d)
- [Model Deployment Methods and Techniques - Part 2](https://lnkd.in/gk3cpzH)
- [Model Deployment Methods and Techniques - Part 3](https://lnkd.in/gV_cQJ2)
- [Model Deployment Methods and Techniques - Part 4](https://lnkd.in/g5zCV6w)
- [Model Deployment Methods and Techniques - Part 5](https://www.linkedin.com/posts/srivatsan-srinivasan-b8131b_datascience-ml-machinelearning-activity-6615447096793407488-sN1y)

## Statistics

- [Mode of a Log-Normal distribution by Sahil Gupta](https://www.linkedin.com/posts/towards-data-science_mode-of-a-log-normal-distribution-activity-6664846621953662976-znG1)
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