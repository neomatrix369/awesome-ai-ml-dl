ARG GRAALVM_VERSION
ARG GRAALVM_JDK_VERSION

FROM findepi/graalvm:${GRAALVM_VERSION}-${GRAALVM_JDK_VERSION} as graal-jdk-image
FROM jupyter/datascience-notebook as base-image

### Install JDK 11 from AdoptOpenJDK images
COPY --from=adoptopenjdk/openjdk11 /opt/java /opt/java

### Install GraalVM for Java 11
COPY --from=graal-jdk-image /graalvm* /opt/java/graalvm

### Install curl needed for rest of the tasks
USER root
RUN apt-get update && apt-get install -qy curl

ARG WORKDIR
WORKDIR ${WORKDIR}

ARG IMAGE_VERSION
ARG DEEPNETTS_VERSION

LABEL maintainer="Mani Sarkar"
LABEL example_git_repo="https://github.com/neomatrix369/awesome-ai-ml-dl/tree/master/examples/deepnetts"
LABEL deepnetts_version=${DEEPNETTS_VERSION}
LABEL graalvm_version=${GRAALVM_VERSION}-{GRAALVM_JDK_VERSION}
LABEL version=${IMAGE_VERSION}

### Java setup
ARG JAVA_11_HOME

ARG GRAALVM_HOME
ENV GRAALVM_HOME=${GRAALVM_HOME}
ENV JAVA_HOME=${GRAALVM_HOME}
ENV PATH=${JAVA_HOME}/bin:${PATH}

### Test Java (Traditional and GraalVM)
RUN ${JAVA_11_HOME}/bin/java -version

RUN ${GRAALVM_HOME}/bin/java -version

### Install packages
RUN apt-get update && apt-get install -qy unzip git vim libgomp1 glibc-*

RUN unzip -version
RUN git --version
RUN vim --version

### Install the Jupyter Java Kernel
RUN wget https://github.com/neomatrix369/awesome-ai-ml-dl/releases/download/v0.1/ijava-1.3.0.zip
COPY install-java-kernel.sh install-java-kernel.sh
RUN ./install-java-kernel.sh --installJar

### Common functions
COPY common.sh common.sh

### Install DeepNetts
RUN export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:${JAVA_HOME}/lib/server/:${JAVA_HOME}/lib/amd64/server/ 
COPY install-deepnetts.sh install-deepnetts.sh
RUN ./install-deepnetts.sh

### Setup user
COPY .bashrc .bashrc_custom
RUN cat .bashrc_custom >> /home/jovyan/.bashrc
RUN rm .bashrc_custom

ARG GROUP
RUN cd ${WORKDIR} && chown -R jovyan:${GROUP} .