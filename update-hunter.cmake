#!/usr/bin/cmake -P

execute_process(COMMAND ${CMAKE_COMMAND} -E remove -f CMakeLists.txt)
execute_process(COMMAND ${CMAKE_COMMAND} -E remove_directory cmake)
execute_process(COMMAND ${CMAKE_COMMAND} -E make_directory cmake)

file(DOWNLOAD https://raw.githubusercontent.com/hunter-packages/gate/master/cmake/HunterGate.cmake cmake/HunterGate.cmake)

file(DOWNLOAD https://github.com/ruslo/hunter/releases/latest ./hunterversion.txt)
file(READ hunterversion.txt HTML_CONTENT)
string(REGEX MATCH "https://github.com/ruslo/hunter/archive/v.........tar.gz" HUNTER_URL "${HTML_CONTENT}")
string(REGEX MATCH ">\"........................................\"<" HUNTER_SHA1 "${HTML_CONTENT}")
string(REPLACE ">\"" "" HUNTER_SHA1 "${HUNTER_SHA1}")
string(REPLACE "\"<" "" HUNTER_SHA1 "${HUNTER_SHA1}")
message(STATUS ${HUNTER_URL})
message(STATUS ${HUNTER_SHA1})

execute_process(COMMAND ${CMAKE_COMMAND} -E remove -f hunterversion.txt)

file(WRITE CMakeLists.txt
"cmake_minimum_required(VERSION 3.6)

include(\"cmake/HunterGate.cmake\")
HunterGate(
    URL \"${HUNTER_URL}\"
    SHA1 \"${HUNTER_SHA1}\"
)

project(dummy)
add_executable(dummy \"main.cpp\")

")

file(WRITE main.cpp 
"#include <iostream>

using namespace std;

int main()
{
  cout << \"Hello World!\" << endl;
  return 0;
}")
