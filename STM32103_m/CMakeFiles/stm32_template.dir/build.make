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

# Include any dependencies generated for this target.
include CMakeFiles/stm32_template.dir/depend.make
# Include any dependencies generated by the compiler for this target.
include CMakeFiles/stm32_template.dir/compiler_depend.make

# Include the progress variables for this target.
include CMakeFiles/stm32_template.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/stm32_template.dir/flags.make

CMakeFiles/stm32_template.dir/stm32/startup/startup_stm32f10x_md.c.o: CMakeFiles/stm32_template.dir/flags.make
CMakeFiles/stm32_template.dir/stm32/startup/startup_stm32f10x_md.c.o: stm32/startup/startup_stm32f10x_md.c
CMakeFiles/stm32_template.dir/stm32/startup/startup_stm32f10x_md.c.o: CMakeFiles/stm32_template.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/lot/progmk/STM32103_m/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building C object CMakeFiles/stm32_template.dir/stm32/startup/startup_stm32f10x_md.c.o"
	arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/stm32_template.dir/stm32/startup/startup_stm32f10x_md.c.o -MF CMakeFiles/stm32_template.dir/stm32/startup/startup_stm32f10x_md.c.o.d -o CMakeFiles/stm32_template.dir/stm32/startup/startup_stm32f10x_md.c.o -c /home/lot/progmk/STM32103_m/stm32/startup/startup_stm32f10x_md.c

CMakeFiles/stm32_template.dir/stm32/startup/startup_stm32f10x_md.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/stm32_template.dir/stm32/startup/startup_stm32f10x_md.c.i"
	arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/lot/progmk/STM32103_m/stm32/startup/startup_stm32f10x_md.c > CMakeFiles/stm32_template.dir/stm32/startup/startup_stm32f10x_md.c.i

CMakeFiles/stm32_template.dir/stm32/startup/startup_stm32f10x_md.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/stm32_template.dir/stm32/startup/startup_stm32f10x_md.c.s"
	arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/lot/progmk/STM32103_m/stm32/startup/startup_stm32f10x_md.c -o CMakeFiles/stm32_template.dir/stm32/startup/startup_stm32f10x_md.c.s

CMakeFiles/stm32_template.dir/stm32/system_stm32f10x.c.o: CMakeFiles/stm32_template.dir/flags.make
CMakeFiles/stm32_template.dir/stm32/system_stm32f10x.c.o: stm32/system_stm32f10x.c
CMakeFiles/stm32_template.dir/stm32/system_stm32f10x.c.o: CMakeFiles/stm32_template.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/lot/progmk/STM32103_m/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building C object CMakeFiles/stm32_template.dir/stm32/system_stm32f10x.c.o"
	arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/stm32_template.dir/stm32/system_stm32f10x.c.o -MF CMakeFiles/stm32_template.dir/stm32/system_stm32f10x.c.o.d -o CMakeFiles/stm32_template.dir/stm32/system_stm32f10x.c.o -c /home/lot/progmk/STM32103_m/stm32/system_stm32f10x.c

CMakeFiles/stm32_template.dir/stm32/system_stm32f10x.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/stm32_template.dir/stm32/system_stm32f10x.c.i"
	arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/lot/progmk/STM32103_m/stm32/system_stm32f10x.c > CMakeFiles/stm32_template.dir/stm32/system_stm32f10x.c.i

CMakeFiles/stm32_template.dir/stm32/system_stm32f10x.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/stm32_template.dir/stm32/system_stm32f10x.c.s"
	arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/lot/progmk/STM32103_m/stm32/system_stm32f10x.c -o CMakeFiles/stm32_template.dir/stm32/system_stm32f10x.c.s

CMakeFiles/stm32_template.dir/syscalls/syscalls.c.o: CMakeFiles/stm32_template.dir/flags.make
CMakeFiles/stm32_template.dir/syscalls/syscalls.c.o: syscalls/syscalls.c
CMakeFiles/stm32_template.dir/syscalls/syscalls.c.o: CMakeFiles/stm32_template.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/lot/progmk/STM32103_m/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building C object CMakeFiles/stm32_template.dir/syscalls/syscalls.c.o"
	arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/stm32_template.dir/syscalls/syscalls.c.o -MF CMakeFiles/stm32_template.dir/syscalls/syscalls.c.o.d -o CMakeFiles/stm32_template.dir/syscalls/syscalls.c.o -c /home/lot/progmk/STM32103_m/syscalls/syscalls.c

