---
layout: main
title: Home
---

### Marvin thinks, therefore Marvin is.

Never before has it been so easy to learn so deeply. Marvin is designed first and foremost to be hackable. It is naively simple for fast prototyping, uses only basic C/C++, and only calls CUDA and cuDNN as dependencies. All code lives in ```marvin.hpp``` and ```marvin.cu```.

### Get started in a jiffy.

#### Install CUDA and cuDNN

Download [CUDA](https://developer.nvidia.com/cuda-downloads) and [cuDNN](https://developer.nvidia.com/cudnn). You will need to register with NVIDIA. You can find instructions to install CUDA [here](http://lmgtfy.com/?q=install+cuda). Below are instructions to install cuDNN.

{% highlight bash %}
CUDA_LIB_DIR=/usr/local/cuda/lib$([[ $(uname) == "Linux" ]] && echo 64)
echo LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CUDA_LIB_DIR >> ~/.profile && ~/.profile

tar zxvf cudnn*.tgz
sudo cp cuda/lib/* $CUDA_LIB_DIR
sudo cp cuda/include/* /usr/local/cuda/include
{% endhighlight %}

#### Compile Marvin

<p>From <a href="https://github.com/PrincetonVision/marvin">source</a>:</p>

{% highlight bash %}
curl -L https://github.com/PrincetonVision/marvin/tarball/master | tar x
mv PrincetonVision* marvin && cd marvin && ./compile.sh
{% endhighlight %}

#### Run Marvin on MNIST

1. Prepare data

    Run ```examples/mnist/prepare_mnist.m``` in ```MATLAB```

2. Train a model

    Run ```./examples/mnist/demo.sh``` in ```shell```

3. Visualize filters

    Run ```examples/mnist/demo_vis_filter.m``` in ```MATLAB```
