#!/bin/bash
cd $(cd -P -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
mkdir -p build_tmp
cd build_tmp

ICU_INSTALL_DIR="$(pwd)/build_install"
mkdir -p $ICU_INSTALL_DIR

PLATFORM_NAME=Linux
if [ "$(uname)" == "Darwin" ]; then
  PLATFORM_NAME=MacOSX
fi

../runConfigureICU $PLATFORM_NAME --enable-static --disable-shared --with-data-packaging=archive --disable-renaming --prefix=$ICU_INSTALL_DIR

make -j6
make install

cp $ICU_INSTALL_DIR/lib/libicui18n.a $CMAKE_INSTALL_PREFIX/lib
cp $ICU_INSTALL_DIR/lib/libicuuc.a $CMAKE_INSTALL_PREFIX/lib
cp $ICU_INSTALL_DIR/lib/libicudata.a $CMAKE_INSTALL_PREFIX/lib
cp -a $ICU_INSTALL_DIR/include/. $CMAKE_INSTALL_PREFIX/include

cd ..
rm -rf build_tmp