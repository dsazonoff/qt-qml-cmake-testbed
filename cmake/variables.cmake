include_guard(GLOBAL)


# Compiler options
set(mds_clang_options -Wall -Wextra -Wpedantic -Werror
    -Wno-c++98-compat
    -Wno-c++98-compat-pedantic
    -Wno-deprecated-declarations
)
set(mds_gcc_options -Wall -Wextra -Wpedantic -Werror
)
set(mds_msvc_options /W4 /WX
    /wd4702
)

# Compiler definitions
set(mds_compile_definitions
    _SILENCE_ALL_CXX17_DEPRECATION_WARNINGS
    BOOST_BIND_GLOBAL_PLACEHOLDERS
    _CRT_SECURE_NO_WARNINGS
)

# Platform specific fixes
if (${CMAKE_SYSTEM_NAME} STREQUAL "Windows")
    list(APPEND mds_clang_options /EHs)
    list(APPEND mds_compile_definitions _WIN32_WINNT=0x0601)
endif ()
