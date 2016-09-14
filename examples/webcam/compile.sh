#!/bin/bash

export PATH=$PATH:/usr/local/cuda/bin

if uname | grep -q Darwin; then
  CUDA_LIB_DIR=/usr/local/cuda/lib
  CUDNN_LIB_DIR=/usr/local/cudnn/v5/lib
elif uname | grep -q Linux; then
  CUDA_LIB_DIR=/usr/local/cuda/lib64
  CUDNN_LIB_DIR=/usr/local/cudnn/v5/lib64
fi

nvcc -std=c++11 -O3 -o examples/webcam/webcam examples/webcam/webcam.cu -I/usr/local/cuda/include -I/usr/local/cudnn/v5/include -L$CUDA_LIB_DIR -L$CUDNN_LIB_DIR `pkg-config --cflags --libs opencv` -lcudart -lcublas -lcudnn -lcurand -D_MWAITXINTRIN_H_INCLUDED
