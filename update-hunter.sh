#!/bin/sh

rm -f CMakeLists.txt
rm -fr cmake
mkdir cmake
cd cmake
wget https://raw.githubusercontent.com/hunter-packages/gate/master/cmake/HunterGate.cmake

cd ..

HUNTER_VERSION=`lynx --dump https://github.com/ruslo/hunter/releases/latest | grep -A 3 HunterGate`


cat <<EOF > CMakeLists.txt
cmake_minimum_required(VERSION 3.6)

include("cmake/HunterGate.cmake")
$HUNTER_VERSION

project(dummy)
add_executable(dummy "main.cpp")

EOF

echo "==================== Created CMakeLists.txt ====================="
cat CMakeLists.txt
echo "================================================================="
