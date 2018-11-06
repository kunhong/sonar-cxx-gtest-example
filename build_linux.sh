#!/bin/sh

echo "build is started"

rm -rf build/
mkdir -p build
cd build
cmake -G "Unix Makefiles" ..
make
cd ..

