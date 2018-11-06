# Check prereqs
# https://github.com/pyarmak/cmake-gtest-coverage-example/blob/master/cmake/modules/CodeCoverage.cmake
FIND_PROGRAM( GCOV_PATH gcov )
FIND_PROGRAM( LCOV_PATH lcov )
FIND_PROGRAM( GENHTML_PATH genhtml )
find_program( GCOVR_PATH gcovr PATHS ${CMAKE_SOURCE_DIR}/scripts/test)

IF(NOT GCOV_PATH)
	MESSAGE(FATAL_ERROR "gcov not found! Aborting...")
ENDIF() # NOT GCOV_PATH

if(NOT GCOVR_PATH)
	message(FATAL_ERROR "gcovr not found! Aborting...")
endif() # NOT GCOVR_PATH


message("-. GCOVR_PATH : ${GCOVR_PATH}")

if(GCOVR_PATH)
   add_custom_target(coverage
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
     COMMAND ${GCOVR_PATH} -x --filter ${CMAKE_SOURCE_DIR} > ${CMAKE_CURRENT_BINARY_DIR}/gcovr-report.xml
     COMMENT "Running coverage"  
     )
else()
  message(FATAL_ERROR "gcovr not found! Aborting...")
endif()