cmake_minimum_required(VERSION 3.0)

set(CMAKE_CONFIGURATION_TYPES Debug;Release)
set(CMAKE_POSITION_INDEPENDENT_CODE OFF)
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

set(CMAKE_PDB_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/pdb/$<CONFIG>")
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/libs/$<CONFIG>") # archive as in: static library

if (CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    unset(WarningFlags)

    # convert some warnings to errors
    list(APPEND WarningFlags -Werror=implicit-function-declaration -Werror-nonportable-include-path -Werror-incompatible-pointer-types)

    list(APPEND WarningFlags -Wno-deprecated-declarations -Wno-parentheses
        -Wno-int-conversion -Wno-pointer-sign -Wno-unused-value -Wno-unused-function -Wno-extra-tokens -Wno-c++11-extensions -Wno-switch -Wno-compare-distinct-pointer-types
        -Wno-format-security -Wno-varargs -Wno-constant-logical-operand -Wno-unsequenced -Wno-invalid-source-encoding
        -Wno-tautological-constant-out-of-range-compare -Wno-ignored-qualifiers -Wno-deprecated -Wno-objc-multiple-method-names
        -Wno-enum-conversion -Wno-tautological-pointer-compare -Wno-constant-conversion -Wno-unused-variable)

    # these can be silenced via patches
    list(APPEND WarningFlags -Wno-format -Wno-delete-non-virtual-dtor -Wno-macro-redefined -Wno-empty-body -Wno-null-conversion
        -Wno-absolute-value -Wno-non-literal-null-conversion -Wno-unknown-pragmas)

    # these warnings are a little scary!
    list(APPEND WarningFlags -Wno-pointer-bool-conversion -Wno-address-of-packed-member -Wno-writable-strings
        -Wno-unknown-escape-sequence -Wno-constant-logical-operand -Wno-nonnull -Wno-int-to-pointer-cast)

    check_cxx_compiler_flag(-Wargument-outside-range HasArgumentOutsideRange)
    if(HasArgumentOutsideRange)
        list(APPEND WarningFlags -Wno-argument-outside-range)
    endif()

    list(APPEND WarningFlags -Wno-deprecated-register) # eigen workarounds

    check_cxx_compiler_flag(-Wpragma-pack HasPragmaPack)
    if (HasPragmaPack)
        list(APPEND WarningFlags -Wno-pragma-pack) # vst3 workarounds
    endif()

    foreach (flags CMAKE_C_FLAGS CMAKE_CXX_FLAGS CMAKE_OBJC_FLAGS CMAKE_OBJCXX_FLAGS)
        list(APPEND ${flags} ${WarningFlags})
    endforeach()
endif()

foreach (flags CMAKE_C_FLAGS CMAKE_CXX_FLAGS CMAKE_C_FLAGS_DEBUG CMAKE_CXX_FLAGS_DEBUG
               CMAKE_OBJC_FLAGS CMAKE_OBJCXX_FLAGS
               CMAKE_STATIC_LINKER_FLAGS CMAKE_EXE_LINKER_FLAGS CMAKE_MODULE_LINKER_FLAGS)
    string (REPLACE ";" " " ${flags} "${${flags}}")
endforeach()

project(SyphonJitter VERSION 1.0.7 LANGUAGES C OBJC OBJCXX)

set(MAX_SDK_INCLUDES "${CMAKE_CURRENT_SOURCE_DIR}/max-sdk/source/c74support/max-includes")
set(MAX_SDK_MSP_INCLUDES "${CMAKE_CURRENT_SOURCE_DIR}/max-sdk/source/c74support/msp-includes")
set(MAX_SDK_JIT_INCLUDES "${CMAKE_CURRENT_SOURCE_DIR}/max-sdk/source/c74support/jit-includes")
set(SYPHON_DIR "${CMAKE_CURRENT_SOURCE_DIR}/Syphon-Framework")

#add_subdirectory("Syphon-Framework")
add_subdirectory("jit.gl.syphonclient")
add_subdirectory("jit.gl.syphonserver")