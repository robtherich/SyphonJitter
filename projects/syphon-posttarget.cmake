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
