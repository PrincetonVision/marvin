#!/bin/bash

if uname | grep -q Darwin; then
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cudnn/v4rc/lib
elif uname | grep -q Linux; then
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64
  export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cudnn/v4rc/lib64
fi


rm examples/char-lstm/prob.tensor

./marvin test examples/char-lstm/char-lstm-gen2.json examples/char-lstm/char-lstm2_snapshot_10000.marvin prob examples/char-lstm/prob.tensor
