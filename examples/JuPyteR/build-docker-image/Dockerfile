ARG GRAALVM_VERSION
ARG GRAALVM_JDK_VERSION

FROM oracle/graalvm-ce:${GRAALVM_VERSION}-${GRAALVM_JDK_VERSION} as graal-jdk-image

FROM adoptopenjdk/openjdk11

### Install GraalVM for Java 11
COPY --from=graal-jdk-image /opt/graalvm-ce-* /opt/java/graalvm

RUN rm -fr /opt/java/openjdk

ENV JAVA_HOME=/opt/java/graalvm
ENV PATH=${JAVA_HOME}/bin:${PATH}

ARG IMAGE_VERSION
LABEL maintainer="Mani Sarkar"
LABEL example_git_repo="https://github.com/neomatrix369/awesome-ai-ml-dl/tree/master/examples/JuPyteR"
LABEL graalvm_version="${GRAALVM_VERSION}-{GRAALVM_JDK_VERSION}"
LABEL version="${IMAGE_VERSION}"

COPY install-jupyter-notebooks.sh install-jupyter-notebooks.sh
RUN ./install-jupyter-notebooks.sh

COPY install-java-kernel.sh install-java-kernel.sh
RUN ./install-java-kernel.sh

EXPOSE 8888

RUN rm -f *.sh *.zip install.py

ARG USER
RUN groupadd -r ${USER} \
    && useradd -r -s /bin/false \
               -g ${USER} ${USER}

ARG WORKDIR
WORKDIR ${WORKDIR}

COPY runLocal.sh runLocal.sh
RUN mv -f /root/.local ${WORKDIR}

RUN chown -R ${USER}:${USER} ${WORKDIR}

USER ${USER}

ENTRYPOINT ["./runLocal.sh"]