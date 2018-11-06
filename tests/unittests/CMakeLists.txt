include_directories(${CMAKE_SOURCE_DIR}/src/components)

add_gtest_test(ToDoTest ToDoTest.cc ComponentTest.cc)
target_link_libraries(ToDoTest toDoCore component1)
set_tests_properties(${noArgsTests} PROPERTIES TIMEOUT 10)
