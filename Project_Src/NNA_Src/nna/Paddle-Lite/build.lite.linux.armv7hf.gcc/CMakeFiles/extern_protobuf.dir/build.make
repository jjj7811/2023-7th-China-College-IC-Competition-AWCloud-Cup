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

# Utility rule file for extern_protobuf.

# Include the progress variables for this target.
include CMakeFiles/extern_protobuf.dir/progress.make

CMakeFiles/extern_protobuf: CMakeFiles/extern_protobuf-complete


CMakeFiles/extern_protobuf-complete: third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-install
CMakeFiles/extern_protobuf-complete: third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-mkdir
CMakeFiles/extern_protobuf-complete: third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-download
CMakeFiles/extern_protobuf-complete: third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-update
CMakeFiles/extern_protobuf-complete: third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-patch
CMakeFiles/extern_protobuf-complete: third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-configure
CMakeFiles/extern_protobuf-complete: third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-build
CMakeFiles/extern_protobuf-complete: third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-install
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Completed 'extern_protobuf'"
	/opt/software/cmake-3.10.3-Linux-x86_64/bin/cmake -E make_directory /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/CMakeFiles
	/opt/software/cmake-3.10.3-Linux-x86_64/bin/cmake -E touch /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/CMakeFiles/extern_protobuf-complete
	/opt/software/cmake-3.10.3-Linux-x86_64/bin/cmake -E touch /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-done

third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-install: third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-build
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Performing install step for 'extern_protobuf'"
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/third_party/protobuf/src/extern_protobuf-build && $(MAKE) install
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/third_party/protobuf/src/extern_protobuf-build && /opt/software/cmake-3.10.3-Linux-x86_64/bin/cmake -E touch /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-install

third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-mkdir:
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Creating directories for 'extern_protobuf'"
	/opt/software/cmake-3.10.3-Linux-x86_64/bin/cmake -E make_directory /opt/nna/Paddle-Lite/third-party/protobuf-mobile
	/opt/software/cmake-3.10.3-Linux-x86_64/bin/cmake -E make_directory /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/third_party/protobuf/src/extern_protobuf-build
	/opt/software/cmake-3.10.3-Linux-x86_64/bin/cmake -E make_directory /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/third_party/protobuf
	/opt/software/cmake-3.10.3-Linux-x86_64/bin/cmake -E make_directory /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/third_party/protobuf/tmp
	/opt/software/cmake-3.10.3-Linux-x86_64/bin/cmake -E make_directory /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/third_party/protobuf/src/extern_protobuf-stamp
	/opt/software/cmake-3.10.3-Linux-x86_64/bin/cmake -E make_directory /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/third_party/protobuf/src
	/opt/software/cmake-3.10.3-Linux-x86_64/bin/cmake -E touch /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-mkdir

third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-download: third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-mkdir
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "No download step for 'extern_protobuf'"
	/opt/software/cmake-3.10.3-Linux-x86_64/bin/cmake -E echo_append
	/opt/software/cmake-3.10.3-Linux-x86_64/bin/cmake -E touch /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-download

third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-update: third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-download
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "No update step for 'extern_protobuf'"
	cd /opt/nna/Paddle-Lite/third-party/protobuf-mobile && /opt/software/cmake-3.10.3-Linux-x86_64/bin/cmake -E echo_append
	cd /opt/nna/Paddle-Lite/third-party/protobuf-mobile && /opt/software/cmake-3.10.3-Linux-x86_64/bin/cmake -E touch /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-update

third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-patch: third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-download
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "No patch step for 'extern_protobuf'"
	/opt/software/cmake-3.10.3-Linux-x86_64/bin/cmake -E echo_append
	/opt/software/cmake-3.10.3-Linux-x86_64/bin/cmake -E touch /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-patch

third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-configure: third_party/protobuf/tmp/extern_protobuf-cfgcmd.txt
third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-configure: third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-update
third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-configure: third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-patch
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Performing configure step for 'extern_protobuf'"
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/third_party/protobuf/src/extern_protobuf-build && /opt/software/cmake-3.10.3-Linux-x86_64/bin/cmake -P /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-configure-Release.cmake
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/third_party/protobuf/src/extern_protobuf-build && /opt/software/cmake-3.10.3-Linux-x86_64/bin/cmake -E touch /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-configure

third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-build: third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-configure
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Performing build step for 'extern_protobuf'"
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/third_party/protobuf/src/extern_protobuf-build && $(MAKE)
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/third_party/protobuf/src/extern_protobuf-build && /opt/software/cmake-3.10.3-Linux-x86_64/bin/cmake -E touch /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-build

extern_protobuf: CMakeFiles/extern_protobuf
extern_protobuf: CMakeFiles/extern_protobuf-complete
extern_protobuf: third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-install
extern_protobuf: third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-mkdir
extern_protobuf: third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-download
extern_protobuf: third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-update
extern_protobuf: third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-patch
extern_protobuf: third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-configure
extern_protobuf: third_party/protobuf/src/extern_protobuf-stamp/extern_protobuf-build
extern_protobuf: CMakeFiles/extern_protobuf.dir/build.make

.PHONY : extern_protobuf

# Rule to build all files generated by this target.
CMakeFiles/extern_protobuf.dir/build: extern_protobuf

.PHONY : CMakeFiles/extern_protobuf.dir/build

CMakeFiles/extern_protobuf.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/extern_protobuf.dir/cmake_clean.cmake
.PHONY : CMakeFiles/extern_protobuf.dir/clean

CMakeFiles/extern_protobuf.dir/depend:
	cd /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /opt/nna/Paddle-Lite /opt/nna/Paddle-Lite /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc /opt/nna/Paddle-Lite/build.lite.linux.armv7hf.gcc/CMakeFiles/extern_protobuf.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/extern_protobuf.dir/depend

