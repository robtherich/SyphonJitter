cmake_minimum_required(VERSION 3.0)
include(${C74_SCRIPT_DIR}/max-pretarget.cmake)

# overwrite from sdk scripts
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/../../Syphon/externals")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")

include_directories( 
	"${MAX_SDK_INCLUDES}"
	"${MAX_SDK_JIT_INCLUDES}"
)

add_library( 
	${PROJECT_NAME}
	MODULE
	"${SYPHON_SHARED_DIR}/SyphonNameboundClient.h"
	"${SYPHON_SHARED_DIR}/SyphonNameboundClient.m"
	"jit.gl.syphonclient.m"
	"max.jit.gl.syphonclient.m"

	${SYPHON_SRC}
)

target_include_directories(${PROJECT_NAME} PRIVATE ${SYPHON_SHARED_DIR})
target_compile_definitions(${PROJECT_NAME} PRIVATE SYPHON_UNIQUE_CLASS_NAME_PREFIX=SyphonJitterClient)

include(${CMAKE_CURRENT_SOURCE_DIR}/../syphon-posttarget.cmake)
include(${C74_SCRIPT_DIR}/max-posttarget.cmake)
