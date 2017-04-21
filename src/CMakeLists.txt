cmake_minimum_required(VERSION 2.8)
project(ORBSLAM2)

# Project version
#-----------------------------------------------------------------------------------------------------------------------
set(ORBSLAM2_MAJOR_VERSION 1)
set(ORBSLAM2_MINOR_VERSION 1)
set(ORBSLAM2_PATCH_VERSION 1)
set(ORBSLAM2_VERSION ${ORBSLAM2_MAJOR_VERSION}.${ORBSLAM2_MINOR_VERSION}.${ORBSLAM2_PATCH_VERSION})
set(ORBSLAM2_VERSION_STR ${ORBSLAM2_VERSION})
set(ORBSLAM2_VERSION_ID ${ORBSLAM2_MAJOR_VERSION}${ORBSLAM2_MINOR_VERSION}${ORBSLAM2_PATCH_VERSION})


# Building options
#-----------------------------------------------------------------------------------------------------------------------
option(BUILD_PYTHON3 "Build ORBSLAM2 Python3 binding instead of default Python2." OFF)

# CMake options
#-----------------------------------------------------------------------------------------------------------------------
# set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -Wall  -O3 -march=native ")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fpermissive -Wall  -O3 -march=native")

# Check C++11 or C++0x support
include(CheckCXXCompilerFlag)
CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)
CHECK_CXX_COMPILER_FLAG("-std=c++0x" COMPILER_SUPPORTS_CXX0X)
if(COMPILER_SUPPORTS_CXX11)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
    add_definitions(-DCOMPILEDWITHC11)
    message(STATUS "Using flag -std=c++11.")
elseif(COMPILER_SUPPORTS_CXX0X)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
    add_definitions(-DCOMPILEDWITHC0X)
    message(STATUS "Using flag -std=c++0x.")
else()
    message(FATAL_ERROR "The compiler ${CMAKE_CXX_COMPILER} has no C++11 support. Please use a different C++ compiler.")
endif()

if (COMMAND cmake_policy)
    cmake_policy(SET CMP0003 NEW)
endif (COMMAND cmake_policy)

# Add cmake_modules to module
set(CMAKE_MODULE_PATH
        ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}" "${PROJECT_SOURCE_DIR}"
        "${CMAKE_CURRENT_SOURCE_DIR}/cmake_modules")

# Set the release mode if not specified
if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif ()


# System dependent settings
#-----------------------------------------------------------------------------------------------------------------------
if (UNIX)
    set(Boost_USE_STATIC_LIBS OFF)
    set(Boost_USE_MULTITHREADED ON)
    set(Boost_USE_STATIC_RUNTIME OFF)
endif ()

# Compiler dependent settings
#-----------------------------------------------------------------------------------------------------------------------
if (CMAKE_COMPILER_IS_GNUCXX)
    add_definitions("-fPIC")
endif ()

# Targets
#-----------------------------------------------------------------------------------------------------------------------
find_package(Boost COMPONENTS filesystem thread system date_time chrono regex iostreams REQUIRED)
find_package(Threads REQUIRED)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

set(ORBSLAM2_OUTPUT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/build)
set(ORBSLAM2_SRC_DIR ${CMAKE_CURRENT_SOURCE_DIR})
set(ORBSLAM2_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR})
set(ORBSLAM2_LIB_SRC_DIR ${ORBSLAM2_SRC_DIR})
set(ORBSLAM2_LIB_INCLUDE_DIR ${ORBSLAM2_INCLUDE_DIR} ${ORBSLAM2_LIB_SRC_DIR})
set(ORBSLAM2_OUTPUT_NAME ORBSLAM2)

include_directories(${ORBSLAM2_LIB_INCLUDE_DIR} ${Boost_INCLUDE_DIR})

set(ORBSLAM2_LIBS
        ${Boost_LIBRARIES}
        ${CMAKE_THREAD_LIBS_INIT})

if (UNIX AND NOT APPLE)
    set(ORBSLAM2_LIBS ${ORBSLAM2_LIBS} rt)
endif ()

#configure_file(
#        "${ORBSLAM2_LIB_SRC_DIR}/ORBSLAM2Version.h.in"
#        "${ORBSLAM2_LIB_SRC_DIR}/ORBSLAM2Version.h"
#)

