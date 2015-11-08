---
layout: main
title: Home
---

### Marvin thinks, therefore Marvin is.

Never before has it been so easy to learn so deeply. Talk about feature 1, which is really very great. Feature 2 is also really great. But feature 3 is truly special: it helps you win friends and influence people. Marvin is architected for performance: both yours and your GPU's. And it all compiles before you can <s>get a cup of</s> say caffe.

### Install in a jiffy.

First, install [CUDA](https://developer.nvidia.com/cuda-downloads) and [cuDNN](https://developer.nvidia.com/cudnn). You will need to register with NVIDIA.

To install cuDNN:

{% highlight bash %}
tar zxvf cudnn*.tgz
sudo cp cuda/lib/* /usr/local/cuda/lib
sudo cp cuda/include/* /usr/local/cuda/include
{% endhighlight %}

<p>Linux:</p>

{% highlight bash %}
sudo apt-get install marvin
{% endhighlight %}

<p>OS X:</p>

{% highlight bash %}
brew install marvin
{% endhighlight %}

<p>From <a href="https://github.com/PrincetonVision/marvin">source</a>:</p>

{% highlight bash %}
curl -O https://github.com/PrincetonVision/marvin/tarball/master
tar zxvf marvin* && cd marvin
./configure && make && make install
{% endhighlight %}


