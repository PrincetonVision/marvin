# Marvin

Marvin is a GPU-only neural network framework made with simplicity, hackability, speed, memory consumption, and high dimensional data in mind.

## Dependencies

Download [CUDA 7.5](https://developer.nvidia.com/cuda-downloads) and [cuDNN 3](https://developer.nvidia.com/cudnn). You will need to register with NVIDIA. For Windows, you will need to download Microsoft Visual Studio 2013 [here](http://go.microsoft.com/fwlink/?LinkId=517284). Below are some additional steps to set up cuDNN 3:

### Linux and OS X
```shell
CUDA_LIB_DIR=/usr/local/cuda/lib$([[ $(uname) == "Linux" ]] && echo 64)
echo LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_LIB_DIR >> ~/.profile && ~/.profile

tar zxvf cudnn*.tgz
sudo cp cuda/lib/* $CUDA_LIB_DIR
sudo cp cuda/include/* /usr/local/cuda/include
```

### Windows
- Copy ```CUDNN_PATH/bin/*``` to ```CUDA_PATH/bin```
- Copy ```CUDNN_PATH/lib/*``` to ```CUDA_PATH/lib```
- Copy ```CUDNN_PATH/include/*``` to ```CUDA_PATH/include```

## Compilation

### Linux and OS X
```shell
./compile.sh
```

### Windows
- Create a new project in Visual Studio 2013
  - File -> New Project (Ctrl-Shift-N)
  - Installed -> Templates -> NVIDIA -> CUDA 7.5
- Add ```marvin.hpp``` and ```marvin.cu``` to the project
  - Project -> Add Existing Item (Shift-Alt-A)
  - Select ```marvin.hpp``` and ```marvin.cu``` from Explorer
- Add cuDNN and cuBLAS libraries
  - Project -> [Project Name] Properties -> Configuration Properties -> Linker -> Input
  - Add ```cudnn.lib``` and ```cublas.lib``` to the semicolon-delimited list called ```Additional Dependencies``` (assumes both files are in ```CUDA_PATH/lib```)
- Build project and run ```marvin.exe``` with appropriate commands

## MNIST

### Creating from scratch
1. Prepare data: run ```examples/mnist/prepare_mnist.m``` in ```MATLAB```
2. Train a model: run ```examples/mnist/demo.sh in``` ```shell```
3. Visualize filters: run ```examples/mnist/demo_vis_filter.m``` in ```MATLAB```

### Using prebuilt data
1. Download four tensor files to ```examples/mnist```
  - [Test images](http://vision.princeton.edu/marvin/mnist/test-images.tensor)
  - [Test labels](http://vision.princeton.edu/marvin/mnist/test-labels.tensor)
  - [Training images](http://vision.princeton.edu/marvin/mnist/train-images.tensor)
  - [Training labels](http://vision.princeton.edu/marvin/mnist/train-labels.tensor)
2. Run Marvin from the root directory
  - Train: ```marvin train examples/mnist/lenet.json```
  - Test: ```marvin test examples/mnist/lenet.json examples/mnist/lenet.marvin```

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
