---
layout: main
title: Home
---

### Marvin thinks, therefore Marvin is.

Never before has it been so easy to learn so deeply. Marvin is designed first and foremost to be hackable. It is naively simple for fast prototyping, uses only basic C/C++, and only calls CUDA and cuDNN as dependencies. All code lives in ```marvin.hpp``` and ```marvin.cu```.

### Get started in a jiffy.

#### Compile Marvin
First, install [CUDA 7.5](https://developer.nvidia.com/cuda-downloads) and [cuDNN 3](https://developer.nvidia.com/cudnn).

{% highlight bash %}
curl -L https://github.com/PrincetonVision/marvin/tarball/master | tar x
mv PrincetonVision* marvin && cd marvin
{% endhighlight %}

{% highlight bash %}
 ./compile.sh
 {% endhighlight %}

#### Run Marvin on MNIST

1. Prepare data: run ```examples/mnist/prepare_mnist.m``` in ```MATLAB```
2. Train a model: run ```./examples/mnist/demo.sh``` in ```shell```
3. Visualize filters: run ```examples/mnist/demo_vis_filter.m``` in ```MATLAB```
