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

# Utility rule file for bundle_full_api.

# Include the progress variables for this target.
include lite/api/CMakeFiles/bundle_full_api.dir/progress.make

bundle_full_api: lite/api/CMakeFiles/bundle_full_api.dir/build.make
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold "Bundling paddle_api_full_bundled"
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/lite/api && rm -f /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/libpaddle_api_full_bundled.a
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/lite/api && /opt/software/gcc-linaro-5.4.1-2017.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-ar -M < /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/paddle_api_full_bundled.ar
.PHONY : bundle_full_api

# Rule to build all files generated by this target.
lite/api/CMakeFiles/bundle_full_api.dir/build: bundle_full_api

.PHONY : lite/api/CMakeFiles/bundle_full_api.dir/build

lite/api/CMakeFiles/bundle_full_api.dir/clean:
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/lite/api && $(CMAKE_COMMAND) -P CMakeFiles/bundle_full_api.dir/cmake_clean.cmake
.PHONY : lite/api/CMakeFiles/bundle_full_api.dir/clean

lite/api/CMakeFiles/bundle_full_api.dir/depend:
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /opt/nna/Paddle-Lite /opt/nna/Paddle-Lite/lite/api /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/lite/api /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/lite/api/CMakeFiles/bundle_full_api.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : lite/api/CMakeFiles/bundle_full_api.dir/depend

