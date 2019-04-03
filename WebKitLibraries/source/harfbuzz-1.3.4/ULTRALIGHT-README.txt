Before you build:

  Build and install freetype

  Make sure pkg-config is installed otherwise it won't be able to find freetype:
    sudo apt install pkg-config

To build:

  ./configure --enable-static --disable-shared --with-freetype=yes --with-icu=yes --with-cairo=no --with-gobject=no --with-glib=no --with-fontconfig=no CPPFLAGS='-fPIC -DU_DISABLE_RENAMING=1 -DU_STATIC_IMPLEMENTATION=1' CXXFLAGS='-Os' CFLAGS='-Os' CC='clang' CXX='clang++'
  make

Build products (libharfbuzz.a and libharfbuzz-icu.a) will be in src/.libs
