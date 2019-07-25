FROM adoptopenjdk/openjdk9

WORKDIR /home

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
RUN rm -fr /opt/java/openjdk

### Test Java

RUN java -version

### Stanford NLP installation

RUN curl -O -L -J http://nlp.stanford.edu/software/stanford-corenlp-full-2018-10-05.zip

RUN apt-get update && apt-get install unzip
RUN unzip stanford-corenlp-full-2018-10-05.zip
