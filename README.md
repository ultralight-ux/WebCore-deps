# WebCore Dependencies

This repo contains instructions for building the dependencies for our WebCore port.

## Building on Windows

You'll need:

 * Visual Studio 2019 (C++)
 * CMake
 * Ninja
 * NASM (https://www.nasm.us/)
 
To build the dependencies:
 
 1. Open `/src/icu4c-67_1-src/icu/source/allinone/allinone.sln` in Visual Studio and build the 'common' and 'i18n' projects.
 2. Run `make-win-msvc-2019.bat` to build the rest of the dependencies.
 
 ## Building on macOS/Linux
 
 You'll need:
 
  * Clang toolchain
  * CMake
  * Ninja
  
To build the dependencies:
  
1. Run `make-unix-clang.sh`
 
 
 
