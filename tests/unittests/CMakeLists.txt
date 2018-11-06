add_gtest_test(ToDoTest ToDoTest.cc)
target_link_libraries(ToDoTest toDoCore)
set_tests_properties(${noArgsTests} PROPERTIES TIMEOUT 10)
