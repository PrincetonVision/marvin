#Marvin#

Marvin is a GPU-only neural network framework made with simplicity, hackability, speed, memory consumption, and high dimensional data in mind.

#Dependences#

Download [CUDA 7.5](https://developer.nvidia.com/cuda-downloads) and [cuDNN 3](https://developer.nvidia.com/cudnn). You will need to register with NVIDIA. Below are some additional steps to set up cuDNN 3:

```shell
CUDA_LIB_DIR=/usr/local/cuda/lib$([[ $(uname) == "Linux" ]] && echo 64)
echo LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_LIB_DIR >> ~/.profile && ~/.profile

tar zxvf cudnn*.tgz
sudo cp cuda/lib/* $CUDA_LIB_DIR
sudo cp cuda/include/* /usr/local/cuda/include
```

#Compilation#

```shell
./compile.sh
```

#MNIST#

1. Prepare data: run examples/mnist/prepare_mnist.m in Matlab
2. Train a model: run ./examples/mnist/demo.sh in shell
3. Visualize filters: run examples/mnist/demo_vis_filter.m in Matlab

#Tutorials and Documentation#
Please see our website at [http://marvin.is](http://marvin.is).
