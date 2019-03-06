docker run --rm                        \
           -it                         \
           --volume $(pwd):/better-nlp \
           --workdir /better-nlp       \
           better-nlp /bin/bash 