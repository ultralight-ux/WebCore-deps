#!/bin/bash
cd $(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
mkdir -p build_tmp
cd build_tmp
cmake .. -G Ninja $CMAKE_FLAGS -DPNG_SHARED=OFF -DPNG_TESTS=OFF -DPNG_BUILD_ZLIB=ON -DZLIB_LIBRARY:STRING="$CMAKE_INSTALL_PREFIX/lib/libz.a" -DZLIB_INCLUDE_DIR:STRING="$CMAKE_INSTALL_PREFIX/include/"
ninja
ninja install
cd ..
rm -rf build_tmp