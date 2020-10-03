@echo off
SETLOCAL

SET BUILD_DIR=build-win-msvc-2019

IF NOT EXIST %BUILD_DIR% MKDIR %BUILD_DIR%

CALL :NORMALIZEPATH "./%BUILD_DIR%"
SET CMAKE_INSTALL_PREFIX=%RETVAL%

CALL :NORMALIZEPATH "./src"
SET SRC_DIR=%RETVAL%

SET ICU_DIR=src\icu4c-67_1-src\icu

IF NOT EXIST "%ICU_DIR%\lib64\icuuc.lib" CALL :EXIT_NO_ICU
IF NOT EXIST "%ICU_DIR%\lib64\icuin.lib" CALL :EXIT_NO_ICU

echo Copying ICU build files to out directory.
XCOPY /Q /Y "%ICU_DIR%\lib64\icuuc.lib" "%CMAKE_INSTALL_PREFIX%\lib\"
XCOPY /Q /Y "%ICU_DIR%\lib64\icuin.lib" "%CMAKE_INSTALL_PREFIX%\lib\"
XCOPY /E /Q /Y "src\icu-data" "%CMAKE_INSTALL_PREFIX%\bin\"
XCOPY /E /Q /Y "%ICU_DIR%\include" "%CMAKE_INSTALL_PREFIX%\include\"

CALL "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvarsall.bat" amd64

SET CMAKE_BUILD_TYPE=MinSizeRel
set PLATFORM_DEFINES_HEADER="%SRC_DIR%\WinPlatformDefines.h"
set MSVC_FLAGS="/Zc:inline /DWINDOWS_DESKTOP_PLATFORM=1 /FI %PLATFORM_DEFINES_HEADER%"
SET "CMAKE_FLAGS=-DCMAKE_BUILD_TYPE=%CMAKE_BUILD_TYPE% -DCMAKE_INSTALL_PREFIX=%CMAKE_INSTALL_PREFIX% -DCMAKE_CXX_FLAGS=%MSVC_FLAGS% -DCMAKE_C_FLAGS=%MSVC_FLAGS%"

CALL "src\zlib-1.2.11\build-win.bat"
CALL "src\libpng-1.6.37\build-win.bat"
CALL "src\libjpeg-turbo-2.0.4\libjpeg-turbo-2.0.4\build-win.bat"
CALL "src\libxml2-v2.9.10\libxml2-v2.9.10\build-win.bat"
CALL "src\libxslt-v1.1.34\libxslt-v1.1.34\build-win.bat"
CALL "src\brotli-1.0.7\build-win.bat"
CALL "src\nghttp2-1.40.0\build-win.bat"
CALL "src\libressl-3.0.2\build-win.bat"
CALL "src\curl-7.69.1\build-win.bat"
CALL "src\freetype-2.10.1\build-win.bat"
CALL "src\harfbuzz-2.6.4\build-win.bat"

:: ========== FUNCTIONS ==========
EXIT /B

:NORMALIZEPATH
  SET RETVAL=%~f1
  EXIT /B

:EXIT_NO_ICU
  echo.
  echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  echo Error: No ICU build detected, you need to build these projects manually on Windows.
  echo.
  echo Please open icu\source\allinone\allinone.sln in Visual Studio and build the
  echo   'common' and 'i18n' projects.
  echo.
  echo After you've built these projects, re-run this script.
  echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  call :HALT 2> nul

:HALT
() 
exit /b