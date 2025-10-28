# Time-series

- [Introductory](#introductory)
- [Classification](#classification)
- [Feature engineering](#feature-engineering)
- [ES-RNN](#es-rnn)
- [WaveNet](#wavenet)
- [DeepAR](#deepar)
- [Methods: ARMA/ARIMA/SARIMA and others](#methods-armaarimasarima-and-others)
- [Non-stationary Time-series](#non-stationary-time-series)
- [Look-ahead bias](#look-ahead-bias)
- [Generalized Additive Models](#generalized-additive-models)
- [Courses / Tutorials / Workshops](#courses--tutorials--workshops)
- [Applied Time series](applied-time-series)
- [Gaussian process](#gaussian-process)
- [Neural Networks & Deep Learning](#neural-networks--deep-learning)
- [Forecasting](#forecasting)
- [Forecasting using Prophet](#forecasting-using-prophet)
- [Prediction](#prediction)
- [Trend estimation / trend analysis](#trend-estimation--trend-analysis)
- [Notebooks](#notebooks)
- [Misc](#misc)
- [Contributing](#contributing)

---

## Introductory

- [Step by Step guide to learn Time Series Modeling](https://www.analyticsvidhya.com/blog/2015/02/step-step-guide-learn-time-series/)
- [Introduction to ARMA Time Series Models – Simplified](https://www.analyticsvidhya.com/blog/2015/03/introduction-auto-regression-moving-average-time-series/)
- [Creating Time Series Forecast using Python](https://courses.analyticsvidhya.com/courses/creating-time-series-forecast-using-python)
- [Time Series Analysis in Python](https://www.datacamp.com/courses/introduction-to-time-series-analysis-in-python)
- [Introduction to Time Series Classification in Python](https://blog.edugrad.com/introduction-to-time-series-classification-in-python/)
- [Time Series Analysis in Python: An Introduction](https://towardsdatascience.com/time-series-analysis-in-python-an-introduction-70d5a5b1d52a)
- [An Introduction to Time-series Analysis Using Python and Pandas](https://medium.com/towards-artificial-intelligence/an-introduction-to-time-series-analysis-using-python-and-pandas-222fe72b191a)
- [Time Series Analysis with Pandas](https://www.linkedin.com/posts/eric-feuilleaubois-ph-d-43ab0925_time-series-analysis-with-pandas-activity-6639096721928396800-n8ia)
- [Time Series Forecast: A basic introduction using Python](https://medium.com/@stallonejacob/time-series-forecast-a-basic-introduction-using-python-414fcb963000)
- [Deep Learning for Time Series | Dimitry Larko | Kaggle Days](https://www.youtube.com/watch?v=svNwWSgz2NM&feature=youtu.be)
- [(Video) Ian Ozsvald: A gentle introduction to Pandas timeseries and Seaborn | PyData London 2019](https://www.youtube.com/watch?v=8upGdZMlkYM (1hr 24m))
- [(Video) Quentin Caudron - Introduction to data analytics with pandas](https://www.youtube.com/watch?v=F7sCL61Zqss (1hr 51m))
- [(Video) Ross Taylor | Time Series for Python with PyFlux](https://www.youtube.com/watch?v=JUctzSSAjG4 (42m))
- https://www.sas.upenn.edu/~fdiebold/Teaching104/Ch14_slides.pdf
- [(Video) Case Study in Travel Business - Time Series Analysis with Seasonal Data by Cheuk Ting Ho](https://www.youtube.com/watch?v=ZR9aAZZEhQo (25m))
- [Playing with time series data in python](https://towardsdatascience.com/playing-with-time-series-data-in-python-959e2485bff8?source=---------45---------------------)
- [Presentation: An Introduction to Time Series Forecasting with Python](https://www.researchgate.net/publication/324889271_An_Introduction_to_Time_Series_Forecasting_with_Python)
- Time Series Forecasting with PyCaret Regression Module: [Medium](https://towardsdatascience.com/time-series-forecasting-with-pycaret-regression-module-237b703a0c63) | [Linkedin](https://www.linkedin.com/posts/profile-moez_time-series-forecasting-with-pycaret-regression-activity-6792794575539879936-Qv6E)
- [Multiple Time Series Forecasting with PyCaret](https://towardsdatascience.com/multiple-time-series-forecasting-with-pycaret-bc0a779a22fe)
- [📢 Announcing PyCaret’s New Time Series Module](https://towardsdatascience.com/announcing-pycarets-new-time-series-module-b6e724d4636c?source=search_post---------8)
- [New Time Series with PyCaret](https://towardsdatascience.com/new-time-series-with-pycaret-4e8ce347556a?source=search_post)
- [Understanding ARIMA Models using PyCaret’s Time Series Module — Part 1](https://towardsdatascience.com/understanding-arima-models-using-pycarets-time-series-module-part-1-692e10ca02f2?source=search_post)
- [Understanding ARIMA Models using PyCaret’s Time Series Module — Part2](https://towardsdatascience.com/understanding-arima-models-using-pycarets-time-series-module-part2-308ea7bfecf6?source=search_post)
- [A Practical Guide to ARIMA Models using PyCaret — Part 3](https://towardsdatascience.com/a-practical-guide-to-arima-models-using-pycaret-part-3-823abb5359a7?source=search_post)
- [PyCaret Time Series Module Architecture Overview](https://towardsdatascience.com/pycaret-time-series-module-architecture-overview-57336a2f39c7?source=search_post)
- [Combining PyCaret and TimeMachines for Time-Series Prediction](https://medium.com/@microprediction/combining-pycaret-and-timemachines-for-time-series-prediction-a4d456e47cd9?source=search_post)
- [Pycaret + Timeseries related articles on Medium](https://medium.com/search?q=pycaret%20timeseries)
- [One of the strength of Deep Auto-Regressive (DeepAR) models is handling of Multi Time Series in a simple and efficient way](https://www.linkedin.com/posts/srivatsan-srinivasan-b8131b_datascience-ml-machinelearning-activity-6730464577127092224-T8-Q)
- [Time series analysis discussion on Analytics Vidhya](https://discuss.analyticsvidhya.com/t/time-series-analysis/67474)
- [In Time series model one has to master lot of concepts Stationary, Trend, Trend Stationary, Additive and Multiplicative seasonality, detrending among others](https://www.linkedin.com/posts/srivatsan-srinivasan-b8131b_datascience-machinelearning-ml-activity-6684306319253626880-R2Wm)
- [Book (free): Introduction toTime Series and Forecasting, Second Edition by Peter J. Brockwell and Richard A. Davis](http://home.iitj.ac.in/~parmod/document/introduction%20time%20series.pdf)
- [Book (paid): Introduction to Time Series Forecasting With Python](https://machinelearningmastery.com/introduction-to-time-series-forecasting-with-python/)
- Time Series Data Analysis: [post](https://www.linkedin.com/posts/srivatsan-srinivasan-b8131b_datascience-machinelearning-ml-activity-6679602339004981249-HNG_] | [Videos](https://www.youtube.com/channel/UCwBs8TLOogwyGd0GxHCp-Dw/search?query=timeseries)
- [Time Series Analysis (TSA) in Python - Linear Models to GARCH](http://www.blackarbs.com/blog/time-series-analysis-in-python-linear-models-to-garch/11/1/2016)


## Classification

- [A Hands-On Introduction to Time Series Classification (with Python Code)](https://www.analyticsvidhya.com/blog/2019/01/introduction-time-series-classification/)


## Feature engineering

- [6 Powerful Feature Engineering Techniques For Time Series Data (using Python)](https://www.analyticsvidhya.com/blog/2019/12/6-powerful-feature-engineering-techniques-time-series/)

## ES-RNN

[ES_RNN - a hybrid Exponential Smoothing/Recurrent NN method that won M4 Forecasting Competition](https://github.com/slaweks17/ES_RNN)
[Fast ES-RNN: A GPU Implementation of the ES-RNN Algorithm](https://www.semanticscholar.org/paper/Fast-ES-RNN%3A-A-GPU-Implementation-of-the-ES-RNN-Redd-Khin/795f97edc24e2703f15da99f9187d654eabcfa0e)
[Fast ES-RNN: A GPU Implementation of the ES-RNN Algorithm](https://deepai.org/publication/fast-es-rnn-a-gpu-implementation-of-the-es-rnn-algorithm)

## WaveNet

[WaveNet: A generative model for raw audio](https://deepmind.com/blog/wavenet-generative-model-raw-audio/)
[WaveNet and other synthetic voices](https://cloud.google.com/text-to-speech/docs/wavenet)
[A TensorFlow implementation of DeepMind's WaveNet paper](https://github.com/ibab/tensorflow-wavenet)

## DeepAR

[DeepAR](https://www.deepar.ai/)
[DeepAR Forecasting Algorithm](https://docs.aws.amazon.com/sagemaker/latest/dg/deepar.html)
[Prophet vs DeepAR: Forecasting Food Demand](https://towardsdatascience.com/prophet-vs-deepar-forecasting-food-demand-2fdebfb8d282)

## Methods: ARMA/ARIMA/SARIMA and others

- [(Video) Time Series Forecasting Theory | AR, MA, ARMA, ARIMA | Data Science](https://www.youtube.com/watch?v=Aw77aMLj9uM (53m))
- [Introduction to ARMA Time Series Models – Simplified](https://www.analyticsvidhya.com/blog/2015/03/introduction-auto-regression-moving-average-time-series/)
- [Framework and Applications of ARIMA time series models](https://www.analyticsvidhya.com/blog/2015/03/framework-application-build-arima-model/)
- [ARIMA modeling and forecasting: Time Series in Python Part 2](https://tutorials.datasciencedojo.com/arima-model-time-series-python/)
- [Build High Performance Time Series Models using Auto ARIMA in Python and R](https://www.analyticsvidhya.com/blog/2018/08/auto-arima-time-series-modeling-python-r/)
- [ARIMA Model – Complete Guide to Time Series Forecasting in Python](https://www.machinelearningplus.com/time-series/arima-model-time-series-forecasting-python/)
- [A Guide to Time Series Forecasting with ARIMA in Python 3](https://www.digitalocean.com/community/tutorials/a-guide-to-time-series-forecasting-with-arima-in-python-3)
- [A Gentle Introduction to SARIMA for Time Series Forecasting in Python](https://machinelearningmastery.com/sarima-for-time-series-forecasting-in-python/)
- [7 methods to perform Time Series forecasting (with Python codes)](https://www.analyticsvidhya.com/blog/2018/02/time-series-forecasting-methods/)
- [11 Classical Time Series Forecasting Methods in Python (Cheat Sheet)](https://machinelearningmastery.com/time-series-forecasting-methods-in-python-cheat-sheet/)
- [List of Time Series Method](https://www.linkedin.com/posts/nabihbawazir_list-of-time-series-method-for-business-activity-6603565390427709440-HnS-)
- [Implement an ARIMA model using statsmodels (Python)](https://www.linkedin.com/posts/data-science-central_implement-an-arima-model-using-statsmodels-activity-6628365239232589825-GRHk)
- [Self aware streaming with ARIMA (Timeseries models)](https://www.linkedin.com/posts/isaacbaum_self-aware-streaming-activity-6626980492765904896-5-_a)
- [When modeling time series with ARIMA one needs to define the order of AR](https://www.linkedin.com/posts/srivatsan-srinivasan-b8131b_datascience-machinelearning-ml-activity-6685537800835743744-z3lM)

## Non-stationary Time-series

- [A Gentle Introduction to Handling a Non-Stationary Time Series in Python](https://www.analyticsvidhya.com/blog/2018/09/non-stationary-time-series-python/)

## Look-ahead bias

- [Avoiding Look Ahead Bias in Time Series Modelling](https://www.linkedin.com/posts/data-science-central_avoiding-look-ahead-bias-in-time-series-modelling-activity-6628076836083511297-GLEm)

## Generalized Additive Models

- [Time Series Analysis with Generalized Additive Models](https://www.linkedin.com/posts/data-science-central_time-series-analysis-with-generalized-additive-activity-6607043238882787328-tBI6)

## Courses / Tutorials / Workshops

- [A Complete Tutorial on Time Series Modeling in R](https://www.analyticsvidhya.com/blog/2015/12/complete-tutorial-time-series-modeling/)
- [(Video) Modern Time Series Analysis | SciPy 2019 Tutorial | Aileen Nielsen](https://www.youtube.com/watch?v=v5ijNXvlC5A (3hr 12m))
    - https://www.scipy2019.scipy.org/tutorial-participant-instructions
    - [Git repo with notes](https://github.com/theJollySin/scipy_con_2019/blob/master/modern_time_series_analysis/README.md)
    - [Aileen's git repo](https://github.com/AileenNielsen/TimeSeriesAnalysisWithPython)
    - [Google Bayesian Time-series package](https://opensource.googleblog.com/2014/09/causalimpact-new-open-source-package.html): [Python](https://pypi.org/project/pycausalimpact/) | [R](https://google.github.io/CausalImpact/)
- [Aileen Nielsen - Time Series Analysis - PyCon 2017](https://www.youtube.com/watch?v=zmfe2RaX-14 (3hr 11m))
- [(Video) Time Series Analysis with Python Intermediate | SciPy 2016 Tutorial | Aileen Nielsen (3hr 3m)](https://www.youtube.com/watch?v=JNfxr4BQrLk)
- [Long Range Correlation in time-series (tutorial and case study)](https://www.datasciencecentral.com/profiles/blogs/long-range-correlation-in-time-series-tutorial-and-case-study)
- [Time Series Analysis with Python —With Applications of Machine Learning Algorithms](http://www.hilpisch.com/hydpy_workshop.pdf)
- [Time Series Forecasting in Minutes](https://tutorials.datasciencedojo.com/time-series-forecasting-minutes/)
- [PyCon 2017 tutorial on time series analysis ](https://github.com/robmarkcole/pycon_time_series)
- [Time Series in Python Part 1: Read and Transform Your Data](https://tutorials.datasciencedojo.com/time-series-python-reading-data/)
- [ARIMA modeling and forecasting: Time Series in Python Part 2](https://tutorials.datasciencedojo.com/arima-model-time-series-python/)
- [Mean Absolute Error for Forecast Evaluation: Time Series in Python Part 3](https://tutorials.datasciencedojo.com/mean-absolute-error-forecast/)
- [Time Series Analysis using Python workshop](https://github.com/rouseguy/TimeSeriesAnalysiswithPython)
- [Based on Deep Learning for Time-Series Forecasting Course](https://github.com/kmfullerton/Deep_Learning_Time_Series)
- [Deep-Learning-for-Time-Series-Forecasting](https://github.com/Geo-Joy/Deep-Learning-for-Time-Series-Forecasting)
- [How to Get Started with Deep Learning for Time Series Forecasting (7-Day Mini-Course)](https://www.aiproblog.com/index.php/2018/09/03/how-to-get-started-with-deep-learning-for-time-series-forecasting-7-day-mini-course/)
- [Time Series Modelling and Analysis](https://www.youtube.com/playlist?list=PL3N9eeOlCrP5cK0QRQxeJd6GrQvhAtpBK)

## Applied Time series

- [(Video) Jeffrey Yau: Applied Time Series Econometrics in Python and R | PyData San Francisco 2016](https://www.youtube.com/watch?v=tJ-O3hk1vRw (1hr 39m))

## Gaussian Process

- [(Video) Dr. Juan Orduz: Gaussian Process for Time Series Analysis | PyData Berlin 2019](https://www.youtube.com/watch?v=0p_6RzhSZEc (30m))

## Neural Networks & Deep Learning

- [(Video) Dafne van Kuppevelt | Deep learning for time series made easy](https://www.youtube.com/watch?v=9X_4i7zdSY8 (22m))
- [(Video) 1D Convolutional Neural Networks for Time Series Modeling - Nathan Janos, Jeff Roach](https://www.youtube.com/watch?v=nMkqWxMjWzg (35m))
- [How to Develop Convolutional Neural Network Models for Time Series ind_forecasting-uncertainty-at-airbnb_confirm](https://machinelearningmastery.com/how-to-develop-convolutional-neural-network-models-for-time-series-forecasting/)
- [(Video) Igor Gotlibovych: Deep Learning and Time Series Forecasting for Smarter Energy | PyData London 2019](https://www.youtube.com/watch?v=p6mKFs6HVlg (40m))
- [Based on Deep Learning for Time-Series Forecasting Course](https://github.com/kmfullerton/Deep_Learning_Time_Series)
- [Deep-Learning-for-Time-Series-Forecasting](https://github.com/Geo-Joy/Deep-Learning-for-Time-Series-Forecasting)
- [How to Get Started with Deep Learning for Time Series Forecasting (7-Day Mini-Course)](https://www.aiproblog.com/index.php/2018/09/03/how-to-get-started-with-deep-learning-for-time-series-forecasting-7-day-mini-course/)
- [The Promise of Recurrent Neural Networks for Time Series Forecasting](https://machinelearningmastery.com/promise-recurrent-neural-networks-time-series-forecasting/)
- [Google Stock Price Time Series Prediction with RNN(LSTM) using pytorch from Scratch](https://in.pycon.org/cfp/2018/proposals/google-stock-price-time-series-prediction-with-rnnlstm-using-pytorch-from-scratch~b67Rd/)
- [Outstanding results predicting Apple Stock with Continual ML using Global News (with Python)](https://towardsdatascience.com/making-a-continual-ml-pipeline-to-predict-apple-stock-with-global-news-python-90e5d6610b21)
- [Time Series and Decentralized Networks - Upcoming free webinar http://bit.ly/3b40pKL](https://www.linkedin.com/posts/data-science-central_time-series-and-decentralized-networks-activity-6647291431524319232-zbSy)
- [How to Develop Deep Learning Models for Univariate Time Series Forecasting](https://machinelearningmastery.com/how-to-develop-deep-learning-models-for-univariate-time-series-forecasting/)
- [How to Develop Multilayer Perceptron Models for Time Series Forecasting](https://machinelearningmastery.com/how-to-develop-multilayer-perceptron-models-for-time-series-forecasting/)


## Forecasting

- [11 Classical Time Series Forecasting Methods in Python (Cheat Sheet)](https://www.linkedin.com/feed/update/urn:li:activity:6717984798209654784/)
- [How to Grid Search Deep Learning Models for Time Series Forecasting](https://machinelearningmastery.com/how-to-grid-search-deep-learning-models-for-time-series-forecasting/)
- [Forecasting the weather with neural ODEs](https://www.linkedin.com/posts/montrealai_artificialintelligence-machinelearning-neuralordinarydifferentialequations-activity-6685542038953308160-eoFI)
- [Love this free book on forecasting - check it out here: https://otexts.com/fpp2/](https://www.linkedin.com/posts/kylemckiou_machinelearning-stats-statistics-activity-6682632348204449792-FvYE)
- [Trending post is Time Series Forecasting using @TensorFlow.](https://www.linkedin.com/posts/madewithml_time-series-forecasting-made-with-ml-activity-6694237555669516289-dxrf)
- [Forecasting versus Prediction](https://www.datascienceblog.net/post/machine-learning/forecasting_vs_prediction/)
- [Preprocessing for Time Series Forecasting](https://medium.com/analytics-vidhya/preprocessing-for-time-series-forecasting-3a331dbfb9c2)
- [A comprehensive beginner’s guide to create a Time Series Forecast (with Codes in Python and R)](https://www.analyticsvidhya.com/blog/2016/02/time-series-forecasting-codes-python/)
- [What Is Time Series Forecasting?](https://machinelearningmastery.com/time-series-forecasting/)
- [Time Series Forecasting as Supervised Learning](https://machinelearningmastery.com/time-series-forecasting-supervised-learning/)
- [How to Convert a Time Series to a Supervised Learning Problem in Python](https://machinelearningmastery.com/convert-time-series-supervised-learning-problem-python/)
- [Autoregression Models for Time Series Forecasting With Python](https://machinelearningmastery.com/autoregression-models-time-series-forecasting-python/)
- [Time Series Forecasting with Python 7-Day Mini-Course](https://machinelearningmastery.com/time-series-forecasting-python-mini-course/)
- [A Gentle Introduction to Exponential Smoothing for Time Series Forecasting in Python](https://machinelearningmastery.com/exponential-smoothing-for-time-series-forecasting-in-python/)
- [How to Grid Search Triple Exponential Smoothing for Time Series Forecasting in Python](https://machinelearningmastery.com/how-to-grid-search-triple-exponential-smoothing-for-time-series-forecasting-in-python/)
- [How to Develop LSTM Models for Time Series Forecasting](https://machinelearningmastery.com/how-to-develop-lstm-models-for-time-series-forecasting/)
- [An End-to-End Project on Time Series Analysis and Forecasting with Python](https://towardsdatascience.com/an-end-to-end-project-on-time-series-analysis-and-forecasting-with-python-4835e6bf050b)
- [Forecasting Time Series Data using Autoregression](https://pythondata.com/forecasting-time-series-autoregression/)
- [(Video) Reliably forecasting time-series in real-time - Charles Masson](https://www.youtube.com/watch?v=0zpg9ODE6Ww (41m))
- [(Video) Two Effective Algorithms for Time Series Forecasting](https://www.youtube.com/watch?v=VYpAodcdFfA (14m))
- [(Video) Time Series Analysis in Python | Time Series Forecasting | Data Science with Python | Edureka](https://www.youtube.com/watch?v=e8Yw4alG16Q (38m))
- [(Video) Time Series Forecasting Theory | AR, MA, ARMA, ARIMA | Data Science](https://www.youtube.com/watch?v=Aw77aMLj9uM (53m))
- [(Video) Pranav Bahl, Jonathan Stacks - Robust Automated Forecasting in Python and R](https://www.youtube.com/watch?v=pl6u8PC_1Ns (42m))
- [(Video) About Practice Problem: Time Series Analysis](https://datahack.analyticsvidhya.com/contest/practice-problem-time-series-2/)
- [Encoding Time Series as Images](https://medium.com/analytics-vidhya/encoding-time-series-as-images-b043becbdbf3)
- [A Multivariate Time Series Guide to Forecasting and Modeling (with Python codes)](https://www.analyticsvidhya.com/blog/2018/09/multivariate-time-series-guide-forecasting-modeling-python-codes/)
- [Multivariate Time Series Forecasting with LSTMs in Keras](https://machinelearningmastery.com/multivariate-time-series-forecasting-lstms-keras/)
- [When I started time series videos there were lot of request that came in for Multivariate Time Series modeling](https://www.linkedin.com/posts/srivatsan-srinivasan-b8131b_datascience-machinelearning-ml-activity-6687574768889290752-hpso)
- [(Video) Tamara Louie: Applying Statistical Modeling & Machine Learning to Perform Time-Series Forecasting](https://www.youtube.com/watch?v=JntA9XaTebs (1hr 26m))
- [(Video) Jeffrey Yau: Time Series Forecasting using Statistical and Machine Learning Models | PyData NYC 2017](https://www.youtube.com/watch?v=_vQ0W_qXMxk (32m))
- [(Video) Igor Gotlibovych: Deep Learning and Time Series Forecasting for Smarter Energy | PyData London 2019](https://www.youtube.com/watch?v=p6mKFs6HVlg (40m))
- [Selecting Forecasting Methods in Data Science](https://www.linkedin.com/posts/vincentg_selecting-forecasting-methods-in-data-science-activity-6637418894577459200-NXel)
- Multi-step Time Series Forecasting with Machine Learning for Electricity Usage: [Part 1](https://machinelearningmastery.com/multi-step-time-series-forecasting-with-machine-learning-models-for-household-electricity-consumption/) [Part 2](https://www.linkedin.com/posts/jasonbrownlee_multi-step-time-series-forecasting-with-machine-activity-6640791155732807680-IdDZ)
- [Probabilistic Forecasting: Learning Uncertainty](https://www.datasciencecentral.com/profiles/blogs/probabilistic-forecasting-learning-uncertainty)
- [GluonTS: Probabilistic time series forecasting](https://www.kaggle.com/c/m5-forecasting-uncertainty/discussion/133762)
- [Three Approaches to Predicting Uncertainty](https://www.kaggle.com/c/m5-forecasting-uncertainty/discussion/133613)
- [Aggregated resources on the topic "uncertainty"](https://www.kaggle.com/c/m5-forecasting-uncertainty/discussion/155085)
- [11 Classical Time Series Forecasting Methods in Python (Cheat Sheet)](https://machinelearningmastery.com/time-series-forecasting-methods-in-python-cheat-sheet/)
- [Correlation, causation and forecasting](https://otexts.com/fpp2/causality.html)
- [A miscellaneous repo where @clone95 put studies notes on time series data analysis and forecasting](https://github.com/clone95/time-series-misc)
- [Tamara Louie: Applying Statistical Modeling & Machine Learning to Perform Time-Series Forecasting](https://www.youtube.com/watch?v=JntA9XaTebs)
- [How to Grid Search SARIMA Hyperparameters for Time Series Forecasting](https://machinelearningmastery.com/how-to-grid-search-sarima-model-hyperparameters-for-time-series-forecasting-in-python/)

## Forecasting using Prophet

- [Generate Quick and Accurate Time Series Forecasts using Facebook’s Prophet (with Python & R codes)](https://www.analyticsvidhya.com/blog/2018/05/generate-accurate-forecasts-facebook-prophet-python-r/)
- [A Guide to Time Series Forecasting with Prophet in Python 3](https://www.digitalocean.com/community/tutorials/a-guide-to-time-series-forecasting-with-prophet-in-python-3) 
- [A Quick Start of Time Series Forecasting with a Practical Example using FB Prophet](https://towardsdatascience.com/a-quick-start-of-time-series-forecasting-with-a-practical-example-using-fb-prophet-31c4447a2274)
- [(Video) Mahan Hosseinzadeh - Prophet at scale to tune & forecast time series at Spotify - PyData London 2019](https://www.youtube.com/watch?v=fegS34ItKcI (38m))

## Prediction

- [Forecasting versus Prediction](https://www.datascienceblog.net/post/machine-learning/forecasting_vs_prediction/)
- [SO: Time Series Prediction using LSTM](https://stackoverflow.com/questions/43793565/time-series-prediction-using-lstm)
- [(Video) Joe Jevnik - A Worked Example of Using Neural Networks for Time Series Prediction](https://www.youtube.com/watch?v=hAlGqT3Xpus (35m))
- [(Video) Build A Stock Prediction Program](https://www.youtube.com/watch?v=EYnC4ACIt2g-)
- [Stock Prices Prediction Using Machine Learning and Deep Learning Techniques (with Python codes)](https://www.analyticsvidhya.com/blog/2018/10/predicting-stock-price-machine-learningnd-deep-learning-techniques-python/)
- [Stock price predictions using Python](https://towardsdatascience.com/stock-prediction-in-python-b66555171a2)
- [Master’s Thesis: Time Series Data Prediction and Analysis](https://dspace.cvut.cz/bitstream/handle/10467/70524/F3-DP-2017-Ostashchuk-Oleg-Prediction%20Time%20Series%20Data%20Analysis.pdf)
- [App that will plot a single time-series sensor history and make predictions using Prophet](https://github.com/robmarkcole/HASS-time-series-prediction)
- [Cassandra NoSQL + Bokeh + Prophet for stock time series analysis](https://github.com/robmarkcole/CassandraTime)
- [How to make time-data cyclical for prediction?](https://www.linkedin.com/posts/vincentg_how-to-make-time-data-cyclical-for-prediction-activity-6648404528720867329-azaJ)
- [Book (paid): Advances in Financial Machine Learning by Marcos Lopez de Prado](https://www.amazon.co.uk/Advances-Financial-Machine-Learning-Marcos/dp/1119482089?SubscriptionId=AKIAILSHYYTFIVPWUY6Q&tag=duckduckgo-brave-uk-21&linkCode=xm2&camp=2025&creative=165953&creativeASIN=1119482089) (also available on [Safari Books](https://my.safaribooksonline.com/login))

## Trend estimation / trend analysis

- [(Video) Bugra Akyildiz: Trend Estimation in Time Series Signals](https://www.youtube.com/watch?v=likDxYXhNQY (43m))
- [Trend Analysis of Fragmented Time Series: Hypothesis Testing Based Adaptive Spline Filtering Method](https://www.linkedin.com/posts/data-science-central_trend-analysis-of-fragmented-time-series-activity-6610697317018292224--zak)

## Notebooks

- [Fuzzy Time series notebook](https://colab.research.google.com/drive/1S1QSZfO3YPVr022nwqJC5bEJvrXbqS_A)
- [Python Data Science Handbook: Time series notebook](https://github.com/jakevdp/PythonDataScienceHandbook/blob/master/notebooks/03.11-Working-with-Time-Series.ipynb)
- [Time Series in Python notebook](https://github.com/advaitsave/Introduction-to-Time-Series-forecasting-Python/blob/master/Time%20Series%20in%20Python.ipynb)
- [A modern Time Series tutorial (Kaggle Kernel)](https://www.kaggle.com/rohanrao/a-modern-time-series-tutorial)
- [Different analysis we typically do on data that has time element to it like lag plot, auto correlation plot and others](https://youtu.be/3sH1kisAK9s](https://github.com/srivatsan88/End-to-End-Time-Series/blob/master/Timeseries_Data_analysis.ipynb)

## Misc

- [(Video) Aileen Nielsen - Irregular time series and how to whip them](https://www.youtube.com/watch?v=E4NMZyfao2c (29m))
- [(Video) Pydata Time-series talks](https://www.youtube.com/results?search_query=pydata+time+series)
- [Videos by Ashrith Barthur on Security, Time-series and Anomaly detection](https://www.youtube.com/results?search_query=h2o+ashrith)
- [Time Series Anomaly Detection with PyCaret](https://towardsdatascience.com/time-series-anomaly-detection-with-pycaret-706a6e2b2427)
- [Outlier detection with time series data mining](https://www.linkedin.com/posts/data-science-central_outlier-detection-with-time-series-data-mining-activity-6652403632190877696-8wVh)
- [Financial: time series](https://cloud.google.com/solutions/machine-learning-with-financial-time-series-data)
- [Driverless AI's time-series support](http://docs.h2o.ai/driverless-ai/latest-stable/docs/userguide/time-series.html)
- [Time Series with Driverless AI - Marios Michailidis and Mathias Müller - H2O AI World London 2018](https://www.youtube.com/watch?v=EGVY7-Spv8E)
- [My team won $20,000 and 1st place in Kaggle's Earthquake Prediction competition](https://www.linkedin.com/pulse/my-team-won-20000-1st-place-kaggles-earthquake-corey-levinson/?trackingId=yAsezLzPTDyCuR6z0e4a1g%3D%3D)
  - [Discussions on Kaggle](https://www.kaggle.com/c/LANL-Earthquake-Prediction/discussion/94390)
  - [Kaggle Kernel](https://www.kaggle.com/dkaraflos/1-geomean-nn-and-6featlgbm-2-259-private-lb)
- [A small library to backtest timeseries data](https://github.com/EricSchles/backtester)
- [Tsaug - a python package for time series augmentation from Arundo Analytics (Tailai Wen and Roy K. )](https://www.linkedin.com/posts/madewithml_tsaug-made-with-ml-activity-6698561289607880705-DKoX)
- VAE-SNE: a deep generative model for dimensionality reduction and clustering • Usefull for unsupervised action recognition to detect and classify repeated motifs of stereotyped behavior in high-dimensional timeseries data: [GitHub](https://lnkd.in/gN9qvDK) | [Paper](https://lnkd.in/gawkgNr](https://www.linkedin.com/posts/philipvollet_machinelearning-datascience-bioinformatics-activity-6690327432823742464-dI7M) 
- [Webinar on Time Series by Srivatsan Srinivasan](https://docs.google.com/presentation/d/1yGcBUsh0RJb4ap3LXMa_1h_E_xeJ_HEO8SAtFlj_RrY/edit#slide=id.p)
- [Timeseries Beginner training](https://github.com/jeffrey-yau/Pearson-TSA-Training-Beginner)
- [@clone95's repo with studies on Exploratory Data Analysis, Time Series forecasting, and Data Manipulation with popular Python Libraries](https://github.com/clone95/Prices-of-Avocados)
- [Time-series on Analytics Vidhya](https://www.analyticsvidhya.com/blog/category/time-series/)
- [Time-series Forecasting on Analytics Vidhya](https://www.analyticsvidhya.com/blog/category/time-series-forecasting/)
- **[And many more Time-series posts on MachineLearningMastery.com](https://machinelearningmastery.com/?s=time+series&post_type=post&submit=Search)**

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../CONTRIBUTING.md) guidelines, also have a read about our [licensing](../LICENSE.md) policy.

---

Back to [Time-series/Anomaly detection page](./README.md)
Back to [main page (table of contents)](../README.md)