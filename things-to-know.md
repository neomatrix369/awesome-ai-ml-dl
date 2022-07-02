# Things to know

As a (to-be) or (current) data scientist, data engineer, data analyst, machine learning engineer or any other professional or new-bie or student in this space, the below are useful points to know in a snapshot. They can become your learning points or fill any gaps in your understanding. Credits to the authors of the [Kaggle survey](https://google.qualtrics.com/jfe/form/SV_cSiHgVoAyExb9uR), most of the ideas are from that document.

---

- [Important part of your role at work (if work with data)](#important-part-of-your-role-at-work-if-work-with-data)
- [Media sources](#media-sources)
- [Useful blogs to read](#useful-blogs-to-read)
- [Course providers](#course-providers)
- [Courses](#courses)
- [Primary tools to analyse data](#primary-tools-to-analyse-data)
- [IDEs](#ides)
- [Hosted Notebook products](#hosted-notebook-products)
- [Programming languages](#programming-languages)
- [Data visualization libraries or tools](#data-visualization-libraries-or-tools)
- [Specialized hardware](#specialized-hardware)
- [Machine Learning Algorithms](#machine-learning-algorithms)
- [Machine learning frameworks](#machine-learning-frameworks)
- [Machine learning products](#machine-learning-products)
- [Big data / analytics products](#big-data--analytics-products)
- [Cloud computing platforms](#cloud-computing-platforms)
- [Cloud computing products](#cloud-computing-products)
- [Automated pipelines](#automated-pipelines)
- [Automated machine learning tools (or partial AutoML tools)](#automated-machine-learning-tools-or-partial-automl-tools)
- [Tools to help manage machine learning experiments](#tools-to-help-manage-machine-learning-experiments)
- [Publicly share or deploy your data analysis or machine learning applications](#publicly-share-or-deploy-your-data-analysis-or-machine-learning-applications)
- [Relational database products](#relational-database-products)
- [Other Tools](#other-tools)
- [Contributing](#contributing)

---

##  Important part of your role at work (if work with data)

- Analyze and understand data to influence product or business decisions
- Build and/or run the data infrastructure that the business uses for storing, analyzing, and operationalizing data
- Build prototypes to explore applying machine learning to new areas
- Build and/or run a machine learning service that operationally improves the product or workflows
- Experimentation and iteration to improve existing ML models
- Do research that advances the state of the art of machine learning


## Media sources

- [Hacker News](https://news.ycombinator.com/)
- [Twitter: data science influencers](https://twitter.com)
- [Reddit: r/machinelearning, r/datascience, etc](https://reddit.com)
- [Kaggle: forums, blog, social media, etc](https://kaggle.com)
- Course Forums (forums.fast.ai, Coursera forums, etc) 
- Podcasts
  - [Chai Time Data Science](https://chaitimedatascience.com/)
  - [Linear Digressions](https://lineardigressions.com/)
  - [Data Skeptics](https://www.dataskeptic.com/podcast?limit=10&offset=0)
  - **[Half Stack Data Science](https://halfstackdatascience.com/category/podcast)**
  - [TWiML](https://twimlai.com/?s=podcasts)
  - [Learning Machines 101](https://www.learningmachines101.com/)
  - [Talking Machines](http://www.thetalkingmachines.com/)
  - _[Top 10 Best Podcasts on AI, Analytics, Data Science, Machine Learning](https://www.kdnuggets.com/2019/07/best-podcasts-ai-analytics-data-science-machine-learning.html)_
  - [Podcast PyMCR](https://anchor.fm/pydatamcr)
- Blogs: [Towards Data Science](https://towardsdatascience.com), [Medium](https://medium.com), [Analytics Vidhya](https://AnalyticsVidhya.com), [KDnuggets](https://KDnuggets.com), etc
- Slack Communities: [ods.ai](https://ods.ai), [kagglenoobs](https://kagglenoobs.herokuapp.com), etc
- Journal Publications: traditional publications, preprint journals, etc
- Course Forums: [forums.fast.ai](https://forums.fast.ai), etc
- [YouTube](https://www.youtube.com): [Google Cloud AI Adventures](https://www.youtube.com/watch?v=HcqpanDadyQ&list=PLIivdWyY5sqJxnwJhe3etaK7utrBiPBQ2), [Siraj Raval](https://www.youtube.com/channel/UCWN3xxRkmTPmbKwht9FuE5A), etc
- [MWML Newsletter](https://newsletter.madewithml.com/) | [MWML Site](https://madewithml.com/) | [lessons](https://madewithml.com/#basics)
- [Data Pheonix Newsletter (previously known as Data Science Digest)](https://dataphoenix.info/) | [past issues](https://dataphoenix.info/tag/digest/)
- Other email newsletters (Data Elixir, O'Reilly Data & AI, etc) 


## Useful blogs to read

- [What I Learned from Writing a Data Science Article Every Week for a Year](https://towardsdatascience.com/what-i-learned-from-writing-a-data-science-article-every-week-for-a-year-201c0357e0ce?source=search_post---------0)
- [Why you should be a Generalist first, Specialist later as a Data Scientist?](https://towardsdatascience.com/why-you-should-be-a-generalist-first-specialist-later-as-a-data-scientist-f26d687f8c6)
- [Lessons from the deep end of data science slides](https://halfstackdatascience.com/wp-content/uploads/2019/11/Lessons-from-the-deep-end-of-data-science-2019-11-04.pdf) | [halfstackdatascience site](https://halfstackdatascience.com/lessons-from-the-deep-end-of-data-science)

## Course providers

- [DataQuest](https://www.dataquest.io/)
- [Coursera](https://Coursera.org)
- [DataCamp](https://DataCamp.com)
- LinkedIn Learning: [[1]](https://www.linkedin.com/learning/) | [[2]](https://learning.linkedin.com/) | [[3]](https://linkedinlearning.tamu.edu/)
- [edX](https://www.edx.org/)
- [Fast.ai](http://Fast.ai)
- [Udacity](http://Udacity.com)
- [Udemy](http://Udemy.com)
- University Courses
- Cloud-certification programs (direct from AWS, Azure, GCP, or similar)
- [Kaggle Courses (Kaggle Learn)](https://www.kaggle.com/learn/overview)
- [Learning Centre H2O](https://www.linkedin.com/posts/sudalairajkumar_home-en-activity-6679719946169270272-O__-)

## Courses

See [Courses](./courses.md#courses)


## Primary tools to analyse data

- Basic statistical software (Microsoft Excel, Google Sheets, etc.)
- Advanced statistical software (SPSS, SAS, etc.)
- Business intelligence software (Salesforce, Tableau, Spotfire, etc.)
- Local development environments (RStudio, JupyterLab, etc.)
- Cloud-based data software & APIs (AWS, GCP, Azure, etc.)
- [Pandas profiling](./data/pandas-profiling.md)
- [Bamboolib](./data/bamboolib.md)
- [Dabl: Data Analysis Baseline Library](https://dabl.github.io/dev/) (just like [Pandas profiling](./data/pandas-profiling.md)) | [GitHub](https://github.com/dabl/dabl)
- Also see resources under **Data**: [[1]](./README-details.md#data) | [[2]](./data/README.md#data)


## IDEs

- [Vim](https://www.vim.org/)
- [Emacs](https://www.gnu.org/software/emacs/)
- [Spacemacs: Emacs + Vim](https://www.spacemacs.org/)
- [PyCharm](https://www.jetbrains.com/pycharm/)
- [Spyder](https://www.spyder-ide.org/)
- [RStudio](https://rstudio.com/)
- [Atom](https://ide.atom.io/)
- [Jupyter (JupyterLab, Jupyter Notebooks, etc...)](https://jupyter.org/)
- [Sublime Text](https://www.sublimetext.com/)
- [VSCode](https://code.visualstudio.com/)
- [Visual Studio](https://visualstudio.microsoft.com/)
- [MATLAB](https://www.mathworks.com/products/matlab.html)
- [Notepad++](https://notepad-plus-plus.org/)
- Also see [Cheatsheets](./details/cheatsheets.md)


## Hosted Notebook products

- [Microsoft Azure Notebooks](https://notebooks.azure.com/)
- [FloydHub](https://www.floydhub.com/)
- [Paperspace / Gradient](https://gradient.paperspace.com/)
- [Code Ocean](https://codeocean.com/)
- [AWS Notebook Products (EMR Notebooks, Sagemaker Notebooks, etc)](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-managed-notebooks-working-with.html)
- [Amazon EMR Notebooks](https://docs.aws.amazon.com/emr/latest/ManagementGuide/emr-managed-notebooks.html)
- [Amazon Sagemaker Studio](https://docs.aws.amazon.com/sagemaker/latest/dg/notebooks.html)
- [Databricks Collaborative Notebooks](https://databricks.com/product/collaborative-notebooks)
- [Google Colab](https://colab.research.google.com/)
- [Google Cloud Notebook Products (AI Platform, Datalab, etc)](https://cloud.google.com/ai-platform-notebooks/)
- [Google Cloud Datalab Notebooks](https://cloud.google.com/datalab/docs/how-to/working-with-notebooks)
- [Binder / JupyterHub](https://mybinder.org/)
- [Kaggle Notebooks (Kernels)](https://www.kaggle.com/kernels/)
- [IBM Watson Studio](https://www.ibm.com/cloud/watson-studio/)
- [Count](https://count.co)
- Also see resources under [Notebooks](./notebooks/README.md#notebooks) and [Cheatsheets](./details/cheatsheets.md)


## Programming languages

- [Swift](https://en.wikipedia.org/wiki/Swift)
- [MATLAB](https://www.mathworks.com/products/matlab.html)
- [R](https://en.wikipedia.org/wiki/R_(programming_language))
- [Julia](https://en.wikipedia.org/wiki/Julia_%28programming_language%29)
- [Javascript](https://en.wikipedia.org/wiki/JavaScript)
- [Java](https://en.wikipedia.org/wiki/Java)
- [C](https://en.wikipedia.org/wiki/C_%28programming_language%29)
- [Bash](https://en.wikipedia.org/wiki/Bash_%28Unix_shell%29)
- [SQL](https://en.wikipedia.org/wiki/SQL)
- [C++](https://en.wikipedia.org/wiki/C%2B%2B)
- [Python](https://www.python.org/), **also see [Programming in Python](./Programming-in-Python.md)**
- [Typescript](https://syntaxcorrect.com/The_TypeScript_Programming_Language)
- Also see [Cheatsheets](./details/cheatsheets.md)


## Data visualization libraries or tools

- [Matplotlib](https://matplotlib.org/)
- [Bokeh](https://docs.bokeh.org/en/latest/)
- [Gglot / ggplot2](https://cran.r-project.org/web/packages/ggplot2/index.html)
- [Shiny](https://cran.r-project.org/web/packages/shiny/index.html)
- [Geoplotlib](https://github.com/andrea-cuttone/geoplotlib)
- [Leaflet / Folium](https://leafletjs.com/)
- [Plotly / Plotly Express](https://plot.ly/) - recommend learning
- [Seaborn](https://seaborn.pydata.org/)
- [D3.js](https://d3js.org/) - recommend learning libraries _built on top_ of [D3.js](https://d3js.org)
- [Altair](https://altair-viz.github.io/)
- [Pandas profiling](./data/pandas-profiling.md)
- [Bamboolib](./data/bamboolib.md)
- See more resources under [Visualisation](./details/visualisation.md) and [Cheatsheets](./details/cheatsheets.md)


## Specialized hardware

- [CPUs](./cloud-devops-infra/README.md#cpu)
- [GPUs](./cloud-devops-infra/README.md#gpu)
  - See also [NVIDIA's RAPIDS](./cloud-devops-infra/gpus/rapids.md#rapids)
- [TPUs](./cloud-devops-infra/README.md#tpu)
- [FPGA](./cloud-devops-infra/README.md#fpga)
- [IPU](./cloud-devops-infra/README.md#ipu)
- See more resources under [Cloud/DevOps/Infra](./cloud-devops-infra/README.md)


## Machine learning Algorithms

- [Decision Trees or Random Forests](https://towardsdatascience.com/decision-trees-and-random-forests-df0c3123f991?gi=d52c4bc59f17)
- [Generative Adversarial Networks](https://en.wikipedia.org/wiki/Generative_adversarial_network)
- [Convolutional Neural Networks](https://ujjwalkarn.me/2016/08/11/intuitive-explanation-convnets/)
- [Linear or Logistic Regression](https://techdifferences.com/difference-between-linear-and-logistic-regression.html)
- [Gradient Boosting Machines (xgboost, lightgbm, etc)](https://towardsdatascience.com/understanding-gradient-boosting-machines-9be756fe76ab?gi=2842cc76ca28)
- [Dense Neural Networks (MLPs, etc)](https://heartbeat.fritz.ai/classification-with-tensorflow-and-dense-neural-networks-8299327a818a?gi=df002d1d5355)
- [Bayesian Approaches](https://en.wikipedia.org/wiki/Bayesian_inference)
- Evolutionary Approaches: [Approach 1](https://towardsdatascience.com/introduction-to-evolutionary-algorithms-a8594b484ac) | [Approach 2](https://towardsdatascience.com/evolutionary-approaches-towards-ai-past-present-and-future-b23ccb424e98)
- [Recurrent Neural Networks](https://en.wikipedia.org/wiki/Recurrent_neural_network)
- [Transformer Networks (BERT, gpt-2, etc)](https://ai.googleblog.com/2017/08/transformer-novel-neural-network.html)
- See more resources under **Machine Learning** resources: [[1]](./details/java-jvm.md#machine-learning) | [[2]](./details/julia-python-and-r.md#machine-learning)


## Machine learning frameworks

- [RandomForest](https://cran.r-project.org/web/packages/randomForest/index.html)
- [Tensorflow](https://www.tensorflow.org/)
  - [Swift for TensorFlow](https://www.tensorflow.org/swift/) - next generation platform for deep learning and differentiable programming
- [LightGBM](https://lightgbm.readthedocs.io/en/latest/)
- [Keras](https://keras.io/)
- [Caret](https://cran.r-project.org/web/packages/caret/index.html)
- [PyTorch](https://pytorch.org/) | Also see [PyTorch](./details/pytorch.md)
  - PyTorch Lightening: [Homepage](pytorchlightning.ai) | [Github](github.com/PyTorchLightning/pytorch-lightning) | [Docs](pytorch-lightning.readthedocs.io/en/stable/)
- [Fast.ai](https://docs.fast.ai/)
- [Spark Mlib](https://spark.apache.org/mllib/)
- [Scikit-learn](https://scikit-learn.org/stable/)
- [Xgboost](https://xgboost.readthedocs.io/en/latest/)
- [CatBoost](https://catboost.ai/docs/)
- [H2O 3](http://docs.h2o.ai/h2o/latest-stable/h2o-docs/welcome.html/)
- [Prophet](https://facebook.github.io/prophet/)
- [Tidymodels](https://github.com/tidymodels/tidymodels)
- [MXNet](https://github.com/apache/incubator-mxnet/)
- [JAX](https://github.com/google/jax/)
- See more resources under **Machine Learning** resources: [[1]](./details/java-jvm.md#machine-learning) | [[2]](./details/julia-python-and-r.md#machine-learning) and [Cheatsheets](./details/cheatsheets.md)


## Machine learning products

- [Amazon SageMaker](https://aws.amazon.com/sagemaker/)
- [Google Cloud Speech-to-Text](https://cloud.google.com/speech-to-text/)
- [SAS](https://www.sas.com/en_us/home.html)
- [Azure Machine Learning Studio](https://studio.azureml.net/)
- [Google Cloud Machine Learning Engine](https://cloud.google.com/ml-engine/)
- [Google Cloud Natural Language](https://cloud.google.com/natural-language/)
- [Google Cloud Vision](https://cloud.google.com/vision/)
- [RapidMiner](https://rapidminer.com/)
- [Google Cloud Translation](https://cloud.google.com/translate/)
- [Cloudera](https://www.cloudera.com/)
- See more resources under **Machine Learning** resources: [[1]](./details/java-jvm.md#machine-learning) | [[2]](./details/julia-python-and-r.md#machine-learning), [Cloud/DevOps/Infra](./cloud-devops-infra/README.md), [Data > Programs and Tools](./data/programs-and-tools.md#programs-and-tools) and [Cheatsheets](./details/cheatsheets.md)


## Big data / analytics products

- [Teradata](https://www.teradata.com/)
- [Google Cloud Pub/Sub](https://cloud.google.com/pubsub/docs/)
- [AWS Elastic MapReduce](https://aws.amazon.com/emr/)
- [Google Cloud Dataflow](https://cloud.google.com/dataflow/)
- [AWS Redshift](https://aws.amazon.com/redshift/)
- [AWS Athena](https://aws.amazon.com/athena/)
- [AWS Kinesis](https://aws.amazon.com/kinesis/)
- [Microsoft Analysis Services](https://azure.microsoft.com/en-us/services/analysis-services/)
- [Google BigQuery](https://cloud.google.com/bigquery/)
- [Databricks](https://databricks.com/)
- [Microsoft Azure Data Lake Storage](https://azure.microsoft.com/en-us/services/storage/data-lake-storage/#overview)
- [Apache Spark](https://spark.apache.org/)
- [Apache Hive](https://hive.apache.org/)
- [Apache Pig](https://pig.apache.org/)
- See more resources under [Cloud/DevOps/Infra](./cloud-devops-infra/README.md), [Data > Programs and Tools](./data/programs-and-tools.md#programs-and-tools), [Databases](./data/README.md#databases) and [Cheatsheets](./details/cheatsheets.md)


## Cloud computing platforms

- [IBM Cloud](https://www.ibm.com/cloud/)
- [VMWare Cloud](https://cloud.vmware.com/)
- [Alibaba Cloud](https://us.alibabacloud.com/)
- [SAP Cloud](https://cloudplatform.sap.com/index.html/)
- [Google Cloud Platform (GCP)](https://cloud.google.com/gcp/)
- [RedHat Cloud](https://www.redhat.com/en/technologies/cloud-computing/cloud-suite/)
- [Oracle Cloud](https://www.oracle.com/cloud/)
- [Amazon Web Services (AWS)](https://aws.amazon.com)
- [Microsoft Azure](https://azure.microsoft.com/en-us/)
- [Salesforce Cloud](https://www.salesforce.com/products/sales-cloud/features/)
- [Tencent Cloud](https://intl.cloud.tencent.com)
- See more resources under [Cloud/DevOps/Infra](./cloud-devops-infra/README.md) and [Data > Programs and Tools](./data/programs-and-tools.md#programs-and-tools)


## Cloud computing products

- [Oracle Cloud Infrastructure](https://www.oracle.com/cloud/)
- [Google Kubernetes Engine](https://cloud.google.com/kubernetes-engine/)
- [Azure Virtual Machines](https://azure.microsoft.com/en-us/services/virtual-machines/)
- [Google Compute Engine (GCE)](https://cloud.google.com/compute/)
- [AWS Elastic Beanstalk](https://aws.amazon.com/elasticbeanstalk/)
- [AWS Elastic Compute Cloud (EC2)](https://aws.amazon.com/ec2/)
- [Google App Engine](https://cloud.google.com/appengine/)
- [AWS Lambda](https://aws.amazon.com/lambda/)
- [Google Cloud Functions](https://cloud.google.com/functions/)
- [Azure Container Service](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/microsoft.acs)
- [AWS Batch](https://aws.amazon.com/batch/)
- See more resources under [Cloud/DevOps/Infra](./cloud-devops-infra/README.md) and [Data > Programs and Tools](./data/programs-and-tools.md#programs-and-tools)


## Automated pipelines

- [Automated data augmentation (e.g. imgaug, albumentations](https://auto-da.github.io/)
- [Automated feature engineering/selection (e.g. tpot, boruta_py)](https://www.featuretools.com/)
- [Automated model selection (e.g. auto-sklearn, xcessiv)](https://stats.stackexchange.com/questions/20836/algorithms-for-automatic-model-selection)
- [Automated model architecture searches (e.g. darts, enas)](https://www.fast.ai/2018/07/16/auto-ml2/)
- [Automated hyperparameter tuning (e.g. hyperopt, ray.tune, Vizier)](https://databricks.com/blog/2019/07/18/automated-hyperparameter-tuning-scaling-and-tracking-on-demand-webinar-and-faqs-now-available.html)
- [Automated Machine Learning Hyperparameter Tuning in Python](https://www.datasciencecentral.com/profiles/blogs/automated-machine-learning-hyperparameter-tuning-in-python-a) [LinkedIn Post](https://www.linkedin.com/posts/data-science-central_automated-machine-learning-hyperparameter-activity-6650229303994826752-H7Pi)
- Automation of full ML pipelines (e.g. Google AutoML, H20 Driverless AI)
- [Machine Learning incl. #AutoML overfits. On a mission to develop Causal AI](https://www.linkedin.com/posts/causalens_causal-ai-commodity-trading-use-case-activity-6637402428813692928-TuVM)
- Automation of full ML pipelines: (e.g. [Google AutoML](https://cloud.google.com/automl/), [H2O Driverless AI](https://www.h2o.ai/products/h2o-driverless-ai/))
- See more resources under [Automation](./README-details.md#automation), [Cloud/DevOps/Infra](./cloud-devops-infra/README.md), and [Data > Programs and Tools](./data/programs-and-tools.md#programs-and-tools)


## Automated machine learning tools (or partial AutoML tools)

- [Databricks AutoML](https://databricks.com/product/automl-on-databricks/)
- [DataRobot AutoML](https://www.datarobot.com/lp/automated-machine-learning-works-business/)
- [Tpot](https://github.com/EpistasisLab/tpot/)
- [Google AutoML](https://cloud.google.com/automl/)
- [Auto_ml](https://github.com/ClimbsRocks/auto_ml/) 
- [Auto-Keras](https://github.com/keras-team/autokeras/)
- [Auto-Sklearn](https://github.com/automl/auto-sklearn/)
- [PyCaret](https://pycaret.org) | [On awesome-ai-ml-dl](https://github.com/neomatrix369/awesome-ai-ml-dl/search?q=pycaret)
- [Xcessiv](https://github.com/reiinakano/xcessiv/) 
- [MLbox](https://github.com/AxeldeRomblay/MLBox/)
- [H20 Driverless AI](https://www.h2o.ai/products/h2o-driverless-ai/)
- [AutoGluon](https://github.com/awslabs/autogluon) -  AutoML for Image, Text, and Tabular Data.
- [FLAML](https://github.com/microsoft/FLAML) - A fast library for AutoML and tuning.
- [Neural Network Intelligence](https://github.com/microsoft/nni) - An open source AutoML toolkit for automate machine learning lifecycle.
- [The 3 Best Free Online Resources to Learn MLOps](https://telesto.ai/the-3-best-free-online-resources-to-learn-mlops/)
- [An awesome list of references for MLOps - Machine Learning Operations 👉 ml-ops.org](https://github.com/visenger/awesome-mlops)
- [Awesome Production Machine Learning](https://github.com/EthicalML/awesome-production-machine-learning)
- See more resources under [Automation](./README-details.md#automation), [Cloud/DevOps/Infra](./cloud-devops-infra/README.md), [Data > Programs and Tools](./data/programs-and-tools.md#programs-and-tools) and [Cheatsheets](./details/cheatsheets.md)


## Tools to help manage machine learning experiments
* [Valohai](https://valohai.ai/)
* [Neptune.ai](https://neptune.ai/)
* [Weights & Biases](https://www.wandb.com/)
* [Comet.ml](https://www.comet.ml/site/)
* [Sacred + Omniboard](https://github.com/IDSIA/sacred/)
* [TensorBoard](https://www.tensorflow.org/tensorboard/)
* [Polyaxon](https://polyaxon.com/)
* [Guild AI](https://guild.ai)
* [Trains](https://github.com/allegroai/trains/)
* [Domino Model Monitor](https://www.dominodatalab.com/product/domino-model-monitor/)
* [Apache Airflow](https://airflow.apache.org/)
* [Flyte](https://flyte.org/)


## Publicly share or deploy your data analysis or machine learning applications

* [Plotly Dash](https://plotly.com/dash/)
* [Streamlit](https://www.streamlit.io/)
* [NBViewer](https://nbviewer.jupyter.org/)
* [Binder](https://mybinder.org/)
* [GitHub](https://github.com/)
* [Personal blog](https://medium.com/)
* [Kaggle](https://www.kaggle.com/)
* [Colab](https://colab.research.google.com)


## Relational database products 

- [Oracle Database](https://www.oracle.com/database/index.html)
- [Microsoft SQL Server](https://www.microsoft.com/en-gb/sql-server/)
- [Azure SQL Database](https://azure.microsoft.com/en-us/services/sql-database/)
- [PostgresSQL](https://www.postgresql.org/)
- [SQLite](https://www.sqlite.org/)
- [AWS Relational Database Service](https://aws.amazon.com/rds/)
- [Microsoft Access](https://products.office.com/en-us/access)
- [AWS DynamoDB](https://aws.amazon.com/dynamodb/)
- [MySQL](https://www.mysql.com/)
- [Google Cloud SQL](https://cloud.google.com/sql/docs/)
- [Google Cloud Firestore](https://cloud.google.com/firestore)
- [MongoDB](https://www.mongodb.com)
- [Snowflake](https://www.snowflake.com)
- [IBM Db2](https://www.ibm.com/analytics/db2)
- See other resources under [Databases](./data/README.md#databases) and [Cheatsheets](./details/cheatsheets.md)


## Business intelligence tools

* [Amazon QuickSight](https://aws.amazon.com/quicksight/)
* [Microsoft Power BI](https://powerbi.microsoft.com/en-us/)
* [Google Data Studio](https://datastudio.google.com)
* [Tableau](https://www.tableau.com/solutions/salesforce)
* [Qlik](https://www.qlik.com/us/)
* [Domo](https://www.domo.com/)
* [TIBCO Spotfire](https://www.tibco.com/products/tibco-spotfire)
* [Alteryx](https://www.alteryx.com/)
* [Sisense](https://www.sisense.com/)
* [SAP Analytics Cloud](https://www.sapanalytics.cloud/product)
* [Snowplow Analytics](https://snowplowanalytics.com/)
* [Looker](https://cloud.google.com/looker)
* [ChartIO: Cloud-based data analytics exploration for all](https://chartio.com/)
* [Salesforce](https://www.salesforce.com/)
* [Einstein Analytics](https://www.salesforce.com/products/einstein-analytics/overview/)
* [Count](https://count.co)


## Other Tools

- [Geo Gebra](https://github.com/virgili0/Virgilio/blob/master/serving/inferno/tools/geo-gebra/geo-gebra.md)
- [Latex](https://github.com/virgili0/Virgilio/blob/master/serving/inferno/tools/latex/latex.md)
- [Regex](https://github.com/virgili0/Virgilio/blob/master/serving/inferno/tools/regex/regex.ipynb)
- [Wolfram Alpha](https://github.com/virgili0/Virgilio/blob/master/serving/inferno/tools/wolfram-alpha/wolfram-alpha.md)


# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](CONTRIBUTING.md) guidelines, also have a read about our [licensing](LICENSE.md) policy.

---

Back to [main page (table of contents)](README.md)
