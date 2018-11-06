cmake_minimum_required(VERSION 2.8 FATAL_ERROR)

#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fprofile-arcs -ftest-coverage -fPIC")

#message("CMAKE_CURRENT_SOURCE_DIR : ${CMAKE_CURRENT_SOURCE_DIR}")

add_executable(toDo main.cc)
add_subdirectory(components)
target_link_libraries(toDo toDoCore  ${Boost_LIBRARIES})