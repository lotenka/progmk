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
CMAKE_BINARY_DIR = /home/lot/progmk/STM32103_m

# Utility rule file for bin.

# Include any custom commands dependencies for this target.
include CMakeFiles/bin.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/bin.dir/progress.make

CMakeFiles/bin: STM32103_m.bin

STM32103_m.bin: STM32103_m.elf
STM32103_m.bin: STM32103_m.elf
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --blue --bold --progress-dir=/home/lot/progmk/STM32103_m/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating STM32103_m.bin"
	arm-none-eabi-objcopy -O binary /home/lot/progmk/STM32103_m/STM32103_m.elf /home/lot/progmk/STM32103_m/STM32103_m.bin

bin: CMakeFiles/bin
bin: STM32103_m.bin
bin: CMakeFiles/bin.dir/build.make
.PHONY : bin

# Rule to build all files generated by this target.
CMakeFiles/bin.dir/build: bin
.PHONY : CMakeFiles/bin.dir/build

CMakeFiles/bin.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/bin.dir/cmake_clean.cmake
.PHONY : CMakeFiles/bin.dir/clean

CMakeFiles/bin.dir/depend:
	cd /home/lot/progmk/STM32103_m && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/lot/progmk/STM32103_m /home/lot/progmk/STM32103_m /home/lot/progmk/STM32103_m /home/lot/progmk/STM32103_m /home/lot/progmk/STM32103_m/CMakeFiles/bin.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/bin.dir/depend

