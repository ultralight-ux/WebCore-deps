#!/bin/bash
cd $(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
mkdir -p build_tmp
cd build_tmp
cmake .. -G Ninja $CMAKE_FLAGS -DBUILD_SHARED_LIBS=OFF
ninja
ninja install
cd ..
rm -rf build_tmp