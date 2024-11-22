# Distributed under the OSI-approved BSD 3-Clause License.  See accompanying
# file Copyright.txt or https://cmake.org/licensing for details.

cmake_minimum_required(VERSION 3.5)

file(MAKE_DIRECTORY
  "/home/lot/progmk/STM32103_m/libs/libopencm3"
  "/home/lot/progmk/STM32103_m/opencm3_build-prefix/src/opencm3_build-build"
  "/home/lot/progmk/STM32103_m/opencm3_build-prefix"
  "/home/lot/progmk/STM32103_m/opencm3_build-prefix/tmp"
  "/home/lot/progmk/STM32103_m/opencm3_build-prefix/src/opencm3_build-stamp"
  "/home/lot/progmk/STM32103_m/opencm3_build-prefix/src"
  "/home/lot/progmk/STM32103_m/opencm3_build-prefix/src/opencm3_build-stamp"
)

set(configSubDirs )
foreach(subDir IN LISTS configSubDirs)
    file(MAKE_DIRECTORY "/home/lot/progmk/STM32103_m/opencm3_build-prefix/src/opencm3_build-stamp/${subDir}")
endforeach()
if(cfgdir)
  file(MAKE_DIRECTORY "/home/lot/progmk/STM32103_m/opencm3_build-prefix/src/opencm3_build-stamp${cfgdir}") # cfgdir has leading slash
endif()
