FROM ubuntu:latest

ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update && apt-get install -y --no-install-recommends \
    apt-utils \
    build-essential \
    python3.8 \
    python3-pip \
    python3-setuptools \
    python3-dev \
    wget \ 
    gcc \ 
    bzip2 \ 
    make \
    zlib1g \ 
    zlib1g-dev && \ 
    cd /usr/local/  && \ 
    wget https://github.com/lh3/minimap2/releases/download/v2.17/minimap2-2.17.tar.bz2 && \
    tar -xjvf minimap2-2.17.tar.bz2 && \ 
    cd minimap2-2.17 && \ 
    make && \
    mv minimap2 /usr/local/bin && \
    cd .. 

COPY requirements.txt .
RUN pip3 install -r requirements.txt

RUN rm -rf minimap2-2.17.tar.bz2 minimap2-2.17 && \
    apt-get remove -y wget gcc bzip2 make zlib1g-dev && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* 

WORKDIR /home

ENTRYPOINT ["/bin/bash"]
