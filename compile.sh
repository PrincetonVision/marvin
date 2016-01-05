#!/bin/bash

export PATH=$PATH:/usr/local/cuda/bin

if uname | grep -q Darwin; then
  CUDA_LIB_DIR=/usr/local/cuda/lib
  CUDNN_LIB_DIR=/usr/local/cudnn/v4rc/lib
elif uname | grep -q Linux; then
  CUDA_LIB_DIR=/usr/local/cuda/lib64
  CUDNN_LIB_DIR=/usr/local/cudnn/v4rc/lib64
fi

nvcc -std=c++11 -O3 -o marvin marvin.cu -I/usr/local/cuda/include -I/usr/local/cudnn/v4rc/include -L$CUDA_LIB_DIR -L$CUDNN_LIB_DIR -lcudart -lcublas -lcudnn -lcurand