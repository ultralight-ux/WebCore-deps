cmake_minimum_required(VERSION 3.4.0)

project(ICU C CXX)

if (PLATFORM_TOOLCHAIN)
    include(${PLATFORM_TOOLCHAIN})
endif ()

set_property(DIRECTORY . PROPERTY FOLDER "ICU")

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake")

include(Common)

if (NOT CMAKE_BUILD_TYPE)
    if (${BUILD_DBG})
        set(CMAKE_BUILD_TYPE Debug)
    else ()
        set(CMAKE_BUILD_TYPE Release)
    endif ()
endif ()

# Set the port if not already set
if (NOT PORT)
    if (UNIX)
        if (APPLE)
            set(PORT UltralightMac)
        else ()
            set(PORT UltralightLinux)
        endif ()
    elseif (CMAKE_SYSTEM_NAME MATCHES "Windows")
        set(PORT UltralightWin)
    else ()
        message(FATAL_ERROR "Unknown OS '${CMAKE_SYSTEM_NAME}'")
    endif ()
endif ()

if (PORT MATCHES "UltralightLinux")

elseif (PORT MATCHES "UltralightMac")
    if (${BUILD_DBG})
        # Debug Config
        # set(EXTRA_FLAGS "-arch x86_64 -g -DNDEBUG -std=gnu++14 -stdlib=libc++ -Wno-trigraphs -fno-exceptions -Wno-missing-field-initializers -Wnon-virtual-dtor -Wno-overloaded-virtual -Wno-exit-time-destructors -Wno-missing-braces -Wparentheses -Wswitch -Wunused-function -Wno-unused-label -Wno-unused-parameter -Wunused-variable -Wunused-value -Wempty-body -Wuninitialized -Wno-unknown-pragmas -Wno-shadow -Wno-four-char-constants -Wno-conversion -Wconstant-conversion -Wint-conversion -Wbool-conversion -Wenum-conversion -Wno-float-conversion -Wnon-literal-null-conversion -Wobjc-literal-conversion -Wsign-compare -Wno-shorten-64-to-32 -Wno-c++11-extensions -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.13.sdk -Wdeprecated-declarations -Winvalid-offsetof -fvisibility=hidden -fno-threadsafe-statics -Wno-sign-conversion -Winfinite-recursion -Wmove -Wno-comma -Wblock-capture-autoreleasing -Wno-strict-prototypes -Wno-nonportable-include-path -frtti")
        set(EXTRA_FLAGS "-g -DNDEBUG -std=gnu++14 -stdlib=libc++ -fno-exceptions")
    else ()
        # Release Config
        # set(EXTRA_FLAGS "-arch x86_64 -march=core2 -mtune=haswell -O3 -DNDEBUG -std=gnu++14 -stdlib=libc++ -Wno-trigraphs -fno-exceptions -Wno-missing-field-initializers -Wnon-virtual-dtor -Wno-overloaded-virtual -Wno-exit-time-destructors -Wno-missing-braces -Wparentheses -Wswitch -Wunused-function -Wno-unused-label -Wno-unused-parameter -Wunused-variable -Wunused-value -Wempty-body -Wuninitialized -Wno-unknown-pragmas -Wno-shadow -Wno-four-char-constants -Wno-conversion -Wconstant-conversion -Wint-conversion -Wbool-conversion -Wenum-conversion -Wno-float-conversion -Wnon-literal-null-conversion -Wobjc-literal-conversion -Wsign-compare -Wno-shorten-64-to-32 -Wno-c++11-extensions -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.13.sdk -Wdeprecated-declarations -Winvalid-offsetof -fvisibility=hidden -fno-threadsafe-statics -Wno-sign-conversion -Winfinite-recursion -Wmove -Wno-comma -Wblock-capture-autoreleasing -Wno-strict-prototypes -Wno-nonportable-include-path -frtti")
        set(EXTRA_FLAGS "-O3 -DNDEBUG -std=gnu++14 -stdlib=libc++ -fno-exceptions")
    endif ()

    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${EXTRA_FLAGS}")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${EXTRA_FLAGS}")

elseif (PORT MATCHES "UltralightWin")
    add_definitions(-DNOMINMAX -DUNICODE -D_UNICODE -D_WINDOWS -DWINVER=0x601 -D_HAS_EXCEPTIONS=0 -DU_PLATFORM_USES_ONLY_WIN32_API=1)

    if (MSVC)
        if (UWP_PLATFORM)
            add_definitions(-DUWP_PLATFORM) 
            add_compile_options(/EHa- /EHc- /EHs- /fp:except- /utf-8) 
        else ()
            add_compile_options(/EHa- /EHc- /EHs- /fp:except- /utf-8)
        endif ()
        
        # Use CRT security features
        add_definitions(-D_CRT_SECURE_NO_WARNINGS -D_CRT_SECURE_CPP_OVERLOAD_STANDARD_NAMES=1)
        
        if (${CMAKE_BUILD_TYPE} MATCHES Debug OR ${CMAKE_BUILD_TYPE} MATCHES RelWithDebInfo) 
        else ()
            add_compile_options(/O1 /Ob1 /GS /Gw)
        endif ()

        if (NOT ${CMAKE_GENERATOR} MATCHES "Ninja")
            link_directories("${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${CMAKE_BUILD_TYPE}")
            add_definitions(/MP)
        endif ()

        string(REGEX REPLACE "(/EH[a-z]+) " "\\1- " CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS}) # Disable C++ exceptions
        string(REGEX REPLACE "/EHsc$" "/EHs- /EHc- " CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS}) # Disable C++ exceptions
        #string(REGEX REPLACE "/W3" "/W4" CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS}) # Warnings are important

        foreach (flag_var
            CMAKE_C_FLAGS CMAKE_C_FLAGS_DEBUG CMAKE_C_FLAGS_RELEASE
            CMAKE_C_FLAGS_MINSIZEREL CMAKE_C_FLAGS_RELWITHDEBINFO
            CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE
            CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO)
            # Reset all project configurations to use /MD so we can override below
            string(REGEX REPLACE "/MT" "/MD" ${flag_var} "${${flag_var}}")
            string(REGEX REPLACE "/MDd" "/MD" ${flag_var} "${${flag_var}}")
            string(REGEX REPLACE "/D_DEBUG" "" ${flag_var} "${${flag_var}}")

            if (CMAKE_MSVC_RUNTIME_LIBRARY STREQUAL "MultiThreaded")
                string(REGEX REPLACE "/MD" "/MT" ${flag_var} "${${flag_var}}")
            elseif (CMAKE_MSVC_RUNTIME_LIBRARY STREQUAL "MultiThreadedDLL")
                # no-op, already /MD
            elseif(CMAKE_MSVC_RUNTIME_LIBRARY STREQUAL "MultiThreadedDebug")
                string(REGEX REPLACE "/MD" "/MTd" ${flag_var} "${${flag_var}}")
            elseif(CMAKE_MSVC_RUNTIME_LIBRARY STREQUAL "MultiThreadedDebugDLL")
                string(REGEX REPLACE "/MD" "/MDd" ${flag_var} "${${flag_var}}")
            else()
                message(FATAL_ERROR "Unknown MSVC runtime library: '${CMAKE_MSVC_RUNTIME_LIBRARY}'")
            endif()
        endforeach ()

        if (CMAKE_MSVC_RUNTIME_LIBRARY STREQUAL "MultiThreaded")
            message(STATUS "Building projects with MultiThreaded Static Runtime (/MT)")
        elseif (CMAKE_MSVC_RUNTIME_LIBRARY STREQUAL "MultiThreadedDLL")
            message(STATUS "Building projects with MultiThreaded DLL Runtime (/MD)")
        elseif(CMAKE_MSVC_RUNTIME_LIBRARY STREQUAL "MultiThreadedDebug")
            message(STATUS "Building projects with MultiThreaded Static Debug Runtime (/MTd)")
        elseif(CMAKE_MSVC_RUNTIME_LIBRARY STREQUAL "MultiThreadedDebugDLL")
            message(STATUS "Building projects with MultiThreaded DLL Debug Runtime (/MDd)")
        else()
            message(FATAL_ERROR "Unknown MSVC runtime library: '${CMAKE_MSVC_RUNTIME_LIBRARY}'")
        endif()
    endif ()

endif ()

add_definitions(-DU_ATTRIBUTE_DEPRECATED= -DU_STATIC_IMPLEMENTATION=1 -DU_DISABLE_RENAMING=1)

load_sources(SRC_COMMON "src/common")
load_sources(SRC_I18N "src/i18n")
load_sources(SRC_DATA "src/data")

include_directories("src/common" "src/i18n")

add_library(icuuc STATIC ${SRC_COMMON})
target_compile_definitions(icuuc PUBLIC -DU_COMMON_IMPLEMENTATION)

add_library(icuin STATIC ${SRC_I18N})
target_compile_definitions(icuin PUBLIC -DU_I18N_IMPLEMENTATION)

add_library(icudt STATIC ${SRC_DATA})

INSTALL(TARGETS icuuc icuin icudt
  RUNTIME DESTINATION "bin"
  LIBRARY DESTINATION "bin"
  ARCHIVE DESTINATION "lib"
)

INSTALL(DIRECTORY "src/common/unicode" DESTINATION "include")
INSTALL(DIRECTORY "src/i18n/unicode" DESTINATION "include")
INSTALL(FILES "data/icudt67l.dat" "data/icudt67l.dat_min" DESTINATION "bin")
