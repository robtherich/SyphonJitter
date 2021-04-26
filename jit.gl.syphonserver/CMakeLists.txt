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

	"jit.gl.syphonserver.m"
	"max.jit.gl.syphonserver.c"

	${SYPHON_SRC}
)

target_compile_definitions(${PROJECT_NAME} PRIVATE SYPHON_UNIQUE_CLASS_NAME_PREFIX=SyphonJitterServer)

include(${CMAKE_CURRENT_SOURCE_DIR}/../script/max-posttarget.cmake)
