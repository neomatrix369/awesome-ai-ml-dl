FROM python:3.7

COPY install-linux.sh install-linux.sh
COPY install-dependencies.sh install-dependencies.sh

RUN ./install-linux.sh

### Fix the error PyTextRank throws: TypeError: __call__() got an unexpected keyword argument 'parse'
RUN sed -i 's/graph.edge\[/graph.adj\[/g' /usr/local/lib/python3.7/site-packages/pytextrank/pytextrank.py || true
RUN sed -i 's/, parse=True//g' /usr/local/lib/python3.7/site-packages/pytextrank/pytextrank.py || true

RUN sed -i 's/graph.edge\[/graph.adj\[/g' ~/.local/lib/python3.7/site-packages/pytextrank/pytextrank.py || true
RUN sed -i 's/, parse=True//g' ~/.local/lib/python3.7/site-packages/pytextrank/pytextrank.py || true

EXPOSE 8888

ENV PATH=/root/.local/bin/:$PATH

ENTRYPOINT ["jupyter-lab", "--ip=0.0.0.0", "--allow-root", "--no-browser"]