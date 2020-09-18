SETLOCAL
cd /D %~dp0
if not exist "build_tmp\" mkdir "build_tmp"
cd "build_tmp"
cmake .. -G Ninja %CMAKE_FLAGS% -DBROTLI_DISABLE_CLI=ON -DBROTLI_DISABLE_TESTS=ON
ninja
ninja install
cd ..
rmdir "build_tmp" /s/q