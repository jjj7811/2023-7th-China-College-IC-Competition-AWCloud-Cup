# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.10

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /opt/software/cmake-3.10.3-Linux-x86_64/bin/cmake

# The command to remove a file.
RM = /opt/software/cmake-3.10.3-Linux-x86_64/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /opt/nna/Paddle-Lite

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc

# Include any dependencies generated for this target.
include lite/api/CMakeFiles/paddle_api_light.dir/depend.make

# Include the progress variables for this target.
include lite/api/CMakeFiles/paddle_api_light.dir/progress.make

# Include the compile flags for this target's objects.
include lite/api/CMakeFiles/paddle_api_light.dir/flags.make

lite/api/CMakeFiles/paddle_api_light.dir/light_api.cc.o: lite/api/CMakeFiles/paddle_api_light.dir/flags.make
lite/api/CMakeFiles/paddle_api_light.dir/light_api.cc.o: ../lite/api/light_api.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object lite/api/CMakeFiles/paddle_api_light.dir/light_api.cc.o"
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/lite/api && /opt/software/gcc-linaro-5.4.1-2017.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/paddle_api_light.dir/light_api.cc.o -c /opt/nna/Paddle-Lite/lite/api/light_api.cc

lite/api/CMakeFiles/paddle_api_light.dir/light_api.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/paddle_api_light.dir/light_api.cc.i"
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/lite/api && /opt/software/gcc-linaro-5.4.1-2017.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /opt/nna/Paddle-Lite/lite/api/light_api.cc > CMakeFiles/paddle_api_light.dir/light_api.cc.i

lite/api/CMakeFiles/paddle_api_light.dir/light_api.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/paddle_api_light.dir/light_api.cc.s"
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/lite/api && /opt/software/gcc-linaro-5.4.1-2017.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /opt/nna/Paddle-Lite/lite/api/light_api.cc -o CMakeFiles/paddle_api_light.dir/light_api.cc.s

lite/api/CMakeFiles/paddle_api_light.dir/light_api.cc.o.requires:

.PHONY : lite/api/CMakeFiles/paddle_api_light.dir/light_api.cc.o.requires

lite/api/CMakeFiles/paddle_api_light.dir/light_api.cc.o.provides: lite/api/CMakeFiles/paddle_api_light.dir/light_api.cc.o.requires
	$(MAKE) -f lite/api/CMakeFiles/paddle_api_light.dir/build.make lite/api/CMakeFiles/paddle_api_light.dir/light_api.cc.o.provides.build
.PHONY : lite/api/CMakeFiles/paddle_api_light.dir/light_api.cc.o.provides

lite/api/CMakeFiles/paddle_api_light.dir/light_api.cc.o.provides.build: lite/api/CMakeFiles/paddle_api_light.dir/light_api.cc.o


lite/api/CMakeFiles/paddle_api_light.dir/paddle_api.cc.o: lite/api/CMakeFiles/paddle_api_light.dir/flags.make
lite/api/CMakeFiles/paddle_api_light.dir/paddle_api.cc.o: ../lite/api/paddle_api.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object lite/api/CMakeFiles/paddle_api_light.dir/paddle_api.cc.o"
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/lite/api && /opt/software/gcc-linaro-5.4.1-2017.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/paddle_api_light.dir/paddle_api.cc.o -c /opt/nna/Paddle-Lite/lite/api/paddle_api.cc

lite/api/CMakeFiles/paddle_api_light.dir/paddle_api.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/paddle_api_light.dir/paddle_api.cc.i"
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/lite/api && /opt/software/gcc-linaro-5.4.1-2017.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /opt/nna/Paddle-Lite/lite/api/paddle_api.cc > CMakeFiles/paddle_api_light.dir/paddle_api.cc.i

lite/api/CMakeFiles/paddle_api_light.dir/paddle_api.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/paddle_api_light.dir/paddle_api.cc.s"
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/lite/api && /opt/software/gcc-linaro-5.4.1-2017.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /opt/nna/Paddle-Lite/lite/api/paddle_api.cc -o CMakeFiles/paddle_api_light.dir/paddle_api.cc.s

lite/api/CMakeFiles/paddle_api_light.dir/paddle_api.cc.o.requires:

