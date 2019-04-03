
To build:

  ./configure --enable-static --disable-shared CPPFLAGS='-fPIC' CXXFLAGS='-Os' CFLAGS='-Os' CC='clang' CXX='clang++'
  make

Build products (libpng16.a) will be in .libs directory
