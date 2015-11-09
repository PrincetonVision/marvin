function prepare_mnist

    cd(fileparts(which(mfilename)));
    addpath ../../tools/tensorIO_matlab/

    % download
    
    system('DYLD_LIBRARY_PATH=""; curl -L http://yann.lecun.com/exdb/mnist/train-images-idx3-ubyte.gz -o train-images-idx3-ubyte.gz');
    system('DYLD_LIBRARY_PATH=""; curl -L http://yann.lecun.com/exdb/mnist/train-labels-idx1-ubyte.gz -o train-labels-idx1-ubyte.gz');
    system('DYLD_LIBRARY_PATH=""; curl -L http://yann.lecun.com/exdb/mnist/t10k-images-idx3-ubyte.gz  -o t10k-images-idx3-ubyte.gz');
    system('DYLD_LIBRARY_PATH=""; curl -L http://yann.lecun.com/exdb/mnist/t10k-labels-idx1-ubyte.gz  -o t10k-labels-idx1-ubyte.gz');
    system('gunzip train-images-idx3-ubyte.gz');
    system('gunzip train-labels-idx1-ubyte.gz');
    system('gunzip t10k-images-idx3-ubyte.gz');
    system('gunzip t10k-labels-idx1-ubyte.gz');

    % process to 4D format and single precision: 
    % number N x channel C x height H x width W

    images = loadMNISTImages('train-images-idx3-ubyte'); delete('train-images-idx3-ubyte');
    images = permute(images,[2 1 3]); % matlab is column major, marvin/c++ is row major
    images = images * 0.00390625; % scale from 0-256 to 0-1
    images = reshape(images,size(images,1),size(images,2),1,[]);
    
    tensor.type = 'float';
    tensor.sizeof = 4;
    tensor.name = 'mnist train images';
    tensor.value = single(images);
    tensor.dim=4;
    writeTensors('train-images.tensor', tensor);        
    
    % labels for train
    
    labels = loadMNISTLabels('train-labels-idx1-ubyte'); delete('train-labels-idx1-ubyte');
    labels = reshape(labels,1,1,1,[]);
    
    tensor.type = 'float';
    tensor.sizeof = 4;
    tensor.name = 'mnist train labels';
    tensor.value = single(labels);
    tensor.dim=4;
    writeTensors('train-labels.tensor', tensor);
    
    % images for test
    
    images = loadMNISTImages('t10k-images-idx3-ubyte'); delete('t10k-images-idx3-ubyte');
    images = permute(images,[2 1 3]); % matlab is column major, marvin/c++ is row major
    images = images * 0.00390625; % scale from 0-256 to 0-1
    images = reshape(images,size(images,1),size(images,2),1,[]);
    
    tensor.type = 'float';
    tensor.sizeof = 4;
    tensor.name = 'mnist test images';
    tensor.value = single(images);
    tensor.dim=4;
    writeTensors('test-images.tensor', tensor);    

    % labels for test
    
    labels = loadMNISTLabels('t10k-labels-idx1-ubyte'); delete('t10k-labels-idx1-ubyte');
    labels = reshape(labels,1,1,1,[]);
    
    tensor.type = 'float';
    tensor.sizeof = 4;
    tensor.name = 'mnist test labels';
    tensor.value = single(labels);
    tensor.dim=4;
    writeTensors('test-labels.tensor', tensor);

end


function images = loadMNISTImages(filename)
    % http://ufldl.stanford.edu/wiki/index.php/Using_the_MNIST_Dataset
    % loadMNISTImages returns a 28x28x[number of MNIST images] matrix containing the raw MNIST images

    fp = fopen(filename, 'rb');
    assert(fp ~= -1, ['Could not open ', filename, '']);

    magic = fread(fp, 1, 'int32', 0, 'ieee-be');
    assert(magic == 2051, ['Bad magic number in ', filename, '']);

    numImages = fread(fp, 1, 'int32', 0, 'ieee-be');
    numRows = fread(fp, 1, 'int32', 0, 'ieee-be');
    numCols = fread(fp, 1, 'int32', 0, 'ieee-be');

    images = fread(fp, inf, 'unsigned char');
    images = reshape(images, numCols, numRows, numImages);
    images = permute(images,[2 1 3]);

    fclose(fp);

    % Reshape to #pixels x #examples
    %images = reshape(images, size(images, 1), size(images, 2), size(images, 3));
    % Convert to double and rescale to [0,1]
    % images = double(images) / 255;

end


function labels = loadMNISTLabels(filename)
    % http://ufldl.stanford.edu/wiki/index.php/Using_the_MNIST_Dataset
    % loadMNISTLabels returns a [number of MNIST images]x1 matrix containing the labels for the MNIST images

    fp = fopen(filename, 'rb');
    assert(fp ~= -1, ['Could not open ', filename, '']);

    magic = fread(fp, 1, 'int32', 0, 'ieee-be');
    assert(magic == 2049, ['Bad magic number in ', filename, '']);

    numLabels = fread(fp, 1, 'int32', 0, 'ieee-be');

    labels = fread(fp, inf, 'unsigned char');

    assert(size(labels,1) == numLabels, 'Mismatch in label count');

    fclose(fp);
end

