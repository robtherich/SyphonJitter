cmake_minimum_required(VERSION 3.0)

set(CMAKE_POSITION_INDEPENDENT_CODE ON)
set(CMAKE_CXX_STANDARD 14)    # note: on linux we need c++17
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF) # for clang, gcc, this should use -std=gnu++11 instead of -std=c++11
set(CMAKE_VISIBILITY_INLINES_HIDDEN ON)
set(CMAKE_OPTIMIZE_DEPENDENCIES ON) # streamline static library dependencies

enable_language(OBJC OBJCXX)

set(CMAKE_XCODE_GENERATE_SCHEME ON)
set(CMAKE_SUPPRESS_REGENERATION ON)

set(C74_SCRIPT_DIR "${CMAKE_CURRENT_SOURCE_DIR}/max-sdk/source/script")

project(SyphonJitter VERSION 1.0.7 LANGUAGES C OBJC OBJCXX)
set(SYPHON_SHARED_DIR "${CMAKE_CURRENT_SOURCE_DIR}/Shared")
set(SYPHON_DIR "${CMAKE_CURRENT_SOURCE_DIR}/Syphon-Framework")
set(SYPHON_SRC
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

#add_subdirectory("Syphon-Framework")
add_subdirectory("projects/jit.gl.syphonclient")
add_subdirectory("projects/jit.gl.syphonserver")