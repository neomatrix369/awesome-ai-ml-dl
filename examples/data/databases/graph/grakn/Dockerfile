FROM java:8u111-jdk

RUN java -version
RUN echo "JAVA_HOME=${JAVA_HOME}"
ENV JAVA_8_HOME="${JAVA_HOME}"
RUN echo "JAVA_8_HOME=${JAVA_8_HOME}"

### Grakn, Graql installation

RUN echo "Building the Open Source version (AGPL license), go to https://github.com/graknlabs for further details"
RUN apt-get update && apt-get install -y wget unzip pv

ARG GRAKN_VERSION
ENV GRAKN_VERSION=${GRAKN_VERSION:-1.4.3}
ENV WORKDIR=grakn
WORKDIR /${WORKDIR}

RUN wget https://github.com/graknlabs/grakn/releases/download/v${GRAKN_VERSION}/grakn-core-${GRAKN_VERSION}.zip --progress=bar:force 2>&1 | tail -f -n +3

RUN unzip grakn-core-${GRAKN_VERSION}.zip | pv -l >/dev/null

RUN chmod +x grakn-core-${GRAKN_VERSION}/grakn 
RUN chmod +x grakn-core-${GRAKN_VERSION}/graql
RUN rm grakn-core-${GRAKN_VERSION}.zip

RUN cd grakn-core-${GRAKN_VERSION} && ./grakn version
RUN cd grakn-core-${GRAKN_VERSION} && ./graql version

### GraalVM installation

ENV GRAALVM_VERSION="1.0.0-rc14"
RUN wget https://github.com/oracle/graal/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-${GRAALVM_VERSION}-linux-amd64.tar.gz --progress=bar:force 2>&1 | tail -f -n +3
RUN tar xvzf graalvm-ce-${GRAALVM_VERSION}-linux-amd64.tar.gz | pv -l >/dev/null

RUN mv graalvm-ce-${GRAALVM_VERSION}/jre /usr/lib/jvm/graalvm-ce-${GRAALVM_VERSION}
ENV GRAALVM_HOME="/usr/lib/jvm/graalvm-ce-${GRAALVM_VERSION}"
RUN echo "GRAALVM_HOME=${GRAALVM_HOME}"
RUN ${GRAALVM_HOME}/bin/java -version
RUN rm graalvm-ce-${GRAALVM_VERSION}-linux-amd64.tar.gz
RUN rm -fr graalvm-ce-${GRAALVM_VERSION}

COPY startGraknAndGraql.sh ./startGraknAndGraql.sh

EXPOSE 4567

ENTRYPOINT ["bash", "-c", "./startGraknAndGraql.sh"]