The steps below are for running the demo for AlexNet model on ImageNet data. MARVIN_ROOT is where the marvin code is where the Marvin code resides.

1. Compile Marvin
```
$(MARVIN_ROOT)/compile.sh
```
2. Download model weights
```
bash $(MARVIN_ROOT)/models/alexnet_imagenet/download_weights.sh
```
3. Download dataset mean image
```
bash $(MARVIN_ROOT)/data/imagenet/download.sh
```
4. Run demo.m
```
cd $(MARVIN_ROOT)/examples/imagenet
matlab
demo('alexnet', 'imagenet')
```

**Hooray!**

Command samples for the other models on imagenet:
```
demo('googlenet', 'imagenet')
demo('vgg', 'imagenet', '16') # VGG with 16 layers
demo('vgg', 'imagenet', '19') # VGG with 19 layers
```

To run these commands, you have to download the corresponding model weights first.