#!/bin/bash

cat shell-${SH_VER}/logs/*

if [ -f compile-errors.log ]
  cat compile-errors.log
fi;
