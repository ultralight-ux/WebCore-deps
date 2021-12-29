# WebCore Dependencies

This repo contains instructions for building the dependencies for our WebCore port.

### Setting up on macOS

1. Install Xcode Command Line Tools (or the full Xcode package).
2. Download the macOS 10.14 Platform SDK from https://github.com/phracker/MacOSX-SDKs/releases and
   extract it to `/Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk`.
3. Install Homebrew (https://brew.sh/)
4. Run the following from the Terminal to setup the needed homebrew packages:

```
brew install cmake ninja nasm
```

## Building on Windows

You'll need:

 * Visual Studio 2019 (C++)
 * CMake
 * Ninja
 * NASM (https://www.nasm.us/)

At present, to build with Visual Studio, you need to run cmake from inside the
VS 2019 command prompt. Press `Start`, and search for `VS 2019`, and click on
`x64 Native Tools Command Prompt for VS 2019`, or a prompt named similar to
that.

Then, from the `x64 Native Tools Command Prompt for VS 2019`, change directories to this folder and run the following:

```
mkdir build
cd build
cmake .. -GNinja
ninja
ninja install
```
 
 ## Building on macOS/Linux
 
To build for macOS/Linux, you must have a recent version of Clang:

```
mkdir build
cd build
CC=clang CXX=clang++ cmake .. -GNinja
CC=clang CXX=clang++ ninja
ninja install
```

## Build products

Build products will be in `<build_dir>/out`.
