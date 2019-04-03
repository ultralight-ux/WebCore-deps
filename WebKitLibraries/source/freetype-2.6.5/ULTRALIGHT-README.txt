To build:

  ./configure --disable-shared --with-zlib=no --with-bzip2=no CPPFLAGS='-fPIC' CXXFLAGS='-Os' CFLAGS='-Os' CC='clang' CXX='clang++'
  make

Install it so we can build harfbuzz:
  sudo make install

Output will be in:
  /objs/.libs/libfreetype.a
