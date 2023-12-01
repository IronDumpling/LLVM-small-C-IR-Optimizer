cmake_minimum_required(VERSION 3.20)
project(A5Dom)


# LLVM CONFIGURATION
#===============================================================================
# Set this to a valid LLVM installation dir
set(LLVM_INSTALL_DIR "" CACHE PATH "/cad2/ece467f/llvm-project/build")

# Add the location of LLVMConfig.cmake to CMake search paths (so that
# find_package can locate it)
list(APPEND CMAKE_PREFIX_PATH "${LLVM_INSTALL_DIR}/lib/cmake/llvm/")

find_package(LLVM CONFIG)
if("${LLVM_VERSION_MAJOR}" VERSION_LESS 14)
  message(FATAL_ERROR "Found LLVM ${LLVM_VERSION_MAJOR}, but need LLVM 17 or above")
endif()

# The assignment includes headers from LLVM - set the include paths accordingly
include_directories(${LLVM_INSTALL_DIR}/include ${LLVM_INSTALL_DIR}/../llvm/include)

# BUILD CONFIGURATION
#===============================================================================
# Use the same C++ standard as LLVM does
set(CMAKE_CXX_STANDARD 17 CACHE STRING "")

# LLVM is normally built without RTTI. Be consistent with that.
if(NOT LLVM_ENABLE_RTTI)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-rtti")
endif()

# ADD THE ASSIGNMENT TARGET
#===============================================================================
add_library(A5Dom SHARED A5Dom.cpp)

# Allow undefined symbols in shared objects on Darwin (this is the default
# behaviour on Linux)
target_link_libraries(A5Dom
  "$<$<PLATFORM_ID:Darwin>:-undefined dynamic_lookup>")