CMakeFiles/stm32_template.dir/syscalls/syscalls.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/stm32_template.dir/syscalls/syscalls.c.i"
	arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/lot/progmk/STM32103_m/syscalls/syscalls.c > CMakeFiles/stm32_template.dir/syscalls/syscalls.c.i

CMakeFiles/stm32_template.dir/syscalls/syscalls.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/stm32_template.dir/syscalls/syscalls.c.s"
	arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/lot/progmk/STM32103_m/syscalls/syscalls.c -o CMakeFiles/stm32_template.dir/syscalls/syscalls.c.s

CMakeFiles/stm32_template.dir/main.c.o: CMakeFiles/stm32_template.dir/flags.make
CMakeFiles/stm32_template.dir/main.c.o: main.c
CMakeFiles/stm32_template.dir/main.c.o: CMakeFiles/stm32_template.dir/compiler_depend.ts
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --progress-dir=/home/lot/progmk/STM32103_m/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building C object CMakeFiles/stm32_template.dir/main.c.o"
	arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -MD -MT CMakeFiles/stm32_template.dir/main.c.o -MF CMakeFiles/stm32_template.dir/main.c.o.d -o CMakeFiles/stm32_template.dir/main.c.o -c /home/lot/progmk/STM32103_m/main.c

CMakeFiles/stm32_template.dir/main.c.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Preprocessing C source to CMakeFiles/stm32_template.dir/main.c.i"
	arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -E /home/lot/progmk/STM32103_m/main.c > CMakeFiles/stm32_template.dir/main.c.i

CMakeFiles/stm32_template.dir/main.c.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green "Compiling C source to assembly CMakeFiles/stm32_template.dir/main.c.s"
	arm-none-eabi-gcc $(C_DEFINES) $(C_INCLUDES) $(C_FLAGS) -S /home/lot/progmk/STM32103_m/main.c -o CMakeFiles/stm32_template.dir/main.c.s

# Object files for target stm32_template
stm32_template_OBJECTS = \
"CMakeFiles/stm32_template.dir/stm32/startup/startup_stm32f10x_md.c.o" \
"CMakeFiles/stm32_template.dir/stm32/system_stm32f10x.c.o" \
"CMakeFiles/stm32_template.dir/syscalls/syscalls.c.o" \
"CMakeFiles/stm32_template.dir/main.c.o"

# External object files for target stm32_template
stm32_template_EXTERNAL_OBJECTS =

build/stm32_template.elf: CMakeFiles/stm32_template.dir/stm32/startup/startup_stm32f10x_md.c.o
build/stm32_template.elf: CMakeFiles/stm32_template.dir/stm32/system_stm32f10x.c.o
build/stm32_template.elf: CMakeFiles/stm32_template.dir/syscalls/syscalls.c.o
build/stm32_template.elf: CMakeFiles/stm32_template.dir/main.c.o
build/stm32_template.elf: CMakeFiles/stm32_template.dir/build.make
build/stm32_template.elf: CMakeFiles/stm32_template.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color "--switch=$(COLOR)" --green --bold --progress-dir=/home/lot/progmk/STM32103_m/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking C executable build/stm32_template.elf"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/stm32_template.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/stm32_template.dir/build: build/stm32_template.elf
.PHONY : CMakeFiles/stm32_template.dir/build

CMakeFiles/stm32_template.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/stm32_template.dir/cmake_clean.cmake
.PHONY : CMakeFiles/stm32_template.dir/clean

CMakeFiles/stm32_template.dir/depend:
	cd /home/lot/progmk/STM32103_m && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/lot/progmk/STM32103_m /home/lot/progmk/STM32103_m /home/lot/progmk/STM32103_m /home/lot/progmk/STM32103_m /home/lot/progmk/STM32103_m/CMakeFiles/stm32_template.dir/DependInfo.cmake "--color=$(COLOR)"
.PHONY : CMakeFiles/stm32_template.dir/depend
