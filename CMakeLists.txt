cmake_minimum_required(VERSION 3.26 FATAL_ERROR)

set(copyright_text "(C) Dmitry Sazonov, ...")
set(app_name "qt-qml-cmake-testbed")
set(bundle_identifier "com.dsazonoff.testbed")
set(version 2023.1)

project(${app_name} VERSION ${version} LANGUAGES CXX)

# CMake scripts lookup
list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/cmake")

# Global project configuration
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_INCLUDE_CURRENT_DIR OFF)

# Default install into the build directory
if (CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(CMAKE_INSTALL_PREFIX "${CMAKE_SOURCE_DIR}/build/${CMAKE_HOST_SYSTEM_NAME}-${CMAKE_BUILD_TYPE}" CACHE PATH "" FORCE)
endif ()

# Find Qt
list(APPEND qt_components Core Gui Quick QuickControls2 Svg)
set(qt_libraries)
foreach (component ${qt_components})
    list(APPEND qt_libraries "Qt6::${component}")
endforeach ()
#set(qt_compile_definitions $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
set(find_qt_extra)
if (IS_DIRECTORY "$ENV{QT_DIR}")
    set(find_qt_extra NO_DEFAULT_PATH PATHS "$ENV{QT_DIR}")
endif ()

find_package(Qt6 COMPONENTS ${qt_components} REQUIRED ${find_qt_extra})
qt_standard_project_setup(REQUIRES 6.6)

# Targets
add_subdirectory("source/testbed-app")
