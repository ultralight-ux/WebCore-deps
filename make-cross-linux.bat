@echo off
SETLOCAL

CALL :NORMALIZEPATH "."
SET ROOT_DIR=%RETVAL%

set "DIRNAME=build-cross-linux"

set "FLAGS=-GNinja"

echo Using Clang-based Linux x86_64 Toolchain
set TOOLCHAIN_PATH="%ROOT_DIR%\cmake\CrossLinuxX64Toolchain.cmake"
set "FLAGS=%FLAGS% -DCMAKE_TOOLCHAIN_FILE=%TOOLCHAIN_PATH%"

if not exist %DIRNAME% mkdir %DIRNAME%
cd %DIRNAME%

cmake .. %FLAGS%
ninja
cd ..

:: ========== FUNCTIONS ==========
EXIT /B

:NORMALIZEPATH
  SET RETVAL=%~f1
  EXIT /B