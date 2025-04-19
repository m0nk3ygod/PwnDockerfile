FROM ubuntu:18.04

ENV PATH="${PATH}:/usr/local/lib/python3.6/dist-packages/bin"
ENV LC_CTYPE=C.UTF-8

RUN apt update && apt install -y \
    gcc \
    g++ \
    gdb \
    git \
    python3 \
    python3-pip \
    python3-venv \
    gnupg2 \
    sudo \
    tmux \
    vim \
    wget \
    curl \
    make \
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
    autoconf && \
    apt clean && rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
RUN wget https://cache.ruby-lang.org/pub/ruby/3.1/ruby-3.1.4.tar.gz && \
    tar -xzf ruby-3.1.4.tar.gz && \
    cd ruby-3.1.4 && \
    ./configure && \
    make -j$(nproc) && \
    make install && \
    cd .. && rm -rf ruby-3.1.4 ruby-3.1.4.tar.gz

RUN ruby -v && gem -v

WORKDIR /root
RUN git clone https://github.com/pwndbg/pwndbg
WORKDIR /root/pwndbg
RUN git checkout 2023.03.19
RUN ./setup.sh

RUN pip3 install --upgrade pip
RUN pip3 install pwntools
RUN gem install one_gadget
WORKDIR /root

