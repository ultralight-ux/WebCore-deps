To build:

  ./configure --enable-static --disable-shared --with-python=no CPPFLAGS='-fPIC' CXXFLAGS='-Os' CFLAGS='-Os' CC='clang' CXX='clang++'
  make

Install it so we can build libxslt:
  sudo make install

Build products (libxml2.a) will be in .libs
