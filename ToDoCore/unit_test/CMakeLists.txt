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

include_directories(SYSTEM ${GTEST_DIR}/googltest/include
                           ${GTEST_DIR}/googlemockinclude)


add_executable(ToDoTest ToDoTest.cc)
target_link_libraries(ToDoTest toDoCore
                               gmock_main
                               gtest_main)

#add_test(ToDoTest ToDoTest)
include(GoogleTest)
gtest_discover_tests(ToDoTest)
set_tests_properties(${noArgsTests} PROPERTIES TIMEOUT 10)
