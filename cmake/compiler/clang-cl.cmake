if(DEFINED COMPILER_CLANG_CL_CMAKE_)
  return()
else()
  set(COMPILER_CLANG_CL_CMAKE_ 1)
endif()

# Search for clang-cl instead of cl
find_program(CMAKE_C_COMPILER clang-cl)
find_program(CMAKE_CXX_COMPILER clang-cl)

if(NOT CMAKE_C_COMPILER)
  message(FATAL_ERROR "Clang compiler 'clang-cl' not found! Please ensure LLVM is installed and 'clang-cl' is in your PATH.")
endif()

if(NOT CMAKE_CXX_COMPILER)
  message(FATAL_ERROR "Clang compiler 'clang-cl' not found! Please ensure LLVM is installed and 'clang-cl' is in your PATH.")
endif()

# Force CMake to use clang-cl for both C and C++ compilation
set(CMAKE_C_COMPILER "${CMAKE_C_COMPILER}" CACHE STRING "C compiler" FORCE)
set(CMAKE_CXX_COMPILER "${CMAKE_CXX_COMPILER}" CACHE STRING "C++ compiler" FORCE)