.PHONY : lite/api/CMakeFiles/paddle_api_light.dir/paddle_api.cc.o.requires

lite/api/CMakeFiles/paddle_api_light.dir/paddle_api.cc.o.provides: lite/api/CMakeFiles/paddle_api_light.dir/paddle_api.cc.o.requires
	$(MAKE) -f lite/api/CMakeFiles/paddle_api_light.dir/build.make lite/api/CMakeFiles/paddle_api_light.dir/paddle_api.cc.o.provides.build
.PHONY : lite/api/CMakeFiles/paddle_api_light.dir/paddle_api.cc.o.provides

lite/api/CMakeFiles/paddle_api_light.dir/paddle_api.cc.o.provides.build: lite/api/CMakeFiles/paddle_api_light.dir/paddle_api.cc.o


lite/api/CMakeFiles/paddle_api_light.dir/light_api_impl.cc.o: lite/api/CMakeFiles/paddle_api_light.dir/flags.make
lite/api/CMakeFiles/paddle_api_light.dir/light_api_impl.cc.o: ../lite/api/light_api_impl.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object lite/api/CMakeFiles/paddle_api_light.dir/light_api_impl.cc.o"
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/lite/api && /opt/software/gcc-linaro-5.4.1-2017.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/paddle_api_light.dir/light_api_impl.cc.o -c /opt/nna/Paddle-Lite/lite/api/light_api_impl.cc

lite/api/CMakeFiles/paddle_api_light.dir/light_api_impl.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/paddle_api_light.dir/light_api_impl.cc.i"
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/lite/api && /opt/software/gcc-linaro-5.4.1-2017.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /opt/nna/Paddle-Lite/lite/api/light_api_impl.cc > CMakeFiles/paddle_api_light.dir/light_api_impl.cc.i

lite/api/CMakeFiles/paddle_api_light.dir/light_api_impl.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/paddle_api_light.dir/light_api_impl.cc.s"
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/lite/api && /opt/software/gcc-linaro-5.4.1-2017.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /opt/nna/Paddle-Lite/lite/api/light_api_impl.cc -o CMakeFiles/paddle_api_light.dir/light_api_impl.cc.s

lite/api/CMakeFiles/paddle_api_light.dir/light_api_impl.cc.o.requires:

.PHONY : lite/api/CMakeFiles/paddle_api_light.dir/light_api_impl.cc.o.requires

lite/api/CMakeFiles/paddle_api_light.dir/light_api_impl.cc.o.provides: lite/api/CMakeFiles/paddle_api_light.dir/light_api_impl.cc.o.requires
	$(MAKE) -f lite/api/CMakeFiles/paddle_api_light.dir/build.make lite/api/CMakeFiles/paddle_api_light.dir/light_api_impl.cc.o.provides.build
.PHONY : lite/api/CMakeFiles/paddle_api_light.dir/light_api_impl.cc.o.provides

lite/api/CMakeFiles/paddle_api_light.dir/light_api_impl.cc.o.provides.build: lite/api/CMakeFiles/paddle_api_light.dir/light_api_impl.cc.o


lite/api/CMakeFiles/paddle_api_light.dir/paddle_place.cc.o: lite/api/CMakeFiles/paddle_api_light.dir/flags.make
lite/api/CMakeFiles/paddle_api_light.dir/paddle_place.cc.o: ../lite/api/paddle_place.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object lite/api/CMakeFiles/paddle_api_light.dir/paddle_place.cc.o"
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/lite/api && /opt/software/gcc-linaro-5.4.1-2017.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/paddle_api_light.dir/paddle_place.cc.o -c /opt/nna/Paddle-Lite/lite/api/paddle_place.cc

lite/api/CMakeFiles/paddle_api_light.dir/paddle_place.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/paddle_api_light.dir/paddle_place.cc.i"
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/lite/api && /opt/software/gcc-linaro-5.4.1-2017.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /opt/nna/Paddle-Lite/lite/api/paddle_place.cc > CMakeFiles/paddle_api_light.dir/paddle_place.cc.i

