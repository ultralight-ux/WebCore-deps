SETLOCAL
cd /D %~dp0
if not exist "build_tmp\" mkdir "build_tmp"
cd "build_tmp"
cmake .. -G Ninja %CMAKE_FLAGS% -DLIBRESSL_APPS=OFF -DLIBRESSL_TESTS=OFF
ninja
ninja install
cd ..
rmdir "build_tmp" /s/q