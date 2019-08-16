FROM findepi/graalvm:19.1.1-all

ARG WORKDIR
ENV WORKDIR=${WORKDIR}

WORKDIR ${WORKDIR}

COPY .deeplearning4j /root/.deeplearning4j
COPY MLPMnist-1.0.0.jar ${WORKDIR}/MLPMnist-1.0.0.jar
COPY runMLPMnist.sh ${WORKDIR}/runMLPMnist.sh

ENV JAVA_HOME=/graalvm