#!/bin/bash

cpp_deps='
g++
make
'

devtools='
vim
git
unzip
'

set -e

# install dependencies
sudo yum update -y
sudo yum install -y \
    $cpp_deps \
    $devtools
