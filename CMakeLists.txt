cmake_minimum_required(VERSION 2.8.10)

project(Marvin CXX)

find_package(CUDA QUIET REQUIRED)

set(CUDA_HOST_COMPILER "c++")
set(CUDA_NVCC_FLAGS "-std=c++11")
set(CUDA_INCLUDE_DIR /usr/local/cuda/include)
set(CUDA_LIB_DIR /usr/local/cuda/lib64)
set(CUDNN_INCLUDE_DIR ${CUDA_INCLUDE_DIR})
set(CUDNN_LIB_DIR ${CUDA_LIB_DIR})

include_directories(${CUDA_INCLUDE_DIR} ${CUDNN_INCLUDE_DIR})
link_directories(${CUDA_LIB_DIR} ${CUDNN_LIB_DIR})

cuda_add_executable(marvin marvin.hpp marvin.cu)
target_link_libraries(marvin cudart cublas cudnn)
