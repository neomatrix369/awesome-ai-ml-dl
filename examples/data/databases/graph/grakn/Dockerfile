FROM buildpack-deps:stretch-scm

# Install Java 8
COPY --from=java:8u111-jdk /usr/lib/jvm /usr/lib/jvm

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
ENV PATH=${JAVA_HOME}/bin:${PATH}

RUN echo "JAVA_HOME=${JAVA_HOME}"
RUN echo "PATH=${PATH}"

RUN java -version
RUN echo "JAVA_HOME=${JAVA_HOME}"
ENV JAVA_8_HOME="${JAVA_HOME}"
RUN echo "JAVA_8_HOME=${JAVA_8_HOME}"

### Grakn, Graql installation

RUN echo "Building the Open Source version (AGPL license), go to https://github.com/graknlabs for further details"
RUN apt-get update && apt-get install -y wget unzip pv

ARG GRAKN_VERSION
ENV GRAKN_VERSION=${GRAKN_VERSION:-1.5.7}
ENV WORKDIR=grakn
WORKDIR /${WORKDIR}

ENV GRAKN_CORE_LINUX=grakn-core-all-linux
RUN wget https://github.com/graknlabs/grakn/releases/download/${GRAKN_VERSION}/${GRAKN_CORE_LINUX}-${GRAKN_VERSION}.tar.gz --progress=bar:force 2>&1 | tail -f -n +3
RUN tar zxvf ${GRAKN_CORE_LINUX}-${GRAKN_VERSION}.tar.gz | pv -l >/dev/null
RUN rm ${GRAKN_CORE_LINUX}-${GRAKN_VERSION}.tar.gz
RUN ./${GRAKN_CORE_LINUX}-${GRAKN_VERSION}/grakn version

### GraalVM installation
ARG GRAALVM_VERSION
ENV GRAALVM_VERSION="${GRAALVM_VERSION:-19.1.0}"
RUN wget https://github.com/oracle/graal/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-linux-amd64-${GRAALVM_VERSION}.tar.gz --progress=bar:force 2>&1 | tail -f -n +3
RUN tar xvzf graalvm-ce-linux-amd64-${GRAALVM_VERSION}.tar.gz | pv -l >/dev/null

RUN mv graalvm-ce-${GRAALVM_VERSION}/jre /usr/lib/jvm/graalvm-ce-${GRAALVM_VERSION}
ENV GRAALVM_HOME="/usr/lib/jvm/graalvm-ce-${GRAALVM_VERSION}"
RUN echo "GRAALVM_HOME=${GRAALVM_HOME}"
RUN ${GRAALVM_HOME}/bin/java -version
RUN rm graalvm-ce-linux-amd64-${GRAALVM_VERSION}.tar.gz
RUN rm -fr graalvm-ce-${GRAALVM_VERSION}

EXPOSE 4567

COPY startGraknAndGraql.sh ./startGraknAndGraql.sh

ENTRYPOINT ["bash", "-c", "./startGraknAndGraql.sh"]