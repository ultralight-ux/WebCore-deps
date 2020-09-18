#!/bin/bash
cd $(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
mkdir -p build_tmp
cd build_tmp
cmake .. -G Ninja $CMAKE_FLAGS -DLIBRESSL_APPS=OFF -DLIBRESSL_TESTS=OFF
ninja
ninja install
cd ..
rm -rf build_tmp