#!/bin/bash
cd $(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
mkdir -p build_tmp
cd build_tmp
ICU_INSTALL_DIR="$(pwd)/build_install"
mkdir -p $ICU_INSTALL_DIR
../runConfigureICU MacOSX --enable-static --disable-shared --with-data-packaging=archive --disable-renaming --prefix=$ICU_INSTALL_DIR
make -j6
make install
cp $ICU_INSTALL_DIR/lib/libicui18n.a $CMAKE_INSTALL_PREFIX/lib
cp $ICU_INSTALL_DIR/lib/libicuuc.a $CMAKE_INSTALL_PREFIX/lib
cp -r $ICU_INSTALL_DIR/include/ $CMAKE_INSTALL_PREFIX/include
cd ..
rm -rf build_tmp