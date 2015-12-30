#!/bin/bash

if uname | grep -q Darwin; then
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cudnn/v4rc/lib
elif uname | grep -q Linux; then
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cudnn/v4rc/lib64
fi


./marvin train examples/mnist/lenet.json

