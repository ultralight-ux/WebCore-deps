SETLOCAL
cd /D %~dp0
if not exist "build_tmp\" mkdir "build_tmp"
cd "build_tmp"
cmake .. -G Ninja %CMAKE_FLAGS% -DPNG_SHARED=OFF -DPNG_TESTS=OFF -DPNG_BUILD_ZLIB=ON -DZLIB_LIBRARY:STRING="%CMAKE_INSTALL_PREFIX%/lib/zlibstat.lib" -DZLIB_INCLUDE_DIR:STRING="%CMAKE_INSTALL_PREFIX%/include/"
ninja
ninja install
cd ..
rmdir "build_tmp" /s/q