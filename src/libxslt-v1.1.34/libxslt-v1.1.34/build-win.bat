SETLOCAL
cd /D %~dp0
if not exist "build_tmp\" mkdir "build_tmp"
cd "build_tmp"
cmake .. -G Ninja %CMAKE_FLAGS% -DWITH_TRIO=OFF -DWITH_XSLT_DEBUG=OFF -DWITH_MEM_DEBUG=OFF -DWITH_DEBUGGER=OFF -DWITH_ICONV=OFF -DWITH_ZLIB=OFF -DWITH_CRYPTO=OFF -DWITH_MODULES=OFF -DLIBXML2_INCLUDE_DIR=%CMAKE_INSTALL_PREFIX%/include -DLIBXML2_LIBRARY=%CMAKE_INSTALL_PREFIX%/lib/xml2.lib
ninja
ninja install
cd ..
rmdir "build_tmp" /s/q