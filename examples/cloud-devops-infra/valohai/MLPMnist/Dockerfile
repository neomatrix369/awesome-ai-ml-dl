FROM findepi/graalvm:19.1.1-all

RUN apt-get install -qy curl

ARG WORKDIR
ENV WORKDIR=${WORKDIR}

WORKDIR ${WORKDIR}

COPY installMaven.sh installMaven.sh

ARG MAVEN_TARGET_DIR
ENV MAVEN_TARGET_DIR=${MAVEN_TARGET_DIR}

ARG MAVEN_VERSION
ENV M2_HOME="${MAVEN_TARGET_DIR}/apache-maven-${MAVEN_VERSION}"

RUN ./installMaven.sh 

ENV JAVA_HOME=/graalvm
ENV PATH=${M2_HOME}:${PATH}