lite/api/CMakeFiles/paddle_api_light.dir/paddle_place.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/paddle_api_light.dir/paddle_place.cc.s"
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/lite/api && /opt/software/gcc-linaro-5.4.1-2017.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /opt/nna/Paddle-Lite/lite/api/paddle_place.cc -o CMakeFiles/paddle_api_light.dir/paddle_place.cc.s

lite/api/CMakeFiles/paddle_api_light.dir/paddle_place.cc.o.requires:

.PHONY : lite/api/CMakeFiles/paddle_api_light.dir/paddle_place.cc.o.requires

lite/api/CMakeFiles/paddle_api_light.dir/paddle_place.cc.o.provides: lite/api/CMakeFiles/paddle_api_light.dir/paddle_place.cc.o.requires
	$(MAKE) -f lite/api/CMakeFiles/paddle_api_light.dir/build.make lite/api/CMakeFiles/paddle_api_light.dir/paddle_place.cc.o.provides.build
.PHONY : lite/api/CMakeFiles/paddle_api_light.dir/paddle_place.cc.o.provides

lite/api/CMakeFiles/paddle_api_light.dir/paddle_place.cc.o.provides.build: lite/api/CMakeFiles/paddle_api_light.dir/paddle_place.cc.o


# Object files for target paddle_api_light
paddle_api_light_OBJECTS = \
"CMakeFiles/paddle_api_light.dir/light_api.cc.o" \
"CMakeFiles/paddle_api_light.dir/paddle_api.cc.o" \
"CMakeFiles/paddle_api_light.dir/light_api_impl.cc.o" \
"CMakeFiles/paddle_api_light.dir/paddle_place.cc.o"

# External object files for target paddle_api_light
paddle_api_light_EXTERNAL_OBJECTS =

lite/api/libpaddle_api_light.a: lite/api/CMakeFiles/paddle_api_light.dir/light_api.cc.o
lite/api/libpaddle_api_light.a: lite/api/CMakeFiles/paddle_api_light.dir/paddle_api.cc.o
lite/api/libpaddle_api_light.a: lite/api/CMakeFiles/paddle_api_light.dir/light_api_impl.cc.o
lite/api/libpaddle_api_light.a: lite/api/CMakeFiles/paddle_api_light.dir/paddle_place.cc.o
lite/api/libpaddle_api_light.a: lite/api/CMakeFiles/paddle_api_light.dir/build.make
lite/api/libpaddle_api_light.a: lite/api/CMakeFiles/paddle_api_light.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Linking CXX static library libpaddle_api_light.a"
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/lite/api && $(CMAKE_COMMAND) -P CMakeFiles/paddle_api_light.dir/cmake_clean_target.cmake
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/lite/api && $(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/paddle_api_light.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
lite/api/CMakeFiles/paddle_api_light.dir/build: lite/api/libpaddle_api_light.a

.PHONY : lite/api/CMakeFiles/paddle_api_light.dir/build

lite/api/CMakeFiles/paddle_api_light.dir/requires: lite/api/CMakeFiles/paddle_api_light.dir/light_api.cc.o.requires
lite/api/CMakeFiles/paddle_api_light.dir/requires: lite/api/CMakeFiles/paddle_api_light.dir/paddle_api.cc.o.requires
lite/api/CMakeFiles/paddle_api_light.dir/requires: lite/api/CMakeFiles/paddle_api_light.dir/light_api_impl.cc.o.requires
lite/api/CMakeFiles/paddle_api_light.dir/requires: lite/api/CMakeFiles/paddle_api_light.dir/paddle_place.cc.o.requires

.PHONY : lite/api/CMakeFiles/paddle_api_light.dir/requires

lite/api/CMakeFiles/paddle_api_light.dir/clean:
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/lite/api && $(CMAKE_COMMAND) -P CMakeFiles/paddle_api_light.dir/cmake_clean.cmake
.PHONY : lite/api/CMakeFiles/paddle_api_light.dir/clean

lite/api/CMakeFiles/paddle_api_light.dir/depend:
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /opt/nna/Paddle-Lite /opt/nna/Paddle-Lite/lite/api /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/lite/api /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/lite/api/CMakeFiles/paddle_api_light.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : lite/api/CMakeFiles/paddle_api_light.dir/depend

