#!/bin/sh

echo "build is started"

rm -rf build/
rm -rf bin/
mkdir -p build
cd build
cmake -G "Unix Makefiles" ..
make
make cppcheck
make coverage
cd ..

