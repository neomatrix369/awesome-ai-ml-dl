# Cloud, DevOps, Infra

- [System / Infra](#system--infra)
- [Compute & Storage](#compute--storage)
- [Grid computing / Super computing](#grid-computing--super-computing)
- [Cloud services](#cloud-services)
- [Tools](#tools)
- [CPU](#cpu)
- [FPGA](#fpga)
- [GPU](#gpu)
- [TPU](#tpu)
- [IPU](#ipu)
- [Performance](#performance)
- [Contributing](#contributing)

## System / Infra

  - [serveo.net](http://serveo.net) - Serveo is an SSH server just for remote port forwarding. When a user connects to Serveo, they get a public URL that anybody can use to connect to their localhost server. See link for other SSH and related alternatives, useful to be able to serve resources across devices i.e. access GPU or other hardware accelerators from another device remotely. | [How to forward my local port to public using Serveo?](https://medium.com/@osanda.deshan/how-to-forward-my-local-port-to-public-using-serveo-4979f352a3bf) | [Serveo on GitHub](https://github.com/milio48/serveo)
  - [Inlets](https://github.com/alexellis/inlets) by [Alex Ellis](https://github.com/alexellis) | [Get started](https://github.com/alexellis/inlets#get-started) | [Video](https://www.youtube.com/watch?v=jrAqqe8N3q4&feature=youtu.be)

## Compute & Storage
  
  - [Cray Computers](https://www.cray.com/ai) | [Artificial Intelligence](https://www.cray.com/solutions/artificial-intelligence) | [Accel AI](https://www.cray.com/solutions/artificial-intelligence/cray-accel-ai) | [Cryp-em](https://www.cray.com/solutions/cryo-em) | [Autonomous Vehicles](https://www.cray.com/solutions/autonomous-vehicles) | [Geospatial AI](https://www.cray.com/solutions/geospatial-ai)
  - [GraphCore's IPU](README.md#ipu)
  - [Lambda Labs](https://lambdalabs.com/)
  - NGD Systems: [Technology](https://www.ngdsystems.com/technology) | [Solutions](https://www.ngdsystems.com/solutions) - High Compute Storage, Scalable Computational Storage [deadlink] | [NGD Systems: Ensuring AI Advancement with Intelligent Storage](https://www.insightssuccess.com/ngd-systems-ensuring-ai-advancement-with-intelligent-storage/)

## Grid computing / Super computing

- Grid Engine: [wikipedia](https://en.wikipedia.org/wiki/Univa_Grid_Engine) | [Univa website](http://www.univa.com/products/) | [Datasheet](http://www.univa.com/resources/files/univa-unisight-datasheet.pdf)
- [BOINC](https://boinc.berkeley.edu/) - High-Throughput Computing with BOINC | [Tech Docs](https://boinc.berkeley.edu/trac/wiki/ProjectMain) | [Download BOINC](https://boinc.berkeley.edu/download.php) | [GitHub](https://github.com/BOINC/boinc)
- [Cray Computers](https://www.cray.com/solutions/supercomputing-as-a-service) - Supercomputing as a Service

## Cloud services

  - [vast.ai](about-vast.ai.md) - GPU Sharing Economy. One simple interface to find the best cloud GPU rentals. Reduce cloud compute costs by 3X to 5X
  - [paperspace](https://www.paperspace.com/) - The first cloud built for the future. Powering next-generation applications and cloud ML/AI pipelines. Paperspace is built to scale with your team - pay as you go option for individuals.
  - [valohai](https://www.valohai.com/) | [docs](https://docs.valohai.com/) | [blogs](https://blog.valohai.com) | [GitHub](https://github.com/valohai) | [Videos](https://www.youtube.com/channel/UCiR8Fpv6jRNphaZ99PnIuFg) | [Showcase](https://valohai.com/showcase/) | [Slack](http://community-slack.valohai.com/) | [@valohaiai](https://twitter.com/@valohaiai) - Valohai is a machine learning platform. It runs your experiments in the cloud, tracks your experiment history and streamlines data science workflows. DEEP LEARNING MANAGEMENT PLATFORM. Machine Orchestration, Version Control and Pipeline Management for Deep Learning.
  - [Lambda Cloud GPU Instances](https://lambdalabs.com/service/gpu-cloud) - GPU Instances for Deep Learning & Machine Learning
  - [NavOps](http://www.univa.com/products/navops.php) - Cloud Migration for HPC | [Datasheet](http://www.univa.com/resources/files/univa-navops-launch-datasheet.pdf)
  - [Verne Global: HPC Cloud](https://verneglobal.com/solutions/hpc-cloud) | [NVidia DGX Ready](https://verneglobal.com/dgxready)
  - [Weights and Biases](https://wandb.com) | [Learn more about WandB](../data/about-Weights-and-Biases.md)

## Tools

  - [snakemake](https://snakemake.readthedocs.io/en/stable/) - The Snakemake workflow management system is a tool to create reproducible and scalable data analyses. [Slides](https://slides.com/johanneskoester/snakemake-talk-40min#) | [PyPi](https://pypi.org/project/snakemake/)
  - [plz](http://github.com/prodo-ai/plz) - Plz (pronounced "please") runs your jobs storing code, input, outputs and results so that they can be queried programmatically.
  - [valohai](https://www.valohai.com/) | [docs](https://docs.valohai.com/) | [blogs](https://blog.valohai.com) | [GitHub](https://github.com/valohai) | [Videos](https://www.youtube.com/channel/UCiR8Fpv6jRNphaZ99PnIuFg) | [Showcase](https://valohai.com/showcase/) | [Slack](http://community-slack.valohai.com/) - Valohai is a machine learning platform. It runs your experiments in the cloud, tracks your experiment history and streamlines data science workflows. DEEP LEARNING MANAGEMENT PLATFORM. Machine Orchestration, Version Control and Pipeline Management for Deep Learning.
  - [Seldon](https://www.seldon.io/open-source/) - Model deployment platform, on kubernetes clusters. | [docs](https://docs.seldon.io/projects/seldon-core/en/latest/) | [github](https://github.com/SeldonIO/seldon-core/blob/master/readme.md) | [use-cases](https://www.seldon.io/use-cases/) | [blogs](https://www.seldon.io/blog/) | [videos](https://www.youtube.com/channel/UCZq33lhQWAsd-8NDqOdjN_g/videos?view_as=subscriber)
  - [kedra](https://github.com/quantumblacklabs/kedro) | [docs](https://kedro.readthedocs.io/en/latest/) | [Kedro-Viz](https://github.com/quantumblacklabs/kedro-viz) | [kedro-examples](https://github.com/quantumblacklabs/kedro-examples) - Kedro is a workflow development tool that helps you build data pipelines that are robust, scalable, deployable, reproducible and versioned.
  - [Lambda Stack](https://lambdalabs.com/lambda-stack-deep-learning-software) - One-line installation of TensorFlow, Keras, Caffe, Caffe, CUDA, cuDNN, and NVIDIA Drivers for Ubuntu 16.04 and 18.04.
  - [Apache Airflow](https://airflow.apache.org/) - Airflow is a platform to programmatically author, schedule and monitor workflows. Use airflow to author workflows as directed acyclic graphs (DAGs) of tasks. The airflow scheduler executes your tasks on an array of workers while following the specified dependencies.
  - [Nextflow](https://www.nextflow.io/) - Data-driven computational pipelines. Nextflow enables scalable and reproducible scientific workflows using software containers. It allows the adaptation of pipelines written in the most common scripting languages.
  - [StackHPC suites of repositories: AI, ML, DL, Cloud, HPC](https://github.com/stackhpc) | [StackHPC](http://stackhpc.com/)
  - [cortex](https://www.cortex.dev/) - Machine learning deployment platform: Deploy machine learning models to production
  - [See also: Data > Programs and Tools](../data/programs-and-tools.md#programs-and-tools)

## CPU

  - Probing the CPU (Linux/MacOS)
      - [libcpuid](http://libcpuid.sourceforge.net/index.html)
      + Zero overhead performance capturing: use `/proc/interrupts` and `/proc/softirqs`
      + Non-zero overhead, less accurate: use the PMU (capture on- and off-core events)
  - Probing the CPU (Windows)
      - [perfview](https://github.com/Microsoft/perfview) - general profiling on Windows
      - [perfview for .net](https://www.infoq.com/presentations/perfview-net) - excellent overview by Sasha Goldshtein
  - Intel
    - [Intel® Developer Zone](https://software.intel.com/en-us/home)
    - [Intel® AI Developer Home Page](https://software.intel.com/en-us/ai)
    - [Intel® AI Courses](https://software.intel.com/en-us/ai/courses)
    - [Featured Course: AI from the Data Center to the Edge – An Optimized Path using Intel® Architecture](https://software.seek.intel.com/DataCenter_to_Edge_REG)
    - [Intel® AI Developer Webinar Series](https://software.seek.intel.com/AIWebinarSeries?registration_source=IDZ) | [All webinars listing](https://intelvs.on24.com/vshow/IntelWebinarEvents/#content/2033414)
    - The PlaidML Tensor Compiler - [webinar](https://event.on24.com/eventRegistration/console/EventConsoleApollo.jsp?&eventid=2026509&sessionid=1&username=&partnerref=&format=fhaudio&mobile=false&flashsupportedmobiledevice=false&helpcenter=false&key=B27628973F7FA8B9758983E373E36ED1&text_language_id=en&playerwidth=1000&playerheight=700&overwritelobby=y&eventuserid=246511746&contenttype=A&mediametricsessionid=207230377&mediametricid=2857349&usercd=246511746&mode=launch)
    - nGraph - Unlocking next-generation performance with deep learning compilers: [webinar](https://intelvs.on24.com/vshow/IntelWebinarEvents/#content/2033414) | [slides](https://event.on24.com/event/20/33/41/2/rt/1/documents/resourceList1565185524584/s_ngraphwebinar1565185512750.pdf) | [homepage](https://www.ngraph.ai/) | [github](https://github.com/NervanaSystems/ngraph)
 
 _Thanks to the great minds on the [mechanical sympathy](https://groups.google.com/forum/#!forum/mechanical-sympathy) mailing list for their responses to my queries on CPU probing._

## FPGA

  - [Intel AI Developer Program - Deep Learning Inference With Intel® FPGAs](https://software.intel.com/en-us/ai/courses/deep-learning-inference-fpga)
  - [Using FPGAs for Datacenter Acceleration](https://event.on24.com/eventRegistration/EventLobbyServlet?target=lobby20.jsp&eventid=2033432&sessionid=1&eventuserid=246511756&key=8678836B54A84876D7338D7BF7F87B88) | [Windows AI](https://docs.microsoft.com/en-us/windows/ai/) | [Intel® Distribution of OpenVINO™ Toolkit: Develop Multiplatform Computer Vision Solutions](https://software.intel.com/en-us/openvino-toolkit)

## GPU

  - [Know your GPU](https://gist.github.com/neomatrix369/256913dcf77cdbb5855dd2d7f5d81b84)
  - [GPU Server 1 of 2](./gpus/GPU-Server-side-1-of-2.jpg) | [GPU Server 2 of 2](./gpus/GPU-Server-side-2-of-2.jpg) | [Applications of GPU servers](./gpus/Applications-of-GPU-Server.jpg) - [checkout the manufacturers](http://manli.com/en/)
  - [Embedded Vision Solutions for NVIDIA Jetson Series](https://www.avermedia.com/professional/category/nvidia_jetson_solutions) | [Embedded Vision Family Brochure](http://storage.avermedia.com/web_release_www/Solutions/Embedded_Vision_Solutions_brochure_20190429.pdf)
  - Avermedia Box PC & Carrier (works with NVidia Jetson): [1](./gpus/Avermedia-Box-PC-and-Carrier-1-of-2-works-with-NVidia-Jetson.jpg) | [2](./gpus/Avermedia-Box-PC-and-Carrier-2-of-2-works-with-NVidia-Jetson.jpg)

## TPU

  - [How to harness the Powers of the Cloud TPU](https://medium.com/bitgrit-data-science-publication/how-to-harness-the-powers-of-the-cloud-tpu-3939dc363d9f)

## IPU

  - [GraphCore](http://graphcore.ai) | Videos: [Simon Knowles - More complex models and more powerful machines](https://www.youtube.com/watch?v=dLvkF_TmyAc&feature=youtu.be) | [Graphcore tech Concept](https://youtu.be/cSXbhEsUUGo?t=916) | [A new kind of hardware designed for machine intelligence - GraphCore Presentations](http://www.bristol.bcs.org.uk/2017/graphcore.pdf) | [V‍ID‌EO‌‍: SCA‌LING‌‍ THRO‌UG‍HP‌‍U‌T P‍R‌O‍C‍ESSO‌‍RS FO‌‍R‍ MAC‌HINE INTELLIG‌ENC‌‍E](https://www.graphcore.ai/posts/video-scaling-throughput-processors-for-machine-intelligence)

## Performance

  - [MLPerf](https://mlperf.org/) - Fair and useful benchmarks for measuring training and inference performance of ML hardware, software, and services.
  - [MLPerf introduces machine learning inference benchmark suite...](https://venturebeat.com/2019/06/24/mlperf-introduces-machine-learning-inference-benchmark-suite/)
  - [ONE DEEP LEARNING BENCHMARK TO RULE THEM ALL](https://www.nextplatform.com/2018/08/30/one-deep-learning-benchmark-to-rule-them-all/)
  - [mlbench: Distributed Machine Learning Benchmark](https://mlbench.github.io/) - A public and reproducible collection of reference implementations and benchmark suite for distributed machine learning algorithms, frameworks and systems.
  - [EEMBC MLMark Benchmark](https://www.eembc.org/mlmark/) - The EEMBC MLMark benchmark is a machine-learning (ML) benchmark designed to measure the performance and accuracy of embedded inference. 
  - [DeepOBS: A Deep Learning Optimizer Benchmark Suite](https://arxiv.org/abs/1903.05499)
  - [PMLB](https://biodatamining.biomedcentral.com/articles/10.1186/s13040-017-0154-4) - a large benchmark suite for machine learning evaluation and comparison
  - [Deep Learning Benchmarking Suite](https://github.com/HewlettPackard/dlcookbook-dlbs) | [HPE Deep Learning Cookbook](https://www.hpe.com/software/dl-cookbook)

# Contributing

Contributions are very welcome, please share back with the wider community (and get credited for it)!

Please have a look at the [CONTRIBUTING](../CONTRIBUTING.md) guidelines, also have a read about our [licensing](../LICENSE.md) policy.

---

Back to [main page (table of contents)](../README.md)