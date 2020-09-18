SETLOCAL
cd /D %~dp0
if not exist "build_tmp\" mkdir "build_tmp"
cd "build_tmp"
cmake .. -G Ninja %CMAKE_FLAGS% -DFT_WITH_ZLIB=ON -DFT_WITH_BZIP2=OFF -DFT_WITH_PNG=ON -DFT_WITH_HARFBUZZ=OFF -DPNG_PNG_INCLUDE_DIR=%CMAKE_INSTALL_PREFIX%\include\libpng16 -DPNG_LIBRARY=%CMAKE_INSTALL_PREFIX%\lib\libpng16_static.lib -DZLIB_INCLUDE_DIR=%CMAKE_INSTALL_PREFIX%\include -DZLIB_LIBRARY=%CMAKE_INSTALL_PREFIX%\lib\zlibstat.lib
ninja
ninja install
cd ..
rmdir "build_tmp" /s/q