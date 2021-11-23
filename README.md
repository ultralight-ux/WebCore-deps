# WebCore Dependencies

This repo contains instructions for building the dependencies for our WebCore port.

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
 
To build for macOS/Linux:

```
mkdir build
cd build
cmake .. -GNinja
ninja
ninja install
```

## Build products

Build products will be in `<build_dir>/out`.
