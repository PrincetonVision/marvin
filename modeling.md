---
layout: main
title: Models
---

<h2>
  Pre-trained Models
</h2>

We provide a number of pre-trained models for easy use. When using these models, please cite and heed licenses accordingly! We also welcome community contributions via pull requests to the <a href='https://github.com/PrincetonVision/marvin'>repository</a>.

You can find a number of demos showing how to download and run the models below <a href='https://github.com/PrincetonVision/marvin/tree/master/examples/classification'>here</a>.

<h3>
	The List
</h3>

This list contains links to architecture definitions (```*.json```), download scripts for datasets (```*.tensor```), and pre-trained weights (```*.marvin```). We have also taken care to give credit where it is due, so please let us know if there is anything wrong or missing.

<table align='left'>
	<tr>
		<th>Architecture</th>
		<th>Dataset</th>
		<th>Weights</th>
		<th>Trainer</th>
		<th>Citation</th>
		<th>License</th>
	</tr>

	<tr>
		<td><a href='https://github.com/PrincetonVision/marvin/blob/master/models/alexnet_imagenet/alexnet_imagenet.json'>AlexNet for ImageNet</a></td>
		<td><a href='https://github.com/PrincetonVision/marvin/blob/master/data/imagenet/download.sh'>ImageNet1k</a></td>
		<td><a href='https://github.com/PrincetonVision/marvin/blob/master/models/alexnet_imagenet/download_weights.sh'>Download</a></td>
		<td><a href='http://caffe.berkeleyvision.org/'>BVLC</a></td>
		<td><a href='#C1'>C1</a> <a href='#C2'>C2</a> <a href='#C3'>C3</a> </td>
		<td><a href='#L1'>L1</a> <a href='#L2'>L2</a> <a href='#L3'>L3</a> </td>
	</tr>

	<tr>
		<td><a href='https://github.com/PrincetonVision/marvin/blob/master/models/alexnet_places/alexnet_places.json'>AlexNet for Places</a></td>
		<td><a href='https://github.com/PrincetonVision/marvin/blob/master/data/places/download.sh'>Places205</a></td>
		<td><a href='https://github.com/PrincetonVision/marvin/blob/master/models/alexnet_places/download_weights.sh'>Download</a></td>
		<td><a href='http://places.csail.mit.edu/'>Places</a></td>
		<td><a href='#C2'>C2</a> <a href='#C4'>C4</a> </td>
		<td><a href='#L2'>L2</a> <a href='#L4'>L4</a> </td>
	</tr>

	<tr>
		<td><a href='https://github.com/PrincetonVision/marvin/blob/master/models/googlenet_imagenet/googlenet_imagenet.json'>GoogLeNet for ImageNet</a></td>
		<td><a href='https://github.com/PrincetonVision/marvin/blob/master/data/imagenet/download.sh'>ImageNet1k</a></td>
		<td><a href='https://github.com/PrincetonVision/marvin/blob/master/models/googlenet_imagenet/download_weights.sh'>Download</a></td>
		<td><a href='http://caffe.berkeleyvision.org/'>BVLC</a></td>
		<td><a href='#C1'>C1</a> <a href='#C3'>C3</a> <a href='#C5'>C5</a> </td>
		<td><a href='#L1'>L1</a> <a href='#L3'>L3</a> <a href='#L5'>L5</a> </td>
	</tr>

	<tr>
		<td><a href='https://github.com/PrincetonVision/marvin/blob/master/models/googlenet_places/googlenet_places.json'>GoogLeNet for Places</a></td>
		<td><a href='https://github.com/PrincetonVision/marvin/blob/master/data/places/download.sh'>Places205</a></td>
		<td><a href='https://github.com/PrincetonVision/marvin/blob/master/models/googlenet_places/download_weights.sh'>Download</a></td>
		<td><a href='http://places.csail.mit.edu/'>Places</a></td>
		<td><a href='#C4'>C4</a> <a href='#C5'>C5</a> </td>
		<td><a href='#L4'>L4</a> <a href='#L5'>L5</a> </td>
	</tr>

	<tr>
		<td><a href='https://github.com/PrincetonVision/marvin/blob/master/models/vgg_imagenet/vgg16_imagenet.json'>VGGNet 16 for ImageNet</a></td>
		<td><a href='https://github.com/PrincetonVision/marvin/blob/master/data/imagenet/download.sh'>ImageNet1k</a></td>
		<td><a href='https://github.com/PrincetonVision/marvin/blob/master/models/vgg_imagenet/download_vgg16_weights.sh'>Download</a></td>
		<td><a href='http://www.robots.ox.ac.uk/~vgg/research/very_deep/'>VGG</a></td>
		<td><a href='#C3'>C3</a> <a href='#C6'>C6</a> </td>
		<td><a href='#L3'>L3</a> <a href='#L6'>L6</a> </td>
	</tr>

	<tr>
		<td><a href='https://github.com/PrincetonVision/marvin/blob/master/models/vgg_imagenet/vgg19_imagenet.json'>VGGNet 19 for ImageNet</a></td>
		<td><a href='https://github.com/PrincetonVision/marvin/blob/master/data/imagenet/download.sh'>ImageNet1k</a></td>
		<td><a href='https://github.com/PrincetonVision/marvin/blob/master/models/vgg_imagenet/download_vgg19_weights.sh'>Download</a></td>
		<td><a href='http://www.robots.ox.ac.uk/~vgg/research/very_deep/'>VGG</a></td>
		<td><a href='#C3'>C3</a> <a href='#C6'>C6</a> </td>
		<td><a href='#L3'>L3</a> <a href='#L6'>L6</a> </td>
	</tr>
