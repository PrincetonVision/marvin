Use pre-trained models to classify a picture of a cat. MARVIN_ROOT is where the marvin code is where the Marvin code resides. For AlexNet pre-trained on the ImageNet dataset:

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
  cd $(MARVIN_ROOT)/examples/classification
  matlab
  demo('alexnet', 'imagenet')
  ```

**Hooray!**

Run demos of other models on the ImageNet dataset:
```
demo('googlenet', 'imagenet')
demo('vgg', 'imagenet', '16') # VGG with 16 layers
demo('vgg', 'imagenet', '19') # VGG with 19 layers
```

Run demos on the Places dataset:
```
demo('alexnet', 'places')
demo('googlenet', 'places')
```

**NOTE**: To run these commands, you have to download the corresponding model weights first.
