ARG GRAALVM_VERSION
ARG GRAALVM_JDK_VERSION
ARG DSS_VERSION

FROM oracle/graalvm-ce:${GRAALVM_VERSION}-${GRAALVM_JDK_VERSION} as graal-jdk-image

FROM dataiku/dss:${DSS_VERSION} as dataikuDss

FROM buildpack-deps:stretch-scm as base

COPY --from=dataikuDss / /

ARG IMAGE_VERSION

LABEL maintainer="Mani Sarkar"
LABEL example_git_repo="https://github.com/neomatrix369/awesome-ai-ml-dl/tree/master/examples/data/dataiku"
LABEL graalvm_version=${GRAALVM_VERSION}-{GRAALVM_JDK_VERSION}
LABEL version=${IMAGE_VERSION}


# Install Java 8 to 11
RUN echo "JAVA_HOME=${JAVA_HOME}"
RUN echo "PATH=${PATH}"

RUN java -version

### GraalVM installation
ARG GRAALVM_VERSION
ENV GRAALVM_VERSION="${GRAALVM_VERSION:-20.3.0}"

COPY --from=graal-jdk-image /opt/graalvm-ce-* /usr/lib/jvm/graalvm-ce

ENV GRAALVM_HOME="/usr/lib/jvm/graalvm-ce"
RUN echo "GRAALVM_HOME=${GRAALVM_HOME}"
RUN ${GRAALVM_HOME}/bin/java -version
RUN update-alternatives --install /usr/bin/java java ${GRAALVM_HOME}/bin/java 1

EXPOSE 10000

ARG WORKDIR
WORKDIR ${WORKDIR}

COPY runDSS.sh runDSS.sh

ARG USER
RUN chown -R ${USER}:${USER} ${WORKDIR}

USER ${USER}

ENTRYPOINT ["bash", "-c", "./runDSS.sh"]