</table>
<table></table>

<h3>
	Citations
</h3>

<style>
	ol {
	    list-style-type: none;
	    counter-reset: elementcounter;
	    /*padding-left: -1.5rem;*/
	    margin-left: 0;
	}

	li.citations:before {
	    content: "C" counter(elementcounter) ". ";
	    counter-increment: elementcounter;
	    font-weight: bold;
	}

	li.licenses:before {
	    content: "L" counter(elementcounter) ". ";
	    counter-increment: elementcounter;
	    font-weight: bold;
	}
</style>

<ol>
	<li class='citations' name='C1'>Jia, Yangqing, et al. "Caffe: Convolutional architecture for fast feature embedding." <i>Proceedings of the ACM International Conference on Multimedia</i>. 2014.</li>
  <li class='citations' name='C2'>Krizhevsky, Alex, Ilya Sutskever, and Geoffrey E. Hinton. "Imagenet classification with deep convolutional neural networks." <i>Advances in neural information processing systems</i>. 2012. 
  <li class='citations' name='C3'>Deng, Jia, et al. "Imagenet: A large-scale hierarchical image database." <i>IEEE Conference on Computer Vision and Pattern Recognition</i>. 2009.</li>
  <li class='citations' name='C4'>Zhou, Bolei, et al. "Learning deep features for scene recognition using places database." <i>Advances in Neural Information Processing Systems</i>. 2014.
  <li class='citations' name='C5'>Szegedy, Christian, et al. "Going deeper with convolutions." <i>arXiv preprint arXiv:1409.4842</i>. 2014.</li>
  <li class='citations' name='C6'>Simonyan, Karen, and Andrew Zisserman. "Very deep convolutional networks for large-scale image recognition." <i>arXiv preprint arXiv:1409.1556</i>. 2014.</li>
</ol>

<h3>
	Licenses
</h3>

<ol>
	<li class='licenses' name='L1'>License <a href='https://github.com/BVLC/caffe/blob/master/LICENSE'>here</a></li>
	<li class='licenses' name='L2'>Released for unrestricted use (<a href='https://github.com/BVLC/caffe/tree/master/models/bvlc_alexnet'>link</a>)
  <li class='licenses' name='L3'>Depending on your use case, custom license (<a href='http://image-net.org/download-faq'>link</a>)
  <li class='licenses' name='L4'>Original annotations under Creative Commons (<a href='http://places.csail.mit.edu/'>link</a>)
  <li class='licenses' name='L5'>Released for unrestricted use (<a href='https://github.com/BVLC/caffe/tree/master/models/bvlc_googlenet'>link</a>)
  <li class='licenses' name='L6'>Released under Creative Commons 4.0 (<a href='http://www.robots.ox.ac.uk/~vgg/research/very_deep/'>link</a>)
</ol>
