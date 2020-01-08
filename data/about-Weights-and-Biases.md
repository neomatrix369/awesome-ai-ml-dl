## Weights & Biases

- [https://www.wandb.com/](https://www.wandb.com/)
- W&B is a key piece of our fast-paced, cutting-edge, large-scale research workflow: great flexibility, performance, and user experience.
- Experiment tracking for deep learning
- Instrument training scripts
- Stages covered: only from Model training to deploy (run multiple experiments, track and look at the data visualisations - only helps track, and use the info to plot graphs and make your decisions)
- Pros:
  - Supports model execution and tracking of the execution
  - Gathers good stats / metrics to make sound decisions after or during execution of experiments
  - Has support for comparisons of experiments (and models) and performances
  - Tracks the best model producing during experiments execution
  - Supports multiple python frameworks (keras, tensorflow, pytorch)
  - Getting started with tool is really easy and great way to integrate hooks into our experiment code
  - Very good UX, docs and site layout, user-friendly
- Cons:
  - Does not support or have tooling for stages before experiment execution (i.e. data cleaning, visualisation, data validation, feature extraction)
  - Not sure if they provide infrastructure on which we can run our experiments
- Installation or getting started
  - https://docs.wandb.com/docs/started.html
- Pricing & features: https://www.wandb.com/pricing
- Documentations
  - https://docs.wandb.com/docs/started.html
- Examples
  - https://docs.wandb.com/docs/examples.html
- Code & concepts
  - [Code snippets](./wandb/code-snippets.py)
  - [Quick and Dirty CNN](./wandb/Quick-and-Dirty-CNN.py)
  - [Activation Function](./wandb/Activation-Function.png)
- Videos
  - Tutorial: https://www.wandb.com/classes/intro/overview
- Additional resources
  - [Error caused by missing input_shape in your first layer](https://stackoverflow.com/questions/52690293/tensorflow-attributeerror-nonetype-object-has-no-attribute-original-name-sc)
  - [Bloomberg summary colab notebook](https://colab.research.google.com/drive/1lfLR9WRzmjOMmnNmePys4-8WNfZ5xC90#scrollTo=wbjXyjFRaT1d)
  - https://talktotransformer.com/ - Adam Daniel King's implementation of GPT-2 on the back of the PyTorch version
  - ...for more [see this](./wandb/More-resources.md)

---

- [ ] [AI/ML/DL Library / Package / Framework: applicable]
- [ ] [Inexpensive crowd-sourced infrastructure sharing: applicable]
- [ ] [Data cleaning: manual / no tools available] 
- [ ] [Data querying: manual / tools available] 
- [ ] [Data analytics: manual / tools available]
- [ ] [Data visualisation: manual / tools available] 
- [ ] [Data validation: manual / no tools available] 
- [ ] [Feature extraction: manual / no tools available] 
- [x] **[Model creation: available]**
- [x] **[Execute experiments: available]**
- [x] **[Track experiments: available]**
- [x] **[Hyper parameter tuning: available]**
- [x] **[Model saving: available]**
- [x] **[Visualisations: available]**

Back to [Programs and Tools](./programs-and-tools.md#programs-and-tools). <br/>
Back to [Data page](./README.md#data).