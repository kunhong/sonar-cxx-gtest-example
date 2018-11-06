cmake_minimum_required(VERSION 2.8 FATAL_ERROR)
set(CMAKE_LEGACY_CYGWIN_WIN32 0)

project("To Do List")

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/cmake/Modules)

message("-. PROJECT_SOURCE_DIR : ${PROJECT_SOURCE_DIR}")

set(EXECUTABLE_OUTPUT_PATH  ${PROJECT_SOURCE_DIR}/bin)
include(cppcheck)

enable_testing()
include(gmock)
include(CodeCoverage)
if (NOT DEFINED     BOOST_ROOT        AND
    NOT DEFINED ENV{BOOST_ROOT}       AND
    NOT DEFINED     BOOST_INCLUDEDIR  AND
    NOT DEFINED ENV{BOOST_INCLUDEDIR} AND
    NOT DEFINED     BOOST_LIBRARYDIR  AND
    NOT DEFINED ENV{BOOST_LIBRARYDIR})
    if (APPLE)
        set(BOOST_ROOT "/Users/hongkun/dev/libs/boost_1_67_0")
    elseif (WIN32)
        set(BOOST_INCLUDEDIR "C:/local/boost_1_55_0")
        set(BOOST_LIBRARYDIR "C:/local/boost_1_55_0/lib32-msvc-10.0")
    endif()
endif()
if (APPLE OR WIN32)
    set(Boost_USE_STATIC_LIBS OFF)
endif()

set(Boost_USE_STATIC_LIBS        ON)  # only find static libs
set(Boost_USE_DEBUG_LIBS         OFF) # ignore debug libs and
set(Boost_USE_RELEASE_LIBS       ON)  # only find release libs
set(Boost_USE_MULTITHREADED      ON)
set(Boost_USE_STATIC_RUNTIME    OFF)

include_directories(SYSTEM ${Boost_INCLUDE_DIRS})
find_package(Boost 1.67 REQUIRED COMPONENTS program_options)
#find_package(Boost 1.67 REQUIRED )

message("-. CMAKE_CURRENT_BINARY_DIR : ${CMAKE_CURRENT_BINARY_DIR}")
message("-. CMAKE_CURRENT_SOURCE_DIR : ${CMAKE_CURRENT_SOURCE_DIR}")

if(Boost_FOUND)
  include_directories(SYSTEM ${Boost_INCLUDE_DIRS})
  message("-. Boost_INCLUDE_DIRS : ${Boost_INCLUDE_DIRS}")
  message("-. Boost_LIBRARY_DIRS : ${Boost_LIBRARY_DIRS}")
  message("-. Boost_LIBRARIES : ${Boost_LIBRARIES}")
  message("-. BOOST_LIBRARYDIR : ${BOOST_LIBRARYDIR}")
  message("-. Boost_VERSION : ${Boost_VERSION}")
  message("-. Boost_LIB_VERSION : ${Boost_LIB_VERSION}")
endif()

if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU" OR
    "${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang")
    # set(warnings "-Wall -Wextra -Werror")
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
    set(warnings "/W4 /WX /EHsc")
endif()
if (NOT CONFIGURED_ONCE)
    set(CMAKE_CXX_FLAGS "${warnings}"
        CACHE STRING "Flags used by the compiler during all build types." FORCE)
    set(CMAKE_C_FLAGS   "${warnings}"
        CACHE STRING "Flags used by the compiler during all build types." FORCE)
endif()

#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fprofile-arcs -ftest-coverage -fPIC")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} --coverage")

# find_program(CMAKE_CXX_CPPCHECK NAMES cppcheck)
# if (CMAKE_CXX_CPPCHECK)
#     list(
#         APPEND CMAKE_CXX_CPPCHECK 
#             "--enable=warning"
#             "--inconclusive"
#             "--force" 
#             "--inline-suppr"
#             "--suppressions-list=${CMAKE_SOURCE_DIR}/CppCheckSuppressions.txt"
#     )
# endif()

include_directories(${CMAKE_CURRENT_SOURCE_DIR})

add_subdirectory(ToDoCore)
add_subdirectory(src)
add_subdirectory(tests)
set(CONFIGURED_ONCE TRUE CACHE INTERNAL
    "A flag showing that CMake has configured at least once.")
