FROM adoptopenjdk/openjdk9

WORKDIR /home/nlp-java

### GraalVM installation
ARG GRAALVM_VERSION
ENV GRAALVM_VERSION="${GRAALVM_VERSION}"

RUN curl -O -L -J https://github.com/oracle/graal/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-linux-amd64-${GRAALVM_VERSION}.tar.gz

RUN tar xzf graalvm-ce-linux-amd64-${GRAALVM_VERSION}.tar.gz -C /opt/java/

ENV GRAALVM_HOME="/opt/java/graalvm-ce-${GRAALVM_VERSION}"

ENV JAVA_HOME=/opt/java/graalvm-ce-${GRAALVM_VERSION}

ENV PATH=${JAVA_HOME}/bin:$PATH

### Remove unused Java binaries

RUN rm graalvm-ce-linux-amd64-${GRAALVM_VERSION}.tar.gz
RUN rm -fr ${GRAALVM_HOME}/languages ${GRAALVM_HOME}/jre/languages 

### Test Java

RUN java -version

### Install packages
RUN apt-get update && apt-get install -qy unzip git
RUN apt-get install -qy vim

RUN unzip -version
RUN git --version
RUN vim --version

### Setup user

RUN groupadd -r nlp-java && useradd -g nlp-java nlp-java
RUN cd /home/nlp-java
RUN chown -R nlp-java:nlp-java .

COPY .bashrc .bashrc