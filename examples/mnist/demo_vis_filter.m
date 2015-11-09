cd(fileparts(which(mfilename)));
addpath ../../tools/tensorIO_matlab/

cd ../../
system('LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64; ./marvin activate examples/mnist/lenet.json examples/mnist/lenet.marvin data conv1 [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19] examples/mnist/filters_ 100 20')
cd examples/mnist

clear;
clc;
for n=1:20
    t=readTensors(sprintf('./filters_conv1_%d.tensor',n-1));
    maxLength = min(100,length(t));
    for i=1:maxLength
        f(:,:,i) = t(i).value;
    end
    af = mean(f,3);
    subplot(4,5,n);
    imagesc(af,[0 1]); axis equal; axis tight; axis off;
    colormap gray
end

delete('./filters_*');