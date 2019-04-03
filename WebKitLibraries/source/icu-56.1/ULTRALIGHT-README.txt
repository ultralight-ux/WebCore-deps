Before you build:
  Copy icudt56l.dat into icu/source/data/in and replace the existing file.

To build on mac/linux:
  cd into icu/source
  ./configure --enable-static --disable-shared --disable-dyload --disable-renaming CPPFLAGS='-fPIC' CXXFLAGS='-Os' CFLAGS='-Os' CC='clang' CXX='clang++'
  make

Install it so we can build Harfbuzz:
  sudo make install

Build products will be in icu/source/lib
