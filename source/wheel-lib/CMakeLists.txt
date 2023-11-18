# Target
set(target_name "wheel")
set(target_uri "${base_uri}.${target_name}")

qt_add_library(${target_name} STATIC)


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
)
target_link_libraries(${target_name} PRIVATE
    ${qt_libraries}
)

qt_import_qml_plugins(${target_name})
