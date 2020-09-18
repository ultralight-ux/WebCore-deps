SETLOCAL
cd /D %~dp0
if not exist "build_tmp\" mkdir "build_tmp"
cd "build_tmp"
cmake .. -G Ninja %CMAKE_FLAGS% -DWITH_CRT_DLL=ON -DWITH_SIMD=ON -DWITH_TURBOJPEG=OFF -DENABLE_SHARED=OFF -DCMAKE_SYSTEM_PROCESSOR=amd64
ninja
ninja install
cd ..
rmdir "build_tmp" /s/q