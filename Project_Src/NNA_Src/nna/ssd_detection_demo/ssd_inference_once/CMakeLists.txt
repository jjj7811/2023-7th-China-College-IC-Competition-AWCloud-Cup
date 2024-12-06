cmake_minimum_required(VERSION 3.1)
set(CMAKE_SYSTEM_NAME Linux)
# message(STATUS ${TARGET_ARCH_ABI})
# message(STATUS ${DETECTION_TARGET})
# message(STATUS ${CAMERA_TYPE})
if(TARGET_ARCH_ABI STREQUAL "armv8")
    set(CMAKE_SYSTEM_PROCESSOR aarch64)
    set(CMAKE_C_COMPILER "aarch64-linux-gnu-gcc")
    set(CMAKE_CXX_COMPILER "aarch64-linux-gnu-g++")
    # message(STATUS "ARCH ABI: armv8")
elseif(TARGET_ARCH_ABI STREQUAL "armv7hf")
    set(CMAKE_SYSTEM_PROCESSOR arm)
    set(CMAKE_C_COMPILER "arm-linux-gnueabihf-gcc")
    set(CMAKE_CXX_COMPILER "arm-linux-gnueabihf-g++")
    # message(STATUS "ARCH ABI: armv7hf")
else()
    message(FATAL_ERROR "Unknown arch abi ${TARGET_ARCH_ABI}, only support armv8 and armv7hf.")
    return()
endif()

if(DETECTION_TARGET STREQUAL "camera")
    add_definitions(-DUSE_CAM)
    # message(STATUS "Detection Target: USE_CAM")
else()
    # message(STATUS "Detection Target: PICTURE")
endif()

if(CAMERA_TYPE STREQUAL "aiep")
    add_definitions(-DUSE_AIEP)
    # message(STATUS "Camera Type: USE_AIEP")
else()
    # message(STATUS "Camera Type: USBCAM")
endif()

project(object_detection_demo)
message(STATUS "TARGET ARCH ABI: ${TARGET_ARCH_ABI}")
message(STATUS "PADDLE LITE DIR: ${PADDLE_LITE_DIR}")
include_directories(${PADDLE_LITE_DIR}/include)
link_directories(${PADDLE_LITE_DIR}/lib) #s/${TARGET_ARCH_ABI})
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
if(TARGET_ARCH_ABI STREQUAL "armv8")
    set(CMAKE_CXX_FLAGS "-march=armv8-a ${CMAKE_CXX_FLAGS}")
    set(CMAKE_C_FLAGS "-march=armv8-a ${CMAKE_C_FLAGS}")
elseif(TARGET_ARCH_ABI STREQUAL "armv7hf")
    set(CMAKE_CXX_FLAGS "-march=armv7-a -mfloat-abi=hard -mfpu=neon ${CMAKE_CXX_FLAGS} -O3")
    set(CMAKE_C_FLAGS "-march=armv7-a -mfloat-abi=hard -mfpu=neon ${CMAKE_C_FLAGS} -O3")
endif()
find_package(OpenMP REQUIRED)
if(OpenMP_FOUND OR OpenMP_CXX_FOUND)
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
    message(STATUS "Found OpenMP ${OpenMP_VERSION} ${OpenMP_CXX_VERSION}")
    message(STATUS "OpenMP C flags:  ${OpenMP_C_FLAGS}")
    message(STATUS "OpenMP CXX flags:  ${OpenMP_CXX_FLAGS}")
    message(STATUS "OpenMP OpenMP_CXX_LIB_NAMES:  ${OpenMP_CXX_LIB_NAMES}")
    message(STATUS "OpenMP OpenMP_CXX_LIBRARIES:  ${OpenMP_CXX_LIBRARIES}")
else()
    message(FATAL_ERROR "Could not found OpenMP!")
    return()
endif()
if(TARGET_ARCH_ABI STREQUAL "armv8")
    set(OpenCV_DIR ../ocv3.4.4/share/OpenCV)
elseif(TARGET_ARCH_ABI STREQUAL "armv7hf")
    set(OpenCV_DIR ../ocv3.1.0/share/OpenCV)
endif()
find_package(OpenCV REQUIRED)
if(OpenCV_FOUND OR OpenCV_CXX_FOUND)
    include_directories(${OpenCV_INCLUDE_DIRS})
    message(STATUS "OpenCV library status:")
    message(STATUS "    version: ${OpenCV_VERSION}")
    message(STATUS "    libraries: ${OpenCV_LIBS}")
    message(STATUS "    include path: ${OpenCV_INCLUDE_DIRS}")
else()
    message(FATAL_ERROR "Could not found OpenCV!")
    return()
endif()
add_executable(ssd_inference_once ssd_inference_once.cc)
target_link_libraries(ssd_inference_once paddle_full_api_shared vnna ${OpenCV_LIBS})
