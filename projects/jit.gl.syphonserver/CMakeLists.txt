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

	"jit.gl.syphonserver.m"
	"max.jit.gl.syphonserver.c"

	${SYPHON_SRC}
)

target_compile_definitions(${PROJECT_NAME} PRIVATE SYPHON_UNIQUE_CLASS_NAME_PREFIX=SyphonJitterServer)

include(${CMAKE_CURRENT_SOURCE_DIR}/../syphon-posttarget.cmake)
include(${C74_SCRIPT_DIR}/max-posttarget.cmake)
