ARG DSS_VERSION
FROM dataiku/dss:${DSS_VERSION} as dataikuDss

FROM buildpack-deps:stretch-scm as base

COPY --from=dataikuDss / /

# Install Java 8
RUN echo "JAVA_HOME=${JAVA_HOME}"
RUN echo "PATH=${PATH}"

RUN java -version

### GraalVM installation
ARG GRAALVM_VERSION
ENV GRAALVM_VERSION="${GRAALVM_VERSION:-19.1.0}"
RUN curl -O -J -L https://github.com/oracle/graal/releases/download/vm-${GRAALVM_VERSION}/graalvm-ce-linux-amd64-${GRAALVM_VERSION}.tar.gz
RUN tar xvzf graalvm-ce-linux-amd64-${GRAALVM_VERSION}.tar.gz -C /usr/lib/jvm

ENV GRAALVM_HOME="/usr/lib/jvm/graalvm-ce-${GRAALVM_VERSION}"
RUN echo "GRAALVM_HOME=${GRAALVM_HOME}"
RUN ${GRAALVM_HOME}/bin/java -version
RUN rm graalvm-ce-linux-amd64-${GRAALVM_VERSION}.tar.gz
RUN update-alternatives --install /usr/bin/java java ${GRAALVM_HOME}/bin/java 1

EXPOSE 10000

ARG WORKDIR
WORKDIR ${WORKDIR}

COPY runDSS.sh runDSS.sh

ARG USER
RUN chown -R ${USER}:${USER} ${WORKDIR}

USER ${USER}

ENTRYPOINT ["bash", "-c", "./runDSS.sh"]