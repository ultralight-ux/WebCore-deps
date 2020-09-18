#!/bin/bash
cd $(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
mkdir -p build_tmp
cd build_tmp
cmake .. -G Ninja $CMAKE_FLAGS -DHB_HAVE_FREETYPE=ON -DHB_HAVE_ICU=ON -DHB_BUILD_UTILS=OFF -DHB_BUILD_SUBSET=OFF -DHB_BUILD_TESTS=OFF -DFREETYPE_INCLUDE_DIRS=$CMAKE_INSTALL_PREFIX/include -DFREETYPE_LIBRARY=$CMAKE_INSTALL_PREFIX/lib/libfreetype.a -DICU_ROOT=$CMAKE_INSTALL_PREFIX
ninja
ninja install
cd ..
rm -rf build_tmp