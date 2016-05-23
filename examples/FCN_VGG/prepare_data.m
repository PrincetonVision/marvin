addpath ../../tools/tensorIO_matlab


%% prepare training data

images = dir('train-*.image.png');
labels = dir('train-*.label.png');

% read data
clear image label
for i=1:length(images)
    image(:,:,:,i) = imread(images(i).name);
    mask = imread(labels(i).name);
    label(:,:,:,i) = mask(:,:,1) >128;
end

% save into tensor format
tensor.type = 'float';
tensor.sizeof = 4;
tensor.dim=4;

tensor.name = 'image';
tensor.value = single(image);
writeTensors(fullfile('images480x640_train.tensor'), tensor);    

tensor.name = 'label';
tensor.value = single(label);
writeTensors(fullfile('label480x640_train.tensor'), tensor);    


%% prepare testing data

images = dir('test-*.image.png');
labels = dir('test-*.label.png');

% read data
clear image label
for i=1:length(images)
    image(:,:,:,i) = imread(images(i).name);
    mask = imread(labels(i).name);
    label(:,:,:,i) = mask(:,:,1) >128;
end

% save into tensor format
tensor.type = 'float';
tensor.sizeof = 4;
tensor.dim=4;

tensor.name = 'image';
tensor.value = single(image);
writeTensors(fullfile('images480x640_test.tensor'), tensor);    

tensor.name = 'label';
tensor.value = single(label);
writeTensors(fullfile('label480x640_test.tensor'), tensor);    
