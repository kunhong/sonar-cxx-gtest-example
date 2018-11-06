# Check prereqs
# https://github.com/pyarmak/cmake-gtest-coverage-example/blob/master/cmake/modules/CodeCoverage.cmake
FIND_PROGRAM( GCOV_PATH gcov )
FIND_PROGRAM( LCOV_PATH lcov )
FIND_PROGRAM( GENHTML_PATH genhtml )

IF(NOT GCOV_PATH)
	MESSAGE(FATAL_ERROR "gcov not found! Aborting...")
ENDIF() # NOT GCOV_PATH