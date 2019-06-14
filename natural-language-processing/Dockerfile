FROM adoptopenjdk/openjdk9

WORKDIR /home

### GraalVM installation

ARG GRAALVM_VERSION
ENV GRAALVM_VERSION=${GRAALVM_VERSION:-19.0.0}
RUN curl -J -L -O https://github.com/oracle/graal/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-linux-amd64-${GRAALVM_VERSION}.tar.gz 

RUN tar xvzf graalvm-ce-linux-amd64-${GRAALVM_VERSION}.tar.gz

RUN mv graalvm-ce-${GRAALVM_VERSION} /opt/java/graalvm-ce-${GRAALVM_VERSION}

ENV JAVA_HOME=/opt/java/graalvm-ce-${GRAALVM_VERSION}

ENV PATH=${JAVA_HOME}/bin:$PATH

### Stanford NLP installation

RUN curl -O -L -J http://nlp.stanford.edu/software/stanford-corenlp-full-2018-10-05.zip

RUN apt-get update && apt-get install unzip
RUN unzip stanford-corenlp-full-2018-10-05.zip

### Remove unused Java binaries

RUN rm graalvm-ce-linux-amd64-${GRAALVM_VERSION}.tar.gz
RUN rm -fr /opt/java/openjdk

### Test Java

RUN java -version