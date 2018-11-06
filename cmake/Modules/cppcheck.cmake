# # - Run cppcheck on c++ source files as a custom target and a test
# #
# # add_test_cppcheck(<target-name> [UNUSED_FUNCTIONS] [STYLE] [POSSIBLE_ERROR] [FAIL_ON_WARNINGS]) -
# # Create a target to check a target's sources with cppcheck and the indicated options
# #
# # Requires these CMake modules:
# # Findcppcheck
# #
# # Requires CMake 2.8 or newer
# #
# # Original Author:
# # 2009-2010 Ryan Pavlik <rpavlik@iastate.edu> <abiryan@ryand.net>
# # http://academic.cleardefinition.com
# # Iowa State University HCI Graduate Program/VRAC
# #
# # Copyright Iowa State University 2009-2010.
# # Distributed under the Boost Software License, Version 1.0.
# # (See accompanying file LICENSE_1_0.txt or copy at
# # http://www.boost.org/LICENSE_1_0.txt)
# # https://github.com/joaoleal/CppADCodeGen/blob/master/cmake/cppcheck.cmake

# IF(__add_cppcheck)
#   RETURN()
# ENDIF()
# SET(__add_cppcheck YES)

# IF(NOT CPPCHECK_FOUND)
#   FIND_PACKAGE(cppcheck QUIET)
# ENDIF()

# IF(CPPCHECK_FOUND)
#   IF(NOT TARGET all_cppcheck)
#     ADD_CUSTOM_TARGET(all_cppcheck)
#   ENDIF()
# ENDIF()

# FUNCTION(add_test_cppcheck _target_name)
#   IF(NOT TARGET ${_target_name})
#     MESSAGE(FATAL_ERROR "add_test_cppcheck given a target name that does not exist: '${_target_name}' !")
#   ENDIF()
  
#   IF(NOT CPPCHECK_FOUND)
#     MESSAGE(WARNING "cppcheck not found! Static code analysis disabled.")
#     RETURN()
#   ENDIF()
  
#   SET(cppcheck_args)

#   LIST(FIND ARGN UNUSED_FUNCTIONS index)
#   IF("${index}" GREATER "-1")
#     LIST(APPEND cppcheck_args ${CPPCHECK_UNUSEDFUNC_ARG})
#   ENDIF()

#   LIST(FIND ARGN STYLE index)
#   IF("${index}" GREATER "-1")
#     LIST(APPEND cppcheck_args ${CPPCHECK_STYLE_ARG})
#   ENDIF()

#   LIST(FIND ARGN POSSIBLE_ERROR index)
#   IF("${index}" GREATER "-1")
#     LIST(APPEND cppcheck_args ${CPPCHECK_POSSIBLEERROR_ARG})
#   ENDIF()

#   LIST(FIND ARGN MISSING_INCLUDE index)
#   IF("${index}" GREATER "-1")
#     LIST(APPEND cppcheck_args ${CPPCHECK_MISSINGINCLUDE_ARG})
#   ENDIF()
  
#   LIST(FIND _input FAIL_ON_WARNINGS index)
#   IF("${index}" GREATER "-1")
#     LIST(APPEND CPPCHECK_FAIL_REGULAR_EXPRESSION ${CPPCHECK_WARN_REGULAR_EXPRESSION})
#     LIST(REMOVE_AT _input ${_unused_func})
#   ENDIF()

#   GET_TARGET_PROPERTY(target_sources "${_target_name}" SOURCES)
#   SET(cppcheck_sources)
#   FOREACH(source ${target_sources})
#     GET_SOURCE_FILE_PROPERTY(path "${source}" LOCATION)
#     GET_SOURCE_FILE_PROPERTY(lang "${source}" LANGUAGE)
#     IF("${lang}" MATCHES "CXX")
#       LIST(APPEND cppcheck_sources "${path}")
#     ENDIF()
#   ENDFOREACH()

#   GET_TARGET_PROPERTY(target_definitions "${_target_name}" SOURCES)
#   GET_TARGET_PROPERTY(target_source_location "${_target_name}" SOURCES)
  
#   SET(test_target_name "${_target_name}_cppcheck_test")
   
#   GET_TARGET_PROPERTY(include_folders "${_target_name}" INCLUDE_DIRECTORIES)

