include_guard(GLOBAL)


# Trace a list of variables
# If variable doesn't exist it will be treated as a text
# If variable is a single value it will be shown as VAR = VALUE
# If variable is an array it will be shown as a list VAR = [ val1, val2, ... ]
# Usage:  echo(<var1> <var2>...)
function(echo)
    # Long prefixes are required to avoid vars name conflicts
    foreach (mds_echo_arg ${ARGV})
        set(mds_echo_name ${mds_echo_arg})
        set(mds_echo_value ${${mds_echo_arg}})
        list(LENGTH mds_echo_value mds_echo_count)
        if (NOT DEFINED ${mds_echo_name})
            message(STATUS "${mds_echo_name}")
        elseif (${mds_echo_count} LESS 2)
            message(STATUS "${mds_echo_name} = ${mds_echo_value}")
        else ()
            string(JOIN ", " mds_echo_text ${mds_echo_value})
            set(mds_echo_text "[ ${mds_echo_text} ]")
            message(STATUS "${mds_echo_name} = ${mds_echo_text}")
        endif ()
    endforeach ()
endfunction()


# TODO: add description
set(mds_default_sources_ext "cpp" "h")
function(enumerate_files files)
    cmake_parse_arguments(PARSE_ARGV 1 in "" "PATH;EXCLUDE_REGEX;BASE_DIRECTORY" "EXTENSIONS")

    if (NOT IS_DIRECTORY "${in_PATH}")
        message(FATAL_ERROR "DIR \"${in_PATH}\" should exist")
    endif ()

    set(result "")
    foreach (ext ${in_EXTENSIONS})
        file(GLOB_RECURSE file_list LIST_DIRECTORIES false "${in_PATH}/*.${ext}")
        list(APPEND result ${file_list})
    endforeach ()
    if (in_EXCLUDE_REGEXP)
        list(FILTER result EXCLUDE REGEX ${in_EXCLUDE_REGEXP})
    endif ()
    if (in_BASE_DIRECTORY)
        set(relative_list)
        foreach (f ${result})
            cmake_path(RELATIVE_PATH f BASE_DIRECTORY "${in_BASE_DIRECTORY}")
            list(APPEND relative_list "${f}")
        endforeach ()
        set(result ${relative_list})
    endif ()

    set(${files} ${result} PARENT_SCOPE)
endfunction()


# TODO: add description
function(mds_target_default_pch)
    cmake_parse_arguments(PARSE_ARGV 0 in "" "TARGET" "")
    if (NOT TARGET ${in_TARGET})
        message(FATAL_ERROR "TARGET \"${in_TARGET}\" should be a valid target")
    endif ()

    set(path "${CMAKE_CURRENT_SOURCE_DIR}/pch.h")
    if (EXISTS "${path}")
        target_precompile_headers(${in_TARGET} PUBLIC "${path}")
    endif ()
endfunction()


# TODO: add description
function(mds_target_compile_configuration)
    cmake_parse_arguments(PARSE_ARGV 0 in "" "TARGET" "")
    if (NOT TARGET ${in_TARGET})
        message(FATAL_ERROR "TARGET \"${in_TARGET}\" should be a valid target")
    endif ()

    get_target_property(target_type ${in_TARGET} TYPE)
    if (NOT "${target_type}" STREQUAL "INTERFACE_LIBRARY")
        target_compile_options(${in_TARGET} PRIVATE
            $<$<CXX_COMPILER_ID:MSVC>:${mds_msvc_options}>
            $<$<CXX_COMPILER_ID:GNU>:${mds_gcc_options}>
            $<$<CXX_COMPILER_ID:Clang>:${mds_clang_options}>
            $<$<CXX_COMPILER_ID:AppleClang>:${mds_clang_options}>
        )
        target_compile_definitions(${in_TARGET} PRIVATE ${mds_compile_definitions})
    endif ()
endfunction()


# TODO: add description
function(mds_target_include_directories)
    cmake_parse_arguments(PARSE_ARGV 0 in "" "TARGET" "")
    if (NOT TARGET ${in_TARGET})
        message(FATAL_ERROR "TARGET \"${in_TARGET}\" should be a valid target")
    endif ()

    target_include_directories(${in_TARGET} PRIVATE
        "${CMAKE_SOURCE_DIR}/source"
    )
endfunction()
