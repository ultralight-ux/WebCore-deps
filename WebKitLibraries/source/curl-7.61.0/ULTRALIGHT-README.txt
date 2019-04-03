Build requirements:
  You must have already built and installed openssl

To build:
  cd into source
  ./configure CFLAGS='-Os' CC='clang' CXX='clang++' --disable-shared --with-ssl=/usr/local/ssl
  make

Build products (libcurl.a) will be in: lib/.libs

