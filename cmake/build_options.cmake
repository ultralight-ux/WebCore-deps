set(CMAKE_BUILD_TYPE "Release"                            CACHE STRING  "Choose the type of build.")
set(CMAKE_INSTALL_PREFIX ${CMAKE_CURRENT_BINARY_DIR}/out  CACHE PATH    "The path to install to.")
set(ALLINONE_BUILD OFF                                    CACHE BOOL    "Whether or not we are building all modules monolithically.")
set(UL_GENERATE_SDK OFF                                   CACHE BOOL    "Whether or not to generate a compressed SDK package from the build.")
set(UL_ENABLE_STATIC_BUILD OFF                            CACHE BOOL    "Whether or not to link the library statically (otherwise, will be linked dynamically).")
set(UL_ENABLE_VIDEO OFF                                   CACHE BOOL    "Whether or not to enable video/audio via GStreamer/FFmpeg.")
set(UL_ENABLE_JIT ON                                      CACHE BOOL    "Whether or not to enable JavaScript Just-In-Time compilation.")
set(UL_ENABLE_MIMALLOC ON                                 CACHE BOOL    "Whether or not to enable the high-performance mi-malloc allocator.")
set(UL_ENABLE_TESTS ON                                    CACHE BOOL    "Whether or not to enable test applications.")
set(UL_ENABLE_MEMORY_STATS OFF                            CACHE BOOL    "(Windows only) Whether or not to enable runtime memory stats gathering.")
set(UL_PROFILE_PERFORMANCE OFF                            CACHE BOOL    "Whether or not to enable runtime performance profiling via Tracy.")
set(UL_PROFILE_MEMORY OFF                                 CACHE BOOL    "(Windows only) Whether or not to enable runtime memory profiling via Tracy.")
set(UL_CALLSTACK_DEPTH "8"                                CACHE STRING  "The max callstack depth to trace when profiling memory." )
set(UL_D3D_DRIVER "d3d11"                                 CACHE STRING  "(Windows only) The type of D3D driver to use (either 'd3d11' or 'd3d12').")
set(UL_MSYS2_PATH "C:\\tools\\msys64\\msys2_shell.cmd"    CACHE PATH    "(Windows only) The path to the MSYS2 shell script.")
set(UL_LLVM_PATH "C:\\Program Files\\LLVM"                CACHE PATH    "(Windows only) The path to your LLVM install.")
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDLL"         CACHE STRING  "(Windows only) The MSVC runtime library to use.")
set(CMAKE_OSX_DEPLOYMENT_TARGET "10.14"                   CACHE STRING  "(macOS only) The minimum macOS deployment target.")

set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
set_property(CACHE CMAKE_MSVC_RUNTIME_LIBRARY PROPERTY STRINGS "MultiThreaded" "MultiThreadedDLL" "MultiThreadedDebug" "MultiThreadedDebugDLL")
set_property(CACHE UL_D3D_DRIVER PROPERTY STRINGS "d3d11" "d3d12")
