FROM openjdk:8-jdk

RUN java -version
RUN echo "JAVA_HOME=${JAVA_HOME}"
ENV JAVA8_HOME="${JAVA_HOME}"
RUN echo "JAVA8_HOME=${JAVA8_HOME}"

### Grakn, Graql installation

RUN echo "Building the Open Source version (AGPL license), go to https://github.com/graknlabs for further details"
RUN apt-get update && apt-get install -y wget unzip pv \
    --no-install-recommends \
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

ARG GRAALVM_JDK_VERSION
ENV GRAALVM_JDK_VERSION=${GRAALVM_JDK_VERSION}
ENV TARGET_JDK_FOLDER=graalvm-ce-${GRAALVM_JDK_VERSION}-${GRAALVM_VERSION}
ENV GRAALVM_ARTIFACT_FILENAME=graalvm-ce-${GRAALVM_JDK_VERSION}-linux-amd64-${GRAALVM_VERSION}
ENV GRAALVM_ARTIFACT="${GRAALVM_ARTIFACT_FILENAME}.tar.gz"

RUN wget https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-${GRAALVM_VERSION}/${GRAALVM_ARTIFACT} --progress=bar:force 2>&1 | tail -f -n +3
RUN tar xvzf ${GRAALVM_ARTIFACT} -C /usr/local | pv -l >/dev/null

RUN ls -lash /usr/local/g*
ENV GRAALVM_HOME="/usr/local/${TARGET_JDK_FOLDER}"
RUN echo "GRAALVM_HOME=${TARGET_GRAALVM_HOME}"
RUN ${GRAALVM_HOME}/bin/java -version
RUN rm ${GRAALVM_ARTIFACT}
RUN rm -fr ${GRAALVM_ARTIFACT_FILENAME}

### Downloading native-image
RUN ${GRAALVM_HOME}/bin/gu install native-image

### Install bazel
RUN apt-get update && apt-get install -qy pkg-config zip g++ zlib1g-dev unzip python3 \
    --no-install-recommends \
    && rm -r /var/lib/apt/lists/*
ENV BAZEL_VERSION=0.26.1
RUN curl -J -L -O  https://github.com/bazelbuild/bazel/releases/download/${BAZEL_VERSION}/bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh
RUN chmod +x bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh
RUN ./bazel-${BAZEL_VERSION}-installer-linux-x86_64.sh
RUN export PATH=$HOME/bin:${PATH}

RUN apt-get update && apt-get install -qy vim \
    --no-install-recommends \
    && rm -r /var/lib/apt/lists/*
RUN mkdir -p .cache

COPY grakn_version.txt          ./grakn_version.txt
COPY graalvm_version.txt        ./graalvm_version.txt
COPY graalvm_jdk_version.txt    ./graalvm_jdk_version.txt
COPY startGraknAndGraql.sh      ./startGraknAndGraql.sh
COPY performance-benchmark-scripts/runPerformanceBenchmark.sh ./runPerformanceBenchmark.sh
COPY mergeJson.sh               ./mergeJson.sh
COPY builder.sh                 ./builder.sh
COPY common.sh                  ./common.sh
COPY 0001-Build-a-distribution-with-uber-jars.patch ./0001-Build-a-distribution-with-uber-jars.patch

RUN groupadd -r user_grp && useradd -r -g user_grp grakn
RUN chown -R grakn:user_grp .

USER grakn

COPY .bashrc ${WORKDIR}/.bashrc

ARG DEFAULT_PORT
EXPOSE ${DEFAULT_PORT}

ENTRYPOINT ["bash", "-c", "./startGraknAndGraql.sh"]