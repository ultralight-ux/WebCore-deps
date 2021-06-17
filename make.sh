#!/bin/bash

BUILD_DIR=build

export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

mkdir -p $BUILD_DIR
cd $BUILD_DIR
cmake .. -GNinja
ninja
cd ..
