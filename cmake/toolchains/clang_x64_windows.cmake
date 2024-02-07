if (DEFINED CLANG_X64_WINDOWS_CMAKE)
  return ()
else ()
  set (CLANG_X64_WINDOWS_CMAKE 1)
endif ()

include(${CMAKE_CURRENT_LIST_DIR}/../common.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../compiler/clang-cl.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/../compiler/uasm.cmake)
include(add_cache_flag)
include(msvc_runtime_library_to_meson_flags)
include(msvc_runtime_library_to_msvc_flags)


set(CMAKE_SYSTEM "Windows-10.0.19043")
set(CMAKE_SYSTEM_NAME "Windows")
set(CMAKE_SYSTEM_VERSION "10.0.19043")
set(CMAKE_SYSTEM_PROCESSOR "AMD64")
if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Windows")
  set(CMAKE_CROSSCOMPILING FALSE)
else()
  set(CMAKE_CROSSCOMPILING TRUE)
endif()
set(CMAKE_POLICY_DEFAULT_CMP0091 NEW)
set(PORT "UltralightWin" CACHE STRING "The WebKit port to build.")


message(STATUS "MSVC runtime library: '${CMAKE_MSVC_RUNTIME_LIBRARY}'")

# Set up Skia C flags
set(UL_SKIA_CFLAGS -march=nehalem)
msvc_runtime_library_to_msvc_flags(UL_SKIA_CFLAGS ${CMAKE_MSVC_RUNTIME_LIBRARY})

get_filename_component(WIN_PLATFORM_DEFINES_H "win_platform_defines.h" REALPATH BASE_DIR "${CMAKE_CURRENT_LIST_DIR}")

add_cache_flag(CMAKE_C_FLAGS_INIT "/FI${WIN_PLATFORM_DEFINES_H}")                       
add_cache_flag(CMAKE_CXX_FLAGS_INIT "/FI${WIN_PLATFORM_DEFINES_H}")
