FROM ubuntu:22.04

ENV PATH="${PATH}:/usr/local/lib/python3.10/dist-packages/bin"
ENV LC_CTYPE=C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update && apt install -y \
    gcc \
    g++ \
    gdb \
    git \
    python3 \
    python3-pip \
    python3-venv \
    python3-setuptools \
    python3-distutils \
    gnupg2 \
    sudo \
    tmux \
    vim \
    wget \
    curl \
    make \
    cmake \
    build-essential \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev \
    libyaml-dev \
    libffi-dev \
    libgdbm-dev \
    libncurses5-dev \
    libdb-dev \
    libc6-dev \
    bison \
    autoconf \
    pkg-config \
    libglib2.0-dev \
    libpcre3-dev \
    ruby-full \
    && apt clean && rm -rf /var/lib/apt/lists/*

WORKDIR /root
RUN git clone https://github.com/unicorn-engine/unicorn.git && \
    cd unicorn && \
    git checkout 2.0.0-rc5 && \
    mkdir build && cd build && \
    cmake .. && make -j$(nproc) && make install && ldconfig && \
    cd ../bindings/python && \
    python3 setup.py install && \
    cd / && rm -rf unicorn

RUN git clone https://github.com/pwndbg/pwndbg
WORKDIR /root/pwndbg
RUN git checkout 2023.03.19
RUN ./setup.sh

RUN pip3 install --upgrade pip && pip3 install pwntools
RUN gem install one_gadget

WORKDIR /root
