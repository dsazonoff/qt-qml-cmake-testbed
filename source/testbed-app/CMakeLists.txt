# Target
set(target_name "testbed")
set(target_uri "${base_uri}.${target_name}")

qt_add_executable(${target_name})


# Sources
enumerate_files(source_files PATH "${CMAKE_CURRENT_SOURCE_DIR}" BASE_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}" EXTENSIONS ${mds_default_sources_ext})
enumerate_files(qml_files PATH "${CMAKE_CURRENT_SOURCE_DIR}" BASE_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}" EXTENSIONS qml)

target_sources(${target_name} PRIVATE ${source_files})

cmake_path(RELATIVE_PATH CMAKE_CURRENT_BINARY_DIR BASE_DIRECTORY "${CMAKE_BINARY_DIR}" OUTPUT_VARIABLE module_path)
qt_add_qml_module(${target_name}
    URI "${target_uri}"
    VERSION ${version}
    QML_FILES ${qml_files}
    SOURCES ${source_files}
    DEPENDENCIES QtQuick
#    TARGET_PATH "${module_path}" # Internal argument, prevents unwanted warnings
#    OUTPUT_DIRECTORY "${module_path}"
)

# Configuration
mds_target_compile_configuration(TARGET ${target_name})
mds_target_include_directories(TARGET ${target_name})
mds_target_default_pch(TARGET ${target_name})
target_compile_definitions(${target_name} PRIVATE
    ${qt_compile_definitions}
    APP_NAME=\"${app_name}\"
)
target_link_libraries(${target_name} PRIVATE
    ${qt_libraries}
    wheelplugin
)

qt_import_qml_plugins(${target_name})


# Resources
enumerate_files(asset_files PATH "${CMAKE_SOURCE_DIR}/source/assets" EXTENSIONS "*")
qt_add_resources(${target_name} "assets"
    BASE "${CMAKE_SOURCE_DIR}/source"
    FILES ${asset_files}
)


# Deploy

# Icon
set(app_icon "${CMAKE_SOURCE_DIR}/source/assets/logo.icns")
set_source_files_properties(${app_icon} PROPERTIES MACOSX_PACKAGE_LOCATION "Resources")
target_sources(${target_name} PRIVATE ${app_icon})

# Bundle
set_target_properties(${target_name} PROPERTIES
    OUTPUT_NAME "${app_name}"
    MACOSX_BUNDLE TRUE
)
set_target_properties(${target_name} PROPERTIES
    MACOSX_BUNDLE_BUNDLE_NAME "${app_name}"
    MACOSX_BUNDLE_GUI_IDENTIFIER "${bundle_identifier}"
    MACOSX_BUNDLE_BUNDLE_VERSION "${version}"
    MACOSX_BUNDLE_COPYRIGHT "${copyright_text}"
)

install(TARGETS ${target_name}
    BUNDLE DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
qt_generate_deploy_qml_app_script(
    TARGET ${target_name}
    OUTPUT_SCRIPT deploy_script
)
install(SCRIPT ${deploy_script})
