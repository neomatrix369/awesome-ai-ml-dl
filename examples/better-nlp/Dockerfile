FROM python:3.7

COPY install-linux.sh install-linux.sh
COPY install-dependencies.sh install-dependencies.sh

RUN ./install-linux.sh

EXPOSE 8888

ARG JUPYTER_NOTEBOOK
ENV JUPYTER_NOTEBOOK="better-nlp-spacy-texacy-examples.ipynb"

ENV PATH=/root/.local/bin/:$PATH

ENTRYPOINT ["jupyter-lab", ${JUPYTER_NOTEBOOK}, "--ip=0.0.0.0", "--allow-root", "--no-browser"]