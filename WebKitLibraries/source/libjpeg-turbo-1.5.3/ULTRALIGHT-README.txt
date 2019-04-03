Before you build, make sure nasm is installed:
  sudo apt install nasm

To build:

  ./configure --enable-static --disable-shared CPPFLAGS='-fPIC' CXXFLAGS='-Os' CFLAGS='-Os' CC='clang' CXX='clang++'
  make

Build products (libjpeg.a) will be in .libs
