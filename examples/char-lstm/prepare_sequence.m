clear; clc;

%% use Andrej Karpathy's tinyshakespeare dataset
url = 'https://raw.githubusercontent.com/karpathy/char-rnn/master/data/tinyshakespeare/input.txt';

training_portion = 0.9;

data = urlread(url);
[chars, ~, char_to_ix] = unique(data);


cd(fileparts(which(mfilename)));
addpath ../../tools/tensorIO_matlab/

tensor.type = 'char';
tensor.sizeof = 1;
tensor.name = 'tinyshakespeare map2char';
tensor.value = chars;
tensor.dim=1;
writeTensors('tinyshakespeare_map2char.tensor', tensor);


training_length = round(training_portion*(numel(char_to_ix)));

tensor.type = 'uint8';
tensor.sizeof = 1;
tensor.name = 'tinyshakespeare train';
tensor.value = uint8(char_to_ix(1:training_length))-1;
tensor.dim=1;
writeTensors('tinyshakespeare_train_seq.tensor', tensor);


tensor.type = 'uint8';
tensor.sizeof = 1;
tensor.name = 'tinyshakespeare test';
tensor.value = uint8(char_to_ix((training_length+1):(end)))-1;
tensor.dim=1;
writeTensors('tinyshakespeare_test_seq.tensor', tensor);


