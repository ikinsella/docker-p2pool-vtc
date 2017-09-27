FROM debian:stable-slim
LABEL maintainer="Ian Kinsella <ikinsella@wisc.edu>"

COPY ./bin /usr/local/bin

RUN chmod a+x /usr/local/bin/* && \
    apt-get update && \
    apt-get install -y ca-certificates git python-rrdtool python-pygame python-scipy python-twisted python-twisted-web python-imaging && \
    git clone https://github.com/vertcoin/p2pool-vtc.git && \
    cd p2pool-vtc/lyra2re-hash-python && \
    git submodule init && \
    git submodule update && \
    python setup.py install && \
    apt-get purge -y ca-certificates git && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /var/tmp/*

VOLUME ["/data"]
ENV HOME /data
WORKDIR /data

EXPOSE 9171 9346

ENTRYPOINT ["init"]