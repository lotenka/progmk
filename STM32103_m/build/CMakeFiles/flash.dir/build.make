# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.28

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:

#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:

# Disable VCS-based implicit rules.
% : %,v

# Disable VCS-based implicit rules.
% : RCS/%

# Disable VCS-based implicit rules.
% : RCS/%,v

# Disable VCS-based implicit rules.
% : SCCS/s.%

# Disable VCS-based implicit rules.
% : s.%

.SUFFIXES: .hpux_make_needs_suffix_list

# Command-line flag to silence nested $(MAKE).
$(VERBOSE)MAKESILENT = -s

#Suppress display of executed commands.
$(VERBOSE).SILENT:

# A target that is always out of date.
cmake_force:
.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/bin/cmake

# The command to remove a file.
RM = /usr/bin/cmake -E rm -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/lot/progmk/STM32103_m

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/lot/progmk/STM32103_m/build

# Utility rule file for flash.

# Include any custom commands dependencies for this target.
include CMakeFiles/flash.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/flash.dir/progress.make

CMakeFiles/flash: flash_target

flash_target: STM32103_m.bin
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/home/lot/progmk/STM32103_m/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating flash_target"
	st-flash write /home/lot/progmk/STM32103_m/build/STM32103_m.bin 0x8000000

STM32103_m.bin: STM32103_m.elf
STM32103_m.bin: STM32103_m.elf
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/home/lot/progmk/STM32103_m/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Generating STM32103_m.bin"
	arm-none-eabi-objcopy -O binary /home/lot/progmk/STM32103_m/build/STM32103_m.elf /home/lot/progmk/STM32103_m/build/STM32103_m.bin

flash: CMakeFiles/flash
flash: STM32103_m.bin
flash: flash_target
flash: CMakeFiles/flash.dir/build.make
.PHONY : flash

# Rule to build all files generated by this target.
CMakeFiles/flash.dir/build: flash
.PHONY : CMakeFiles/flash.dir/build

CMakeFiles/flash.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/flash.dir/cmake_clean.cmake
.PHONY : CMakeFiles/flash.dir/clean

CMakeFiles/flash.dir/depend:
	cd /home/lot/progmk/STM32103_m/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/lot/progmk/STM32103_m /home/lot/progmk/STM32103_m /home/lot/progmk/STM32103_m/build /home/lot/progmk/STM32103_m/build /home/lot/progmk/STM32103_m/build/CMakeFiles/flash.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/flash.dir/depend

