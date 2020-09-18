#!/bin/bash
cd $(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
mkdir -p build_tmp
cd build_tmp
cmake .. -G Ninja $CMAKE_FLAGS -DFT_WITH_ZLIB=ON -DFT_WITH_BZIP2=OFF -DFT_WITH_PNG=ON -DFT_WITH_HARFBUZZ=OFF -DPNG_PNG_INCLUDE_DIR=$CMAKE_INSTALL_PREFIX/include/libpng16 -DPNG_LIBRARY=$CMAKE_INSTALL_PREFIX/lib/libpng16.a -DZLIB_INCLUDE_DIR=$CMAKE_INSTALL_PREFIX/include -DZLIB_LIBRARY=$CMAKE_INSTALL_PREFIX/lib/libz.a
ninja
ninja install
cd ..
rm -rf build_tmp