---
layout: main
title: Home
---

### Marvin thinks, therefore Marvin is.

Never before has it been so easy to learn so deeply. Marvin was born to be hacked, relying on few dependencies and basic C++. All code lives in two files ([```marvin.hpp```](https://github.com/PrincetonVision/marvin/blob/master/marvin.hpp) and [```marvin.cu```](https://github.com/PrincetonVision/marvin/blob/master/marvin.cu)) and all numbers take up two bytes (FP16). Win friends and influence people in four easy steps:

#### 1. Find a home for Marvin

Marvin's life depends on an NVIDIA GPU with [CUDA 7.5](http://lmgtfy.com/?q=install+cuda+7.5) and [cuDNN 3](http://lmgtfy.com/?q=install+cuDNN+3).

#### 2. Grab him from the cloud

{% highlight bash %}
curl -L https://github.com/PrincetonVision/marvin/tarball/master | tar zx
mv PrincetonVision* marvin && cd marvin
{% endhighlight %}

#### 3. Bring him to life

{% highlight bash %}
 ./compile.sh
 {% endhighlight %}

#### 4. Teach him MNIST digits

1. Prepare data: run [```examples/mnist/prepare_mnist.m```](https://github.com/PrincetonVision/marvin/blob/master/examples/mnist/prepare_mnist.m) in ```MATLAB```
2. Train a model: run [```examples/mnist/demo.sh```](https://github.com/PrincetonVision/marvin/blob/master/examples/mnist/demo.sh) in ```shell```
3. Visualize filters: run [```examples/mnist/demo_vis_filter.m```](https://github.com/PrincetonVision/marvin/blob/master/examples/mnist/demo_vis_filter.m) in ```MATLAB```
