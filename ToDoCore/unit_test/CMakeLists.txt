set(GTEST_DIR "/Users/hongkun/dev/googletest"
    CACHE PATH "The path to the GoogleMock test framework.")

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    # force this option to ON so that Google Test will use /MD instead of /MT
    # /MD is now the default for Visual Studio, so it should be our default, too
    option(gtest_force_shared_crt
           "Use shared (DLL) run-time lib even when Google Test is built as static lib."
           ON)
elseif (APPLE)
    add_definitions(-DGTEST_USE_OWN_TR1_TUPLE=1)
endif()

set(CMAKE_CXX_STANDARD 11)

add_subdirectory(${GTEST_DIR} ${CMAKE_BINARY_DIR}/googletest)

include_directories(SYSTEM ${GTEST_DIR}/googltest/include)
                           #${GTEST_DIR}/googlemock/include)

#
# add_gmock_test(<target> <sources>...)
#
#  Adds a Google Mock based test executable, <target>, built from <sources> and
#  adds the test so that CTest will run it. Both the executable and the test
#  will be named <target>.
#
function(add_gtest_test target)
    add_executable(${target} ${ARGN})
    target_link_libraries(${target} gtest gtest_main)

    include(GoogleTest)
    gtest_discover_tests(${target})
endfunction()



# add_executable(ToDoTest ToDoTest.cc)
# target_link_libraries(ToDoTest toDoCore
#                                #gmock_main
#                                gtest
#                                gtest_main)

# #add_test(ToDoTest ToDoTest)
# include(GoogleTest)
# gtest_discover_tests(ToDoTest)
add_gtest_test(ToDoTest ToDoTest.cc)
target_link_libraries(ToDoTest toDoCore)
set_tests_properties(${noArgsTests} PROPERTIES TIMEOUT 10)
