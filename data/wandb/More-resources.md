## More Resources

### Lecture, slide and code links

- Lectures: https://www.wandb.com/classes/intro/overview
- Code
    - https://github.com/lukas/ml-class 
        - https://github.com/lukas/ml-class/scikit/test-algorithm-cross-validation-dummy.py
        - https://github.com/lukas/ml-class/blob/master/examples/notebooks/Lesson-4-Evaluating-Classifiers.ipynb
    - https://github.com/lukas/vision-project
    - https://github.com/mjhamiltonus/ml-class (all modules with notes)
- Hub sign-in page: https://hub.wandb.us/login
- Slack channel: https://bit.ly/wandb-forum
- Setup instructions: https://bit.ly/wbemotion or http://bit.ly/hub-setup
- Slides: https://storage.googleapis.com/wandb/Bloomberg%20Class%201.pdf
- Cheatsheets
    - [ML Class Oct 2018 - CHEATSHEET.md](https://gist.github.com/vanpelt/b52f6f5360be626d2c23189d513f94de)
        - https://gist.github.com/vanpelt/b52f6f5360be626d2c23189d513f94de#file-cheatsheet-md
        - https://gist.github.com/vanpelt/b52f6f5360be626d2c23189d513f94de#saving-your-progress-optional
- W&B projects
    - https://app.wandb.ai/bloomberg-class/imdb-classifier 
    - https://app.wandb.ai/dronedeploy/dronedeploy-aerial-segmentation/benchmark
    - https://app.wandb.ai/mlclass/timeseries-nov1/runs/7bu2q1uv
    - https://app.wandb.ai/qualcomm/timeseries-dec3/runs/kyphj85u
    - https://app.wandb.ai/qualcomm/timeseries-sep13/runs/a3sfobyy

### Books to train your LSTM on

- [Top 100 - Project Gutenberg, 33000+ free ebooks online](http://www.gutenberg.org/browse/scores/top)
- Code: https://github.com/lukas/ml-class/tree/master/examples/lstm/text-gen
- [Complete works of Shakespeare](http://shakespeare.mit.edu/)
- [An interesting dataset](http://www.trumptwitterarchive.com/archive/none/tfff/1-1-2015_11-1-2018)
- [Tab-delimited Bilingual Sentence Pairs](http://www.manythings.org/anki/)

### Bloomberg and LSTM classes (slides)

- [Bloomberg Class 1](https://wb-ml.slack.com/files/UN2SL6G7Q/FNR5RJ2MS/bloomberg_class_1.pdf)
- [Bloomberg Class 2](https://wb-ml.slack.com/files/UN2SL6G7Q/FNE9193U0/bloomberg_class_2.pdf)
- [Bloomberg Class 3](https://wb-ml.slack.com/files/UN2SL6G7Q/FNE3Q7NN7/bloomberg_class_3.pdf)
- [Bloomberg Class 4 & 5](https://wb-ml.slack.com/files/UN2SL6G7Q/FNZQU6FE1/bloomberg_class_4.pdf)
- [Bloomberg Class 6](https://wb-ml.slack.com/files/UCBGFQ0RJ/FPG96CLTX/bloomberg_class_6.pdf)
- [Bloomberg Class 7](https://wb-ml.slack.com/files/UN2SL6G7Q/FPQQXNX5E/bloomberg_class_7.pdf)
- [Bloomberg Class 8](https://wb-ml.slack.com/files/UCAGCLW48/FPZ8MGYP6/bloomberg_class_8.pdf)
- [Bloomberg Class 8 - audio processing](https://wb-ml.slack.com/files/UCAGCLW48/FQARW1A30/class_8_audio_processing.pdf)
- [Bloomberg Class 9](https://wb-ml.slack.com/files/UCAGCLW48/FQHND8VJR/class_9_concept_review.pdf)
- [ML Class LSTM: Apr 2019](https://storage.googleapis.com/wandb/ML%20Class%20LSTM%20-%20Apr%2030%20-%202019.pdf)
- [ML Class LSTM: Nov](https://storage.googleapis.com/wandb-production.appspot.com/mlclass/ML%20Class%20LSTM%20-%20Nov1%20.pdf)
- [ML Class LSTM - Dec 3](https://drive.google.com/open?id=1gJvL9Nl67qQMS0pv9IscwwPrrofsmtY7)

### Questions and answers

Q: How do you know what a good learning rate is?

A: To find the best learning rate, start with a very low value (10^-5) and slowly multiply the rate by a constant (e.g. 10) until you hit a very high value (e.g. 1). So you'll try 0.00001, …, 0.01, 0.1, 1.  The best learning rate is usually half of the learning rate that causes the model to diverge. I’d also recommend using the Learning Rate finder proposed by Leslie Smith. It's an excellent way to find a good learning rate for most gradient optimizers (most variants of SGD) and works with most network architectures. https://arxiv.org/abs/1506.01186

Q: What is the meaning of Bottleneck features?

A: It’s storing the output of the second to last layer of the network you’re transferring from and training a new network using it as input.

So in usual, when we do transfer learning we re-train the last few layers but when we save bottleneck features, we only re-train the last 1 layer? Why is it called "bottleneck" though? The word is typically used when something is a slow moving part of a process, right?

Training the last few layers is called fine tuning. Bottleneck features are called bottleneck because they are generally smaller than the input features.  So using the network to generate them is like putting them through a bottleneck.

Q: I'm using the network below for time series. The numpy array X_scl_re has shape (n_samples, timesteps, n_features). In my case timesteps=1. My question is when is tilmestep greater than 1 and what does this mean?

A: In your example timesteps would be the number of sequences to process.  Increasing this would allow the network to see longer range patterns.  You can think of it as the amount of time the network get's to look back to.
Or in the case of the IMDB dataset the number of words the network get's to see to make a decision.


### Misc resources

- [Error caused by missing input_shape in your first layer](https://stackoverflow.com/questions/52690293/tensorflow-attributeerror-nonetype-object-has-no-attribute-original-name-sc)
- [Bloomberg summary colab notebook](https://colab.research.google.com/drive/1lfLR9WRzmjOMmnNmePys4-8WNfZ5xC90#scrollTo=wbjXyjFRaT1d)
- https://talktotransformer.com/ - Adam Daniel King's implementation of GPT-2 on the back of the PyTorch version
- [Automated Bug Triaging](http://bugtriage.mybluemix.net/#code)
- https://tensorspace.org/html/playground/lenet.html
- https://towardsdatascience.com/neural-network-architectures-156e5bad51ba
- https://jyothi-gupta.blogspot.com
- https://hackernoon.com/imagine-a-drunk-island-advice-for-finding-ai-use-cases-8d47495d4c3f
- https://github.com/jupyterlab/jupyterlab/issues/1146
