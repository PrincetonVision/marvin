# Marvin

Marvin is a GPU-only neural network framework made with simplicity, hackability, speed, memory consumption, and high dimensional data in mind.

## Dependences

Download [CUDA 7.5](https://developer.nvidia.com/cuda-downloads) and [cuDNN 5.1](https://developer.nvidia.com/cudnn). You will need to register with NVIDIA. Below are some additional steps to set up cuDNN 5.1. **NOTE** We highly recommend that you install different versions of cuDNN to different directories (e.g., ```/usr/local/cudnn/vXX```) because different software packages may require different versions.

```shell
LIB_DIR=lib$([[ $(uname) == "Linux" ]] && echo 64)
CUDNN_LIB_DIR=/usr/local/cudnn/v5.1/$LIB_DIR
echo LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDNN_LIB_DIR >> ~/.profile && ~/.profile

tar zxvf cudnn*.tgz
sudo cp cuda/$LIB_DIR/* $CUDNN_LIB_DIR/
sudo cp cuda/include/* /usr/local/cudnn/v5.1/include/
```

## Compilation

```shell
./compile.sh
```

## MNIST

1. Prepare data: run examples/mnist/prepare_mnist.m in Matlab
2. Train a model: run ./examples/mnist/demo.sh in shell
3. Visualize filters: run examples/mnist/demo_vis_filter.m in Matlab

## Tutorials and Documentation
Please see our website at [http://marvin.is](http://marvin.is).

## Citation
The following is the citation of the current version of Marvin. Note that the reference may change in the future when new contributors join the project.

```latex
@misc{Marvin20151110,
      title        = {Marvin: A minimalist {GPU}-only {N}-dimensional {ConvNet} framework},
      author       = {Jianxiong Xiao and Shuran Song and Daniel Suo and Fisher Yu},
      howpublished = {\url{http://marvin.is}},
      note         = {Accessed: 2015-11-10}
}
```

## Acknowledgements
Marvin stands on the shoulders of others who have open-sourced their work. You can find the source code of their projects along with license information below. We acknowledge and are grateful to these developers and researchers for their contributions to open source.

- [Fast-RCNN](https://github.com/rbgirshick/fast-rcnn) ([License](https://github.com/rbgirshick/fast-rcnn/blob/master/LICENSE)) Copyright (c) Microsoft Corporation
- [Darknet](https://github.com/pjreddie/darknet) ([License](https://github.com/pjreddie/darknet/blob/master/LICENSE))
- [Caffe](https://github.com/BVLC/caffe/) ([License](https://github.com/BVLC/caffe/blob/master/LICENSE)) Copyright (c) 2014, 2015 The Regents of the University of California
- [Mocha.jl](https://github.com/pluskid/Mocha.jl) ([License](https://github.com/pluskid/Mocha.jl/blob/master/LICENSE.md)) Copyright (c) 2014 Chiyuan Zhuang
- [Fast Depth-RCNN](https://github.com/s-gupta/fast-rcnn/tree/distillation) ([License](https://github.com/s-gupta/fast-rcnn/blob/distillation/LICENSE_fast_rcnn)) Copyright (c) Microsoft Corporation
