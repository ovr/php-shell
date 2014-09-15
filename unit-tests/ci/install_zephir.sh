#!/bin/bash

# Build and install Zephir https://github.com/phalcon/zephir
d=/usr/local/src/zephir
sudo mkdir $d
sudo chown $USER $d
git clone https://github.com/phalcon/zephir.git $d
cd $d
git checkout ${ZEPHIR_VER}
git submodule update --init

# json-c
cd json-c
sh autogen.sh
./configure
make && sudo make install

# zephir
cd ..
sudo ./install -c
