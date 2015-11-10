---
layout: main
title: About
---

## About

Marvin is designed first and foremost to be hackable. It is naively simple for fast prototyping, uses only basic C/C++, and only calls CUDA and cuDNN as dependencies. All code lives in ```marvin.hpp``` and ```marvin.cu```.

In our first iteration, we optimize obsessively for GPU memory and pay special attention on higher-dimensional data. Other frameworks overwhelmingly serve one-dimensional (e.g., natural language) and two-dimensional (e.g., images) data.

### Name
Marvin is the chronically depressed, but uncommonly brilliant robot from Douglas Adams's *[Hitchhiker's Guide to the Galaxy](https://en.wikipedia.org/wiki/The_Hitchhiker%27s_Guide_to_the_Galaxy)*. He is known for his [dark humor](http://www.imdb.com/character/ch0007553/quotes).
 
Marvin (Minsky) is also a founding father of artificial intelligence, coining the term with John McCarthy. In 1951, Marvin built SNARC, the first randomly wired neural network learning machine out of vacuum tubes. He had just started his Ph.D. in mathematics at Princeton. Marvin would later co-found the artificial intelligence laboratory at MIT.

It is also with some irony that we chose the name 'Marvin'. Professor Minsky's 1969 book, *Perceptrons*, is often (mis?)cited as changing the course of research in artificial intelligence and ultimately effecting the artificial intelligence '[winters](https://en.wikipedia.org/wiki/AI_winter)'. He has also argued that there is no simple principle (e.g., logic) that can capture intelligence:

  > What magical trick makes us intelligent? The trick is that there is no trick. The power of intelligence stems from our vast diversity, not from any single, perfect principle.

<br>
It would appear that our little Marvin has rather large shoes to fill!

### Citation
The following is the citation of the current version of Marvin. Note
that the reference may change in the future when new contributors join
the project.

{% highlight latex %}
@misc{Marvin20151110,
      title        = {Marvin: A minimalist {GPU}-only {N}-dimensional {ConvNet} framework},
      authors      = {Jianxiong Xiao and Shuran Song and Daniel Suo and Fisher Yu},
      howpublished = {\url{http://marvin.is}},
      note         = {Accessed: 2015-11-10}
}
{% endhighlight %}
