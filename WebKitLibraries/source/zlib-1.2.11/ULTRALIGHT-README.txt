To build:

  For 64-bit:
    CFLAGS="-m64 -Os -fPIC" CC="clang" CXX="clang++" ./configure --static

  For 32-bit:
    CFLAGS="-m32 -Os -fPIC" CC="clang" CXX="clang++" ./configure --static

Build it:
  make

Build products (libz.a) will be in same source directory.

Install it so we can build libpng:

  sudo make install
