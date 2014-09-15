#!/bin/bash

# Build and install Zephir https://github.com/phalcon/zephir
d=/usr/local/src/zephir
sudo mkdir $d
sudo chown $USER $d
git clone https://github.com/phalcon/zephir.git $d
cd $d
git checkout ${ZEPHIR_VER}
sudo ./install
sudo ln -s /usr/local/src/zephir/bin/zephir /usr/local/bin
