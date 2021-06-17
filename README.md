# WebCore Dependencies

This repo contains instructions for building the dependencies for our WebCore port.

## Building on Windows

You'll need:

 * Visual Studio 2019 (C++)
 * CMake
 * Ninja
 * NASM (https://www.nasm.us/)
 
To build the dependencies:
 
 1. Run `make-win-msvc-2019.bat`, results will be in `build-win-msvc-2019/out`
 
 ## Building on macOS/Linux
 
 You'll need:
 
  * Clang / C++ toolchain
  * CMake
  * Ninja
  
To build the dependencies:
  
1. Run `make.sh`, results will be in `build/out` 
