#!/bin/bash

if uname | grep -q Darwin; then
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cudnn/v5/lib
elif uname | grep -q Linux; then
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cudnn/v5/lib64
fi


./marvin train examples/FCN_VGG/FCN32s.json examples/FCN_VGG/vgg16_imagenet_half.marvin

