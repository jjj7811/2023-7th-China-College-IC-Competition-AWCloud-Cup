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
CMAKE_SOURCE_DIR = /opt/nna/ssd_detection_demo/ssd_hdmi

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /opt/nna/ssd_detection_demo/ssd_hdmi/build

# Include any dependencies generated for this target.
include CMakeFiles/ssd_hdmi.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/ssd_hdmi.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/ssd_hdmi.dir/flags.make

CMakeFiles/ssd_hdmi.dir/ssd_hdmi.cc.o: CMakeFiles/ssd_hdmi.dir/flags.make
CMakeFiles/ssd_hdmi.dir/ssd_hdmi.cc.o: ../ssd_hdmi.cc
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/opt/nna/ssd_detection_demo/ssd_hdmi/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Building CXX object CMakeFiles/ssd_hdmi.dir/ssd_hdmi.cc.o"
	/opt/software/gcc-linaro-5.4.1-2017.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/ssd_hdmi.dir/ssd_hdmi.cc.o -c /opt/nna/ssd_detection_demo/ssd_hdmi/ssd_hdmi.cc

CMakeFiles/ssd_hdmi.dir/ssd_hdmi.cc.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/ssd_hdmi.dir/ssd_hdmi.cc.i"
	/opt/software/gcc-linaro-5.4.1-2017.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /opt/nna/ssd_detection_demo/ssd_hdmi/ssd_hdmi.cc > CMakeFiles/ssd_hdmi.dir/ssd_hdmi.cc.i

CMakeFiles/ssd_hdmi.dir/ssd_hdmi.cc.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/ssd_hdmi.dir/ssd_hdmi.cc.s"
	/opt/software/gcc-linaro-5.4.1-2017.05-x86_64_arm-linux-gnueabihf/bin/arm-linux-gnueabihf-g++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /opt/nna/ssd_detection_demo/ssd_hdmi/ssd_hdmi.cc -o CMakeFiles/ssd_hdmi.dir/ssd_hdmi.cc.s

CMakeFiles/ssd_hdmi.dir/ssd_hdmi.cc.o.requires:

.PHONY : CMakeFiles/ssd_hdmi.dir/ssd_hdmi.cc.o.requires

CMakeFiles/ssd_hdmi.dir/ssd_hdmi.cc.o.provides: CMakeFiles/ssd_hdmi.dir/ssd_hdmi.cc.o.requires
	$(MAKE) -f CMakeFiles/ssd_hdmi.dir/build.make CMakeFiles/ssd_hdmi.dir/ssd_hdmi.cc.o.provides.build
.PHONY : CMakeFiles/ssd_hdmi.dir/ssd_hdmi.cc.o.provides

CMakeFiles/ssd_hdmi.dir/ssd_hdmi.cc.o.provides.build: CMakeFiles/ssd_hdmi.dir/ssd_hdmi.cc.o


# Object files for target ssd_hdmi
ssd_hdmi_OBJECTS = \
"CMakeFiles/ssd_hdmi.dir/ssd_hdmi.cc.o"

# External object files for target ssd_hdmi
ssd_hdmi_EXTERNAL_OBJECTS =

ssd_hdmi: CMakeFiles/ssd_hdmi.dir/ssd_hdmi.cc.o
ssd_hdmi: CMakeFiles/ssd_hdmi.dir/build.make
ssd_hdmi: /opt/nna/ssd_detection_demo/ocv3.1.0/lib/libopencv_videostab.so.3.1.0
ssd_hdmi: /opt/nna/ssd_detection_demo/ocv3.1.0/lib/libopencv_superres.so.3.1.0
ssd_hdmi: /opt/nna/ssd_detection_demo/ocv3.1.0/lib/libopencv_stitching.so.3.1.0
ssd_hdmi: /opt/nna/ssd_detection_demo/ocv3.1.0/lib/libopencv_shape.so.3.1.0
ssd_hdmi: /opt/nna/ssd_detection_demo/ocv3.1.0/lib/libopencv_photo.so.3.1.0
ssd_hdmi: /opt/nna/ssd_detection_demo/ocv3.1.0/lib/libopencv_objdetect.so.3.1.0
ssd_hdmi: /opt/nna/ssd_detection_demo/ocv3.1.0/lib/libopencv_calib3d.so.3.1.0
ssd_hdmi: /opt/nna/ssd_detection_demo/ocv3.1.0/lib/libopencv_features2d.so.3.1.0
ssd_hdmi: /opt/nna/ssd_detection_demo/ocv3.1.0/lib/libopencv_ml.so.3.1.0
ssd_hdmi: /opt/nna/ssd_detection_demo/ocv3.1.0/lib/libopencv_highgui.so.3.1.0
ssd_hdmi: /opt/nna/ssd_detection_demo/ocv3.1.0/lib/libopencv_videoio.so.3.1.0
ssd_hdmi: /opt/nna/ssd_detection_demo/ocv3.1.0/lib/libopencv_imgcodecs.so.3.1.0
ssd_hdmi: /opt/nna/ssd_detection_demo/ocv3.1.0/lib/libopencv_flann.so.3.1.0
ssd_hdmi: /opt/nna/ssd_detection_demo/ocv3.1.0/lib/libopencv_video.so.3.1.0
ssd_hdmi: /opt/nna/ssd_detection_demo/ocv3.1.0/lib/libopencv_imgproc.so.3.1.0
ssd_hdmi: /opt/nna/ssd_detection_demo/ocv3.1.0/lib/libopencv_core.so.3.1.0
ssd_hdmi: CMakeFiles/ssd_hdmi.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/opt/nna/ssd_detection_demo/ssd_hdmi/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Linking CXX executable ssd_hdmi"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/ssd_hdmi.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/ssd_hdmi.dir/build: ssd_hdmi

.PHONY : CMakeFiles/ssd_hdmi.dir/build

CMakeFiles/ssd_hdmi.dir/requires: CMakeFiles/ssd_hdmi.dir/ssd_hdmi.cc.o.requires

.PHONY : CMakeFiles/ssd_hdmi.dir/requires

CMakeFiles/ssd_hdmi.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/ssd_hdmi.dir/cmake_clean.cmake
.PHONY : CMakeFiles/ssd_hdmi.dir/clean

CMakeFiles/ssd_hdmi.dir/depend:
	cd /opt/nna/ssd_detection_demo/ssd_hdmi/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /opt/nna/ssd_detection_demo/ssd_hdmi /opt/nna/ssd_detection_demo/ssd_hdmi /opt/nna/ssd_detection_demo/ssd_hdmi/build /opt/nna/ssd_detection_demo/ssd_hdmi/build /opt/nna/ssd_detection_demo/ssd_hdmi/build/CMakeFiles/ssd_hdmi.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/ssd_hdmi.dir/depend

