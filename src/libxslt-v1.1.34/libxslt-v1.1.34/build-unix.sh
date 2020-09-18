#!/bin/bash
cd $(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
mkdir -p build_tmp
cd build_tmp
cmake .. -G Ninja $CMAKE_FLAGS -DWITH_TRIO=OFF -DWITH_XSLT_DEBUG=OFF -DWITH_MEM_DEBUG=OFF -DWITH_DEBUGGER=OFF -DWITH_ICONV=OFF -DWITH_ZLIB=OFF -DWITH_CRYPTO=OFF -DWITH_MODULES=OFF -DLIBXML2_INCLUDE_DIR=$CMAKE_INSTALL_PREFIX/include -DLIBXML2_LIBRARY=$CMAKE_INSTALL_PREFIX/lib/libxml2.a
ninja
ninja install
cd ..
rm -rf build_tmp