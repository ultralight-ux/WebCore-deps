cmake_minimum_required(VERSION 3.15.0)

# Read version from version.txt
file(STRINGS "${CMAKE_CURRENT_SOURCE_DIR}/version.txt" LIBPSL_VERSION)
string(STRIP "${LIBPSL_VERSION}" LIBPSL_VERSION)

project(libpsl VERSION ${LIBPSL_VERSION} LANGUAGES C)

# Parse version components
string(REPLACE "." ";" VERSION_LIST ${LIBPSL_VERSION})
list(GET VERSION_LIST 0 LIBPSL_VERSION_MAJOR)
list(GET VERSION_LIST 1 LIBPSL_VERSION_MINOR)
list(GET VERSION_LIST 2 LIBPSL_VERSION_PATCH)
math(EXPR LIBPSL_VERSION_NUMBER
     "(${LIBPSL_VERSION_MAJOR} << 16) | (${LIBPSL_VERSION_MINOR} << 8) | ${LIBPSL_VERSION_PATCH}")
string(REPLACE "." ";" LIBPSL_VERSION_NUMBER_HEX ${LIBPSL_VERSION})

# Find Python for generating suffixes_dafsa.h
find_package(Python3 COMPONENTS Interpreter)
if(NOT Python3_FOUND)
    find_package(Python COMPONENTS Interpreter)
    if(Python_FOUND)
        set(Python3_EXECUTABLE ${Python_EXECUTABLE})
    else()
        # Fallback: try to find python executable manually
        find_program(Python3_EXECUTABLE NAMES python3 python python2)
    endif()
endif()

if(NOT Python3_EXECUTABLE)
    message(FATAL_ERROR "Python interpreter not found. Required for generating suffixes_dafsa.h")
endif()

message(STATUS "Using Python: ${Python3_EXECUTABLE}")

# Platform-specific configuration checks
include(CheckIncludeFile)
include(CheckFunctionExists)
include(CheckCCompilerFlag)

check_include_file(alloca.h HAVE_ALLOCA_H)
check_include_file(unistd.h HAVE_UNISTD_H)
check_include_file(stdint.h HAVE_STDINT_H)
check_include_file(dirent.h HAVE_DIRENT_H)
check_function_exists(alloca HAVE_ALLOCA)
check_function_exists(strndup HAVE_STRNDUP)
check_function_exists(clock_gettime HAVE_CLOCK_GETTIME)
check_function_exists(fmemopen HAVE_FMEMOPEN)
check_function_exists(nl_langinfo HAVE_NL_LANGINFO)

# Check for visibility support
set(HAVE_VISIBILITY 0)
if(NOT MSVC)
    check_c_compiler_flag("-fvisibility=hidden" COMPILER_SUPPORTS_VISIBILITY)
    if(COMPILER_SUPPORTS_VISIBILITY)
        set(HAVE_VISIBILITY 1)
    endif()
endif()

# Configure config.h
configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/config.h.in"
    "${CMAKE_CURRENT_BINARY_DIR}/config.h"
    @ONLY
)

# Generate include/libpsl.h from template
configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/include/libpsl.h.in"
    "${CMAKE_CURRENT_BINARY_DIR}/include/libpsl.h"
    @ONLY
)

# Generate suffixes_dafsa.h from public suffix list
set(PSL_FILE "${CMAKE_CURRENT_SOURCE_DIR}/list/public_suffix_list.dat")
set(PSL_MAKE_DAFSA "${CMAKE_CURRENT_SOURCE_DIR}/src/psl-make-dafsa")
set(SUFFIXES_DAFSA_H "${CMAKE_CURRENT_BINARY_DIR}/suffixes_dafsa.h")

add_custom_command(
    OUTPUT ${SUFFIXES_DAFSA_H}
    COMMAND ${Python3_EXECUTABLE} ${PSL_MAKE_DAFSA} --output-format=cxx+ ${PSL_FILE} ${SUFFIXES_DAFSA_H}
    DEPENDS ${PSL_FILE} ${PSL_MAKE_DAFSA}
    COMMENT "Generating suffixes_dafsa.h from public suffix list"
    VERBATIM
)

# Source files
set(LIBPSL_SOURCES
    src/psl.c
    src/lookup_string_in_fixed_set.c
)

# Create static library
add_library(psl STATIC ${LIBPSL_SOURCES} ${SUFFIXES_DAFSA_H})

# Include directories
target_include_directories(psl
    PUBLIC
        $<BUILD_INTERFACE:${CMAKE_CURRENT_BINARY_DIR}/include>
        $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
        $<INSTALL_INTERFACE:include>
    PRIVATE
        ${CMAKE_CURRENT_BINARY_DIR}
        ${CMAKE_CURRENT_SOURCE_DIR}/src
)

# Compile definitions
target_compile_definitions(psl PRIVATE
    HAVE_CONFIG_H
    BUILDING_PSL
    ENABLE_BUILTIN=1
    PSL_DISTFILE=""
)

# Platform-specific settings
if(WIN32)
    target_compile_definitions(psl PUBLIC PSL_STATIC)
    target_link_libraries(psl PRIVATE ws2_32)

    if(MSVC)
        # MSVC-specific compatibility
        # Modern MSVC (VS2015+) and clang-cl have snprintf in the standard library
        # Only define the fallback for very old MSVC versions
        if(MSVC_VERSION AND MSVC_VERSION LESS 1900)
            target_compile_definitions(psl PRIVATE snprintf=_snprintf)
        endif()
        # Check for _alloca
        include(CheckSymbolExists)
        check_symbol_exists(_alloca "malloc.h" HAVE__ALLOCA)
        if(HAVE__ALLOCA)
            target_compile_definitions(psl PRIVATE alloca=_alloca)
        endif()
    endif()
endif()

# Set visibility hidden for non-MSVC compilers
if(HAVE_VISIBILITY AND NOT MSVC)
    target_compile_options(psl PRIVATE -fvisibility=hidden)
endif()

# Set C standard
set_target_properties(psl PROPERTIES
    C_STANDARD 99
    C_STANDARD_REQUIRED ON
    C_EXTENSIONS OFF
)

# Installation
install(TARGETS psl
    ARCHIVE DESTINATION lib
    LIBRARY DESTINATION lib
    RUNTIME DESTINATION bin
)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/include/libpsl.h
    DESTINATION include
)

# Generate pkg-config file
set(prefix ${CMAKE_INSTALL_PREFIX})
set(exec_prefix "\${prefix}")
set(libdir "\${exec_prefix}/lib")
set(includedir "\${prefix}/include")
set(VERSION ${LIBPSL_VERSION})

configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/libpsl.pc.in"
    "${CMAKE_CURRENT_BINARY_DIR}/libpsl.pc"
    @ONLY
)

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/libpsl.pc
    DESTINATION lib/pkgconfig
)
