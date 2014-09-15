#!/bin/bash

# Build and install Json-C https://github.com/json-c/json-c
d=/usr/local/src/json-c
sudo git clone https://github.com/json-c/json-c.git $d
cd $d
sudo git checkout json-c-${JSON_C_VER}
sudo ./autogen.sh
sudo ./configure
sudo make
sudo make install
