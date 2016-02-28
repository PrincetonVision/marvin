cmake_minimum_required(VERSION 2.8.10)

project(Marvin C CXX)

find_package(CUDA QUIET REQUIRED)

set(CUDA_HOST_COMPILER "c++")
set(CUDA_NVCC_FLAGS "-std=c++11")

set(CUDNN_INCLUDE_DIR /usr/local/cudnn/v4/include CACHE PATH
        "Path to cudnn header file")

if(APPLE)
    set(CUDNN_LIB_DIR /usr/local/cudnn/v4/lib CACHE PATH "Path to cudnn library")
elseif(UNIX)
    set(CUDNN_LIB_DIR /usr/local/cudnn/v4/lib64 CACHE PATH "Path to cudnn library")
elseif(WIN32)
    # TODO
endif()

include_directories(${CUDNN_INCLUDE_DIR})
link_directories(${CUDNN_LIB_DIR})

cuda_add_executable(marvin marvin.hpp marvin.cu)

target_link_libraries(marvin pthread cudnn 
        ${CUDA_CUBLAS_LIBRARIES} ${CUDA_LIBRARIES} ${CUDA_curand_LIBRARY})
