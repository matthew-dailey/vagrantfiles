#!/bin/bash

folly_deps='
g++
automake
autoconf
autoconf-archive
libtool
libboost-all-dev
libevent-dev
libdouble-conversion-dev
libgoogle-glog-dev
libgflags-dev
liblz4-dev
liblzma-dev
libsnappy-dev
make
zlib1g-dev
binutils-dev
libjemalloc-dev
libssl-dev
libiberty-dev
'

devtools='
vim
git
unzip
'

sudo apt-get install -y \
    $deps \
    $devtools

mkdir /dev
cd /dev && git clone https://github.com/facebook/folly.git
cd /dev/folly/folly && \
    autoreconf -ivf && \
    ./configure && \
    make && \
    make check && \
    sudo make install