#configure_file(
#        "${ORBSLAM2_SRC_DIR}/ORBSLAM2/src/viz_version.h.in"
#        "${ORBSLAM2_SRC_DIR}/ORBSLAM2/src/viz_version.h"
#)

file(GLOB ORBSLAM2_LIB_SOURCES
#        ${ORBSLAM2_INCLUDE_DIR}/*.h
#        ${ORBSLAM2_LIB_SRC_DIR}/*.h
        ${ORBSLAM2_LIB_SRC_DIR}/*.cpp)

#add_library(libORBSLAM2_static STATIC ${ORBSLAM2_LIB_SOURCES})
#target_link_libraries(libORBSLAM2_static ${ORBSLAM2_LIBS})

add_library(libORBSLAM2_shared SHARED ${ORBSLAM2_LIB_SOURCES})
target_link_libraries(libORBSLAM2_shared ${ORBSLAM2_LIBS})

# set_target_properties(libORBSLAM2_static libORBSLAM2_shared
#        PROPERTIES
#        LINKER_LANGUAGE CXX
#        LIBRARY_OUTPUT_NAME ${ORBSLAM2_OUTPUT_NAME}
#        LIBRARY_OUTPUT_DIRECTORY ${ORBSLAM2_OUTPUT_DIR}
#        LIBRARY_OUTPUT_NAME_RELEASE ${ORBSLAM2_OUTPUT_NAME}
#        LIBRARY_OUTPUT_DIRECTORY_RELEASE ${ORBSLAM2_OUTPUT_DIR}
#        LIBRARY_OUTPUT_NAME_DEBUG ${ORBSLAM2_OUTPUT_NAME}-d
#        LIBRARY_OUTPUT_DIRECTORY_DEBUG ${ORBSLAM2_OUTPUT_DIR}
#        LIBRARY_OUTPUT_NAME_MINSIZEREL ${ORBSLAM2_OUTPUT_NAME}-msr
#        LIBRARY_OUTPUT_DIRECTORY_MINSIZEREL ${ORBSLAM2_OUTPUT_DIR}
#        LIBRARY_OUTPUT_NAME_RELWITHDEBINFO ${ORBSLAM2_OUTPUT_NAME}-rd
#        LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO ${ORBSLAM2_OUTPUT_DIR})


#set_target_properties(libORBSLAM2_static
#        PROPERTIES
#        PROJECT_LABEL "Static library")

set_target_properties(libORBSLAM2_shared
        PROPERTIES
        PROJECT_LABEL "Shared library")

#add_subdirectory(${ORBSLAM2_SRC_DIR}/ORBSLAM2)


#-----------------------------------------------------------------------------------------------------------------------

LIST(APPEND CMAKE_MODULE_PATH ${PROJECT_SOURCE_DIR}/../../../cmake_modules)

find_package(OpenCV 2.4.3 REQUIRED)
find_package(Eigen3 REQUIRED)
find_package(Pangolin REQUIRED)

find_package(OpenMP REQUIRED)
if (OPENMP_FOUND)
	message("omp found")
	set (CMAKE_C_FLAGS "${CMAKE_C_FLAGS} ${OpenMP_C_FLAGS}")
	set (CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}")
endif()

#-----------------------------------------------------------------------------------------------------------------------

# Python binding
#-----------------------------------------------------------------------------------------------------------------------

if (BUILD_PYTHON3)

    find_package(PythonInterp 3 REQUIRED)

    # 3.5.2 => 3.5
    STRING(REGEX REPLACE "([0-9.]+)\\.[0-9]+" "\\1" python3_version ${PYTHON_VERSION_STRING})
    find_package(PythonLibs ${python3_version} REQUIRED)

    # 3.5 => 35 (at least on Ubuntu 16.04 the library is called libboost_python-py35.so)
    STRING(REGEX REPLACE "\\." "" python3_version ${python3_version})
    find_package(Boost QUIET COMPONENTS python-py${python3_version})
    if (${Boost_PYTHON-PY${python3_version}_FOUND})
        MESSAGE(STATUS "Found Boost python3:")
        MESSAGE(STATUS "   ${Boost_PYTHON-PY${python3_version}_LIBRARY}")
    else ()
        find_package(Boost QUIET COMPONENTS python3)  # The name under OSX (macports)
        if (${Boost_PYTHON3_FOUND})
            MESSAGE(STATUS "Found Boost python3:")
            Message(STATUS "  ${Boost_PYTHON3_LIBRARY}")
        else ()
            MESSAGE(FATAL_ERROR "Could not find boost python3")
        endif ()
    endif ()

    find_package(NumPy REQUIRED)

    set(ORBSLAM2_PYTHON3_OUTPUT_DIR ${ORBSLAM2_OUTPUT_DIR})
    set(ORBSLAM2_PYTHON_SRC_DIR ${ORBSLAM2_SRC_DIR})
    set(ORBSLAM2_PYTHON_INCLUDE_DIR ${ORBSLAM2_INCLUDE_DIR} ${ORBSLAM2_PYTHON_SRC_DIR})

    set(ORBSLAM2_PYTHON3_LIBS
            ${ORBSLAM2_LIBS}
            ${Boost_LIBRARIES}
            ${PYTHON_LIBRARIES}
            ${NUMPY_LIBRARIES}
            ${OpenCV_LIBS}
            ${EIGEN3_LIBS}
            ${Pangolin_LIBRARIES}
            ${ORBSLAM2_LIBRARY}
            ${BG2O_LIBRARY}
            ${DBoW2_LIBRARY})

    include_directories(${ORBSLAM2_PYTHON_INCLUDE_DIR}
            ${Boost_INCLUDE_DIR}
            ${PYTHON_INCLUDE_DIRS}
            ${NUMPY_INCLUDES}
            ${Pangolin_INCLUDE_DIRS})

    set(ORBSLAM2_PYTHON_SOURCES
#            ${ORBSLAM2_PYTHON_SRC_DIR}/ORBSLAM2GamePython.h
#            ${ORBSLAM2_PYTHON_SRC_DIR}/ORBSLAM2GamePython.cpp
            ${ORBSLAM2_PYTHON_SRC_DIR}/orbslam2.cpp
            ${ORBSLAM2_PYTHON_SRC_DIR}/lib/conversion.cpp)

    if (WIN32)
        add_definitions(-DBOOST_PYTHON_STATIC_LIB)
    endif ()

    python_add_module(libORBSLAM2_python3 ${ORBSLAM2_PYTHON_SOURCES})
    target_link_libraries(libORBSLAM2_python3 ${ORBSLAM2_PYTHON3_LIBS} ) # libORBSLAM2_static

    set_target_properties(libORBSLAM2_python3
            PROPERTIES
            LIBRARY_OUTPUT_DIRECTORY ${ORBSLAM2_PYTHON3_OUTPUT_DIR}
            LIBRARY_OUTPUT_DIRECTORY_DEBUG ${ORBSLAM2_PYTHON3_OUTPUT_DIR}
            LIBRARY_OUTPUT_DIRECTORY_RELEASE ${ORBSLAM2_PYTHON3_OUTPUT_DIR}
            LIBRARY_OUTPUT_DIRECTORY_MINSIZEREL ${ORBSLAM2_PYTHON3_OUTPUT_DIR}
            LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO ${ORBSLAM2_PYTHON3_OUTPUT_DIR}
            OUTPUT_NAME ORBSLAM2
            PROJECT_LABEL "Python 3 binding")

#    add_dependencies(libORBSLAM2_python3 ORBSLAM2 pk3 freedoom2)

#    if (UNIX)
#        add_custom_target(python3_pip_package ALL
#                COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/scripts/assemble_pip_package.sh 3
#                COMMENT "Assembling pip package in ${ORBSLAM2_PYTHON3_OUTPUT_DIR}/pip_package")
#
#        # ORBSLAM2, ORBSLAM2.pk3 and freedoom2.wad are needed to assemble the package
#        add_dependencies(python3_pip_package libORBSLAM2_python3 ORBSLAM2 pk3 freedoom2)
#    endif ()

endif ()

# ------------------------------------ ORBSLAM2 section