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

set -e

# install dependencies
sudo apt-get update
sudo apt-get install -y \
    $folly_deps \
    $devtools

# setup workspace
sudo mkdir -p /workspace 
sudo chown vagrant:vagrant /workspace

# clone folly
cd /workspace && git clone https://github.com/facebook/folly.git

# extract gtest into folly's test dir
wget https://googletest.googlecode.com/files/gtest-1.7.0.zip -O /workspace/gtest-1.7.0.zip
unzip /workspace/gtest-1.7.0.zip -d /workspace/folly/folly/test/

# build, test, install
cd /workspace/folly/folly && \
    autoreconf -ivf && \
    ./configure && \
    make && \
    make check && \
    sudo make install
