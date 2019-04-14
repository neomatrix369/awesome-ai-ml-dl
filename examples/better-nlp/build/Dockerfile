FROM python:3.7

COPY install-linux.sh install-linux.sh
COPY install-dependencies.sh install-dependencies.sh

RUN ./install-linux.sh

EXPOSE 8888

ENV PATH=/root/.local/bin/:$PATH

ENTRYPOINT ["jupyter-lab", "--ip=0.0.0.0", "--allow-root", "--no-browser"]