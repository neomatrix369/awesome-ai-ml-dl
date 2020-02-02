FROM openjdk:8-jdk

RUN java -version
RUN echo "JAVA_HOME=${JAVA_HOME}"
ENV JAVA8_HOME="${JAVA_HOME}"
RUN echo "JAVA8_HOME=${JAVA8_HOME}"

### Grakn, Graql installation

RUN echo "Cleaning up old stuff"
RUN apt-get autoclean
RUN apt-get clean

RUN echo "Building the Open Source version (AGPL license), go to https://github.com/graknlabs for further details"
RUN apt-get update && apt-get install -y --no-install-recommends wget unzip pv \
    && rm -r /var/lib/apt/lists/*

ARG GRAKN_VERSION
ENV GRAKN_VERSION=${GRAKN_VERSION}
ENV WORKDIR=/home/grakn
WORKDIR ${WORKDIR}

ENV GRAKN_CORE_LINUX=grakn-core-all-linux
RUN wget https://github.com/graknlabs/grakn/releases/download/${GRAKN_VERSION}/${GRAKN_CORE_LINUX}-${GRAKN_VERSION}.tar.gz --progress=bar:force 2>&1 | tail -f -n +3
RUN tar zxvf ${GRAKN_CORE_LINUX}-${GRAKN_VERSION}.tar.gz | pv -l >/dev/null
RUN rm ${GRAKN_CORE_LINUX}-${GRAKN_VERSION}.tar.gz
RUN ./${GRAKN_CORE_LINUX}-${GRAKN_VERSION}/grakn version

### GraalVM installation
ARG GRAALVM_VERSION
ENV GRAALVM_VERSION="${GRAALVM_VERSION:-19.1.1}"

ENV TARGET_JDK_FOLDER=graalvm-ce-${GRAALVM_VERSION}
ENV GRAALVM_ARTIFACT_FILENAME=graalvm-ce-linux-amd64-${GRAALVM_VERSION}
ENV GRAALVM_ARTIFACT="${GRAALVM_ARTIFACT_FILENAME}.tar.gz"

RUN wget https://github.com/oracle/graal/releases/download/vm-${GRAALVM_VERSION}/${GRAALVM_ARTIFACT} --progress=bar:force 2>&1 | tail -f -n +3
RUN tar xvzf ${GRAALVM_ARTIFACT} -C /usr/local | pv -l >/dev/null

ENV GRAALVM_HOME="/usr/local/${TARGET_JDK_FOLDER}"
RUN echo "GRAALVM_HOME=${TARGET_GRAALVM_HOME}"
RUN ${GRAALVM_HOME}/bin/java -version
RUN rm ${GRAALVM_ARTIFACT}
RUN rm -fr ${GRAALVM_ARTIFACT_FILENAME}

### Downloading native-image
RUN ${GRAALVM_HOME}/bin/gu install native-image

### Cleanup to make space
RUN echo "Cleaning up old stuff, again"
RUN apt-get autoclean
RUN apt-get clean

### Install bazel
RUN apt-get update && apt-get install -qy --no-install-recommends             \
    pkg-config zip g++ zlib1g-dev unzip python3 python3-pip python3-setuptools \
    && rm -r /var/lib/apt/lists/*
ENV BAZEL_VERSION=0.26.1
RUN curl -J -L -O  https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh
RUN chmod +x bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh
RUN ./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh
RUN export PATH=$HOME/bin:${PATH}

RUN apt-get update && apt-get install -qy vim \
    --no-install-recommends                   \
    && rm -r /var/lib/apt/lists/*

# Cleaning up once again
RUN apt-get autoclean
RUN apt-get clean

### Install grakn-client and supporting tools
RUN pip3 install --upgrade pip
RUN pip3 --version
RUN pip install setuptools ijson==2.3 grakn-client

RUN mkdir -p .cache

COPY grakn_version.txt          ./grakn_version.txt
COPY graalvm_version.txt        ./graalvm_version.txt
COPY startGraknAndGraql.sh      ./startGraknAndGraql.sh
COPY performance-benchmark-scripts/runPerformanceBenchmark.sh ./runPerformanceBenchmark.sh
COPY mergeJson.sh               ./mergeJson.sh
COPY builder.sh                 ./builder.sh
COPY common.sh                  ./common.sh
COPY grakn-jar-runner.sh        ./grakn-jar-runner.sh
COPY 0001-Build-a-distribution-with-uber-jars.patch ./0001-Build-a-distribution-with-uber-jars.patch

RUN groupadd -r user_grp && useradd -r -g user_grp grakn
RUN chown -R grakn:user_grp .

USER grakn

COPY .bashrc ${WORKDIR}/.bashrc

ARG DEFAULT_PORT
EXPOSE ${DEFAULT_PORT}

ENTRYPOINT ["bash", "-c", "./startGraknAndGraql.sh"]