FROM adoptopenjdk/openjdk9

ENV JAVA_OPTS="-XX:+UnlockExperimentalVMOptions -XX:+EnableJVMCI -XX:+UseJVMCICompiler"
ENV JAVA_TOOL_OPTIONS="${JAVA_TOOL_OPTIONS} ${JAVA_OPTS}"

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