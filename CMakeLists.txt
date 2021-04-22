cmake_minimum_required(VERSION 3.0)

set(CMAKE_CONFIGURATION_TYPES Debug;Release)
set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_CXX_STANDARD 14)    # note: on linux we need c++17
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF) # for clang, gcc, this should use -std=gnu++11 instead of -std=c++11
set(CMAKE_VISIBILITY_INLINES_HIDDEN ON)
set(CMAKE_OPTIMIZE_DEPENDENCIES ON) # streamline static library dependencies

if (NOT CMAKE_OSX_ARCHITECTURES)
    set(CMAKE_OSX_ARCHITECTURES x86_64)
endif()
set(CMAKE_OSX_DEPLOYMENT_TARGET 10.11)
add_compile_definitions("MAC_VERSION=1")
enable_language(OBJC OBJCXX)
set(CMAKE_XCODE_GENERATE_SCHEME ON)


project(SyphonJitter VERSION 1.0.7 LANGUAGES C OBJC OBJCXX)

set(MAX_SDK_INCLUDES "${CMAKE_CURRENT_SOURCE_DIR}/max-sdk/source/c74support/max-includes")
set(MAX_SDK_MSP_INCLUDES "${CMAKE_CURRENT_SOURCE_DIR}/max-sdk/source/c74support/msp-includes")
set(MAX_SDK_JIT_INCLUDES "${CMAKE_CURRENT_SOURCE_DIR}/max-sdk/source/c74support/jit-includes")
set(SYPHON_DIR "${CMAKE_CURRENT_SOURCE_DIR}/Syphon-Framework")

#add_subdirectory("Syphon-Framework")
add_subdirectory("jit.gl.syphonclient")
add_subdirectory("jit.gl.syphonserver")