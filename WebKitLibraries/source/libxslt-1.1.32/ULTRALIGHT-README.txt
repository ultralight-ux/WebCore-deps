Build requirements:
  Make sure LIBTOOL is installed:
    sudo apt install libtool

To build:
  ./autogen.sh --enable-static --disable-shared --with-python=no CPPFLAGS='-fPIC' CXXFLAGS='-Os' CFLAGS='-Os' CC='clang' CXX='clang++'
  make

Build products (libxslt.a) will be in libxslt/.libs
