function demo(net_name, data_name, net_suffix)

if nargin < 3
    net_suffix = '';
end

marvin_root = fullfile('..', '..');

model_name = sprintf('%s_%s', net_name, data_name);
model_full_name = sprintf('%s%s_%s', net_name, net_suffix, data_name);
addpath(fullfile(marvin_root, 'tools', 'tensorIO_matlab'));
model_path = fullfile('models', model_name, [model_full_name, '.json']);
pretrained_path = fullfile('models', model_name, [model_full_name, '_half.marvin']);
if ~exist(fullfile(marvin_root, pretrained_path), 'file')
    error('Download pretraiend model %s first', pretrained_path);
end

switch net_name
    case 'alexnet'
        scale = [227, 227];
        batch_size = 256;
        last_layer = 'loss';
    case 'vgg'
        scale = [224, 224];
        batch_size = 32;
        last_layer = 'fc8';
    case 'googlenet'
        scale = [224, 224];
        batch_size = 32;
        last_layer = 'loss3/loss3';
    otherwise
        error('Unknown net name %s', net_name);
end

switch data_name
    case 'imagenet'
        class_names = load('ImageNetclass.mat');
        class_names = class_names.ImageNetclass;
    case 'places'
        class_names = load('PLACE205_label');
        class_names = class_names.category_name;
    otherwise
        error('Unknown data: %s', data_name);
end

train_data_path = fullfile(marvin_root, 'data', data_name, 'train_data.tensor');
train_label_path = fullfile(marvin_root, 'data', data_name, 'train_label.tensor');
val_data_path = fullfile(marvin_root, 'data', data_name, 'val_data.tensor');
val_label_path = fullfile(marvin_root, 'data', data_name, 'val_label.tensor');

switch data_name
    case 'imagenet'
        im = imread(fullfile(marvin_root, 'data', 'images', 'cat.jpg'));
    case 'places'
        im = imread(fullfile(marvin_root, 'data', 'images', 'bedroom.jpg'));
end

im = imresize(im,[scale(1),scale(2)]);
im = single(im(:,:,[3 2 1]));
% save as tensor 
images_tensor.name = 'image';
images_tensor.value = single(zeros([size(im) batch_size]));
for ii = 1:batch_size
    images_tensor.value(:,:,:,ii) = single(im);
end
images_tensor.type = 'half';
images_tensor.sizeof = 2;
images_tensor.dim = 4;
writeTensors(train_data_path, images_tensor);
writeTensors(val_data_path, images_tensor);

label_tensor.name = 'label';
label_tensor.value = single(zeros([1, 1, 1, batch_size]));
for ii = 1:batch_size
    label_tensor.value(:, :, :, ii) = single(0); % fake label
end
label_tensor.type = 'half';
label_tensor.sizeof = 2;
label_tensor.dim = 4;
writeTensors(train_label_path, label_tensor);
writeTensors(val_label_path, label_tensor);

%% run marvin test
template = './marvin test %s %s %s examples/classification/cls_prob_0';
cmd = sprintf(template, model_path, pretrained_path, last_layer);   
system(sprintf('cd %s; export LD_LIBRARY_PATH=LD_LIBRARY_PATH:/usr/local/cuda/lib64; %s', marvin_root, cmd));

%% show result
result = readTensors('cls_prob_0');
conf = result.value(:,:,:,2);
conf = conf(:);
[~, maxidx]=sort(conf,'descend');

fprintf('\n=========================\n\n')
fprintf('Top 5 results \n')
for ii = 1:5
    fprintf('%d: class %d %s\n', ii, maxidx(ii), class_names{maxidx(ii)})
end

%% delete
delete(train_data_path)
delete(train_label_path)
delete(val_data_path)
delete(val_label_path)
delete('cls_prob_0')

end
