#!/bin/bash

# Build and install Zephir https://github.com/phalcon/zephir
d=/usr/local/src/zephir
sudo git clone https://github.com/phalcon/zephir.git $d
cd $d
sudo git checkout ${ZEPHIR_VER}
sudo ./install
sudo ln -s /usr/local/src/zephir/bin/zephir /usr/local/bin
