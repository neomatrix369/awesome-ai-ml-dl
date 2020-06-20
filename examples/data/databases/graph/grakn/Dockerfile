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

### Grakn installation

ARG GRAKN_VERSION
ENV GRAKN_VERSION=${GRAKN_VERSION}
ENV WORKDIR=/home/grakn
WORKDIR ${WORKDIR}

ARG GRAKN_ARTIFACT_URL
RUN echo "Downloading artifact from url: ${GRAKN_ARTIFACT_URL}"
RUN wget ${GRAKN_ARTIFACT_URL} --progress=bar:force 2>&1 | tail -f -n +3

ARG GRAKN_ARTIFACT_NAME_WITH_EXT
ARG GRAKN_UNPACK_COMMAND
RUN echo "Unpacking artifact: ${GRAKN_ARTIFACT_NAME_WITH_EXT}"
RUN ${GRAKN_UNPACK_COMMAND} | pv -l >/dev/null

RUN echo "Removing artifact: ${GRAKN_ARTIFACT_NAME_WITH_EXT}"
RUN rm ${GRAKN_ARTIFACT_NAME_WITH_EXT}

ARG GRAKN_HOME
RUN echo "Checking version"
RUN ${GRAKN_HOME}/grakn version

### GraalVM installation

ARG GRAALVM_JDK_VERSION
ENV GRAALVM_JDK_VERSION=${GRAALVM_JDK_VERSION}

ARG GRAALVM_VERSION
ENV GRAALVM_VERSION="${GRAALVM_VERSION}"

ARG GRAALVM_ARTIFACT_URL
RUN echo "Downloading artifact from url: ${GRAALVM_ARTIFACT_URL}"
RUN wget ${GRAALVM_ARTIFACT_URL} --progress=bar:force 2>&1 | tail -f -n +3

ARG GRAALVM_ARTIFACT
RUN echo "Untarring artifact: ${GRAALVM_ARTIFACT}"
RUN tar xvzf ${GRAALVM_ARTIFACT} -C /usr/local | pv -l >/dev/null

ARG TARGET_GRAALVM_HOME
ENV GRAALVM_HOME="/usr/local/${TARGET_GRAALVM_HOME}"
RUN echo "GRAALVM_HOME=${GRAALVM_HOME}"

ARG GRAALVM_ARTIFACT_FILENAME
RUN echo "Removing artifact: ${GRAALVM_ARTIFACT}"
RUN rm ${GRAALVM_ARTIFACT}
RUN rm -fr ${GRAALVM_ARTIFACT_FILENAME}

RUN echo "Downloading native-image"
RUN ${GRAALVM_HOME}/bin/gu install native-image

RUN echo "Checking version"
RUN ${GRAALVM_HOME}/bin/java -version

RUN echo "JAVA_HOME=${JAVA_HOME}"
RUN echo "PATH=${PATH}"

### Cleanup to make space

RUN echo "Cleaning up old stuff, again"
RUN apt-get autoclean
RUN apt-get clean

### Install bazel

RUN apt-get update && apt-get install -qy --no-install-recommends              \
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
COPY graalvm_jdk_version.txt    ./graalvm_jdk_version.txt
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