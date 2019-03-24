FROM java:8u111-jdk

RUN java -version

RUN echo "JAVA_HOME=${JAVA_HOME}"

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

COPY startGraknAndGraql.sh ${WORKDIR}/startGraknAndGraql.sh

EXPOSE 4567

ENTRYPOINT ["bash", "-c", "./${WORKDIR}/startGraknAndGraql.sh"]