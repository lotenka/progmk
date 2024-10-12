cmake_minimum_required(VERSION 3.0.0)
include_directories(inc)
add_library(mylib_test STATIC "scr/mylib_test.c")
set_target_properties(mylib_test PROPERTIES PUBLIC_HEADER "inc/*.h")