#   SET(include_args)
#   FOREACH(folder ${include_folders}) 
#     LIST(APPEND include_args "-I${folder}")
#   ENDFOREACH()
   
#   ADD_TEST(NAME "${test_target_name}"
#            COMMAND "${CPPCHECK_EXECUTABLE}"
#                     ${CPPCHECK_TEMPLATE_ARG}
#                     ${cppcheck_args}
#                     ${include_args}
#                     ${cppcheck_sources})

#   SET_TESTS_PROPERTIES("${test_target_name}"
#                        PROPERTIES
#                        FAIL_REGULAR_EXPRESSION  "${CPPCHECK_FAIL_REGULAR_EXPRESSION}")
                      
#   ADD_CUSTOM_COMMAND(TARGET all_cppcheck
#                      PRE_BUILD
#                      COMMAND "${CPPCHECK_EXECUTABLE}"
#                              ${CPPCHECK_QUIET_ARG}
#                              ${CPPCHECK_TEMPLATE_ARG}
#                              ${cppcheck_args}
#                              ${include_args}
#                              ${cppcheck_sources}
#                      WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
#                      COMMENT "${test_target_name}: Running cppcheck on target ${_target_name}..."
#                      VERBATIM)

# ENDFUNCTION()

# additional target to perform cppcheck run, requires cppcheck

# get all project files
# HACK this workaround is required to avoid qml files checking ^_^
file(GLOB_RECURSE ALL_SOURCE_FILES *.cpp *.h)
foreach (SOURCE_FILE ${ALL_SOURCE_FILES})
    # string(FIND ${SOURCE_FILE} ${PROJECT_TRDPARTY_DIR} PROJECT_TRDPARTY_DIR_FOUND)
    # if (NOT ${PROJECT_TRDPARTY_DIR_FOUND} EQUAL -1)
    #     list(REMOVE_ITEM ALL_SOURCE_FILES ${SOURCE_FILE})
    # endif ()
endforeach ()

# https://github.com/bmwcarit/acme/blob/master/cmake/plugins/CppCheck/CppCheck.cmake

find_program(CPPCHECK_COMMAND cppcheck)

if(CPPCHECK_COMMAND)
   add_custom_target(cppcheck
     # COMMAND ${CPPCHECK_COMMAND} --quiet --enable=all --std=c++11 --suppress=unusedFunction
     #                             --force --error-exitcode=1 --template=gcc -I src/kaa
     #                             --inline-suppr src/ test/
     #                             -ithirdparty/
     # WORKING_DERICTORY ${KAA_SDK_DIR}
     # COMMENT "Running cppcheck"
     # VERBATIM
     # COMMAND ${CPPCHECK_COMMAND} --quiet --enable=all --std=c++11 --suppress=unusedFunction
     #                             --force --error-exitcode=1 --template=gcc -I ${CMAKE_SOURCE_DIR}/src
     #                             --inline-suppr ${CMAKE_SOURCE_DIR}/src/ ${CMAKE_SOURCE_DIR}/tests/
     COMMAND ${CPPCHECK_COMMAND} -v --enable=all --xml --std=c++11
                                 -I${CMAKE_SOURCE_DIR}/src -I${CMAKE_SOURCE_DIR}/ToDoCore
                                 ${CMAKE_SOURCE_DIR}/src/ ${CMAKE_SOURCE_DIR}/ToDoCore/ 2> ${CMAKE_CURRENT_BINARY_DIR}/cppcheck-report.xml
     COMMENT "Running cppcheck"
     VERBATIM   
     )
else()
  message (STATUS "Could NOT find cppcheck")
endif()

# cppcheck -v --enable=all --xml $(CPPCHECK_INCLUDES) $(SOURCES_TO_ANALYSE) 2> $(BUILD_DIR)/cppcheck-report.xml
# add_custom_target(
#         cppcheck
#         COMMAND /usr/local/bin/cppcheck
#         --enable=all
#         --std=c++11
#         # --library=qt.cfg
#         # --template="[{severity}][{id}] {message} {callstack} \(On {file}:{line}\)"
#         -v
#         --xml
#         --verbose
#         --quiet
#         ${ALL_SOURCE_FILES}
# )