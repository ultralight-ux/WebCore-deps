#!/bin/bash

BUILD_DIR=build-unix-clang

mkdir -p $BUILD_DIR

CMAKE_INSTALL_PREFIX=$(cd $BUILD_DIR; pwd)

echo Copying ICU build files to out directory.
mkdir -p "$BUILD_DIR/bin" && cp -r "src/icu-data/" "$BUILD_DIR/bin"

export CC=/usr/bin/clang
export CXX=/usr/bin/clang++

CMAKE_BUILD_TYPE=MinSizeRel
CMAKE_FLAGS="-DCMAKE_BUILD_TYPE=$CMAKE_BUILD_TYPE -DCMAKE_INSTALL_PREFIX=$CMAKE_INSTALL_PREFIX"

(source "src/zlib-1.2.11/build-unix.sh")
(source "src/libpng-1.6.37/build-unix.sh")
(source "src/libjpeg-turbo-2.0.4/libjpeg-turbo-2.0.4/build-unix.sh")
(source "src/icu4c-67_1-src/icu/source/build-unix.sh")
(source "src/libxml2-v2.9.10/libxml2-v2.9.10/build-unix.sh")
(source "src/libxslt-v1.1.34/libxslt-v1.1.34/build-unix.sh")
(source "src/brotli-1.0.7/build-unix.sh")
(source "src/nghttp2-1.40.0/build-unix.sh")
(source "src/libressl-3.0.2/build-unix.sh")
(source "src/curl-7.69.1/build-unix.sh")
(source "src/freetype-2.10.1/build-unix.sh")
(source "src/harfbuzz-2.6.4/build-unix.sh")
