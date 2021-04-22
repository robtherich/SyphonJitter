cmake_minimum_required(VERSION 3.0)
include(${CMAKE_CURRENT_SOURCE_DIR}/../script/max-pretarget.cmake)

include_directories( 
	"${MAX_SDK_INCLUDES}"
	"${MAX_SDK_JIT_INCLUDES}"
)

add_library( 
	${PROJECT_NAME}
	MODULE

	"jit.gl.syphonserver.m"
	"max.jit.gl.syphonserver.c"

	"${SYPHON_DIR}/Syphon.h"
	"${SYPHON_DIR}/SyphonBuildMacros.h"
	"${SYPHON_DIR}/SyphonCFMessageReceiver.h"
	"${SYPHON_DIR}/SyphonCFMessageSender.h"
	"${SYPHON_DIR}/SyphonCGL.h"
	"${SYPHON_DIR}/SyphonClient.h"
	"${SYPHON_DIR}/SyphonClientConnectionManager.h"
	"${SYPHON_DIR}/SyphonDispatch.h"
	"${SYPHON_DIR}/SyphonImage.h"
	"${SYPHON_DIR}/SyphonIOSurfaceImage.h"
	"${SYPHON_DIR}/SyphonIOSurfaceImageCore.h"
	"${SYPHON_DIR}/SyphonIOSurfaceImageLegacy.h"
	"${SYPHON_DIR}/SyphonMachMessageReceiver.h"
	"${SYPHON_DIR}/SyphonMachMessageSender.h"
	"${SYPHON_DIR}/SyphonMessageQueue.h"
	"${SYPHON_DIR}/SyphonMessageReceiver.h"
	"${SYPHON_DIR}/SyphonMessageSender.h"
	"${SYPHON_DIR}/SyphonMessaging.h"
	"${SYPHON_DIR}/SyphonOpenGLFunctions.h"
	"${SYPHON_DIR}/SyphonPrivate.h"
	"${SYPHON_DIR}/SyphonServer.h"
	"${SYPHON_DIR}/SyphonServerConnectionManager.h"
	"${SYPHON_DIR}/SyphonServerDirectory.h"
	"${SYPHON_DIR}/SyphonServerRenderer.h"
	"${SYPHON_DIR}/SyphonServerRendererCore.h"
	"${SYPHON_DIR}/SyphonServerRendererLegacy.h"
	"${SYPHON_DIR}/SyphonServerShader.h"
	"${SYPHON_DIR}/SyphonServerVertices.h"
	"${SYPHON_DIR}/SyphonShader.h"
	"${SYPHON_DIR}/SyphonVertices.h"

	"${SYPHON_DIR}/SyphonCFMessageReceiver.m"
	"${SYPHON_DIR}/SyphonCFMessageSender.m"
	"${SYPHON_DIR}/SyphonClient.m"
	"${SYPHON_DIR}/SyphonClientConnectionManager.m"
	"${SYPHON_DIR}/SyphonIOSurfaceImage.m"
	"${SYPHON_DIR}/SyphonIOSurfaceImageCore.m"
	"${SYPHON_DIR}/SyphonIOSurfaceImageLegacy.m"
	"${SYPHON_DIR}/SyphonImage.m"
	"${SYPHON_DIR}/SyphonMessageQueue.m"
	"${SYPHON_DIR}/SyphonMessageReceiver.m"
	"${SYPHON_DIR}/SyphonMessageSender.m"
	"${SYPHON_DIR}/SyphonMessaging.m"
	"${SYPHON_DIR}/SyphonPrivate.m"
	"${SYPHON_DIR}/SyphonServer.m"
	"${SYPHON_DIR}/SyphonServerConnectionManager.m"
	"${SYPHON_DIR}/SyphonServerDirectory.m"
	"${SYPHON_DIR}/SyphonServerRenderer.m"
	"${SYPHON_DIR}/SyphonServerRendererCore.m"
	"${SYPHON_DIR}/SyphonServerRendererLegacy.m"
	"${SYPHON_DIR}/SyphonServerShader.m"
	"${SYPHON_DIR}/SyphonServerVertices.m"
	"${SYPHON_DIR}/SyphonShader.m"
	"${SYPHON_DIR}/SyphonVertices.m"
	"${SYPHON_DIR}/SyphonCGL.c"
	"${SYPHON_DIR}/SyphonDispatch.c"
	"${SYPHON_DIR}/SyphonOpenGLFunctions.c"
)

target_include_directories(${PROJECT_NAME} PRIVATE ${SYPHON_DIR})

target_link_libraries(${PROJECT_NAME}
    PRIVATE
    "-framework Cocoa"
    "-framework IOSurface"
    "-framework OpenGL"
    "-framework CoreGraphics"
    )

set_target_properties(${PROJECT_NAME} PROPERTIES CLANG_ENABLE_OBJC_WEAK "YES")
set_target_properties(${PROJECT_NAME} PROPERTIES XCODE_ATTRIBUTE_GCC_PREFIX_HEADER "${SYPHON_DIR}/Syphon_Prefix.pch")

target_compile_definitions(${PROJECT_NAME} PRIVATE SYPHON_UNIQUE_CLASS_NAME_PREFIX=SyphonJitterServer)

include(${CMAKE_CURRENT_SOURCE_DIR}/../script/max-posttarget.cmake)
