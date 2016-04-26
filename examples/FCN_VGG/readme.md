Train your FCN network for any segmentation task. This is an example fine-tuning a VGG FCN  network on three training images for binary segmentation task and test on two new images. 

Preparation: 

1. Download vgg16_imagenet_half.marvin from http://vision.princeton.edu/marvin/models/vgg_imagenet/vgg16_imagenet_half.marvin into examples/FCN_VGG/.

2. Download the example images and masks from http://vision.princeton.edu/marvin/FCN_VGG/images.zip and unzip them to examples/FCN_VGG/

Steps:

1. run prepare_data.m in Matlab to generate the tensor data files: 

	For training:
		images: images480x640_train.tensor
		labels: label480x640_train.tensor
	For testing:
		images: images480x640_test.tensor
		labels: label480x640_test.tensor

2. cd into marvin root folder, run examples/FCN_VGG/train.sh to train a model. Wait until the 500-th iterations finish so that there is a train model snapshot saved at examples/FCN_VGG/FCN32s_snapshot_500.marvin

3. cd into marvin root folder, run examples/FCN_VGG/test.sh to get the result by feeding the testing data. Result are saved at examples/FCN_VGG/prob.tensor

4. run visualize_result.m in Matlab to visualize the testing prediction result.

