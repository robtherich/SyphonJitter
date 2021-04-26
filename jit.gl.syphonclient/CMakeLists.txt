cmake_minimum_required(VERSION 3.0)
include(${CMAKE_CURRENT_SOURCE_DIR}/../script/max-pretarget.cmake)

include_directories( 
	"${MAX_SDK_INCLUDES}"
	"${MAX_SDK_JIT_INCLUDES}"
	"${SYPHON_DIR}"
)

add_library( 
	${PROJECT_NAME}
	MODULE
	"${CMAKE_CURRENT_SOURCE_DIR}/../Shared/SyphonNameboundClient.h"
	"${CMAKE_CURRENT_SOURCE_DIR}/../Shared/SyphonNameboundClient.m"
	"jit.gl.syphonclient.m"
	"max.jit.gl.syphonclient.m"

	${SYPHON_SRC}
)

target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/../Shared)

target_compile_definitions(${PROJECT_NAME} PRIVATE SYPHON_UNIQUE_CLASS_NAME_PREFIX=SyphonJitterClient)

include(${CMAKE_CURRENT_SOURCE_DIR}/../script/max-posttarget.cmake)
