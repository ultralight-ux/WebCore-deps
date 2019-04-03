To build on linux:
  cd into source

  For 64-bit:
    ./Configure no-shared linux-x86_64-clang -fPIC -Os
  For 32-bit:
    CC=clang CXX=clang++ ./Configure no-shared linux-elf -fPIC -Os
  make

Install it so we can build cURL later:
  sudo make install

Build products (libssl.a and libcrypto.a) will be in same source directory
