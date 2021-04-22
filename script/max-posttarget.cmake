set_target_properties(${PROJECT_NAME} PROPERTIES CLANG_ENABLE_OBJC_WEAK "YES")
set_target_properties(${PROJECT_NAME} PROPERTIES XCODE_ATTRIBUTE_GCC_PREFIX_HEADER "${SYPHON_DIR}/Syphon_Prefix.pch")

target_include_directories(${PROJECT_NAME} PRIVATE ${SYPHON_DIR})

target_link_libraries(${PROJECT_NAME}
    PRIVATE
    "-framework Cocoa"
    "-framework IOSurface"
    "-framework OpenGL"
    "-framework CoreGraphics"
    )


if (${C74_CXX_STANDARD} EQUAL 98)
	if (APPLE)
		set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=gnu++98 -stdlib=libstdc++")
		set(CMAKE_SHARED_LINKER_FLAGS "${CMAKE_SHARED_LINKER_FLAGS} -stdlib=libstdc++")
		set(CMAKE_MODULE_LINKER_FLAGS "${CMAKE_MODULE_LINKER_FLAGS} -stdlib=libstdc++")
	endif ()
else ()
	set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD 17)
	set_property(TARGET ${PROJECT_NAME} PROPERTY CXX_STANDARD_REQUIRED ON)
endif ()

set(EXTERN_OUTPUT_NAME "${PROJECT_NAME}")
set_target_properties(${PROJECT_NAME} PROPERTIES OUTPUT_NAME "${EXTERN_OUTPUT_NAME}")


### Output ###
if (APPLE)
    find_library(JITTER_LIBRARY "JitterAPI" HINTS "${MAX_SDK_JIT_INCLUDES}"  )
    target_link_libraries(${PROJECT_NAME} PUBLIC ${JITTER_LIBRARY})
	
	set_property(TARGET ${PROJECT_NAME}
				 PROPERTY BUNDLE True)
	set_property(TARGET ${PROJECT_NAME}
				 PROPERTY BUNDLE_EXTENSION "mxo")	
	set_target_properties(${PROJECT_NAME} PROPERTIES XCODE_ATTRIBUTE_WRAPPER_EXTENSION "mxo")
	set_target_properties(${PROJECT_NAME} PROPERTIES MACOSX_BUNDLE_BUNDLE_VERSION "${GIT_VERSION_TAG}")
    set_target_properties(${PROJECT_NAME} PROPERTIES MACOSX_BUNDLE_INFO_PLIST ${CMAKE_CURRENT_LIST_DIR}/Info.plist.in)
endif ()


### Post Build ###

if (APPLE)
    if ("${PROJECT_NAME}" MATCHES "_test")
    else ()
    	add_custom_command( 
    		TARGET ${PROJECT_NAME} 
    		POST_BUILD 
    		COMMAND cp "${CMAKE_CURRENT_LIST_DIR}/PkgInfo" "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}/${EXTERN_OUTPUT_NAME}.mxo/Contents/PkgInfo" 
    		COMMENT "Copy PkgInfo" 
    	)
    endif ()    
endif ()
