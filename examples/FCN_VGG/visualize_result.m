addpath ../../marvin/tools/tensorIO_matlab


imageTensor = readTensors('images480x640_test.tensor');
imageTensor = imageTensor.value;

labelTensor = readTensors('label480x640_test.tensor');
labelTensor = labelTensor.value;



predTensor = readTensors('prob.tensor');
predTensor = predTensor.value;

for i=1:size(predTensor,4)
    
    subplot(1,3,1);
    imshow(imageTensor(:,:,:,i)/255);

    subplot(1,3,2);
    imagesc(labelTensor(:,:,1,i),[0 1]); axis equal; axis tight; axis off; colorbar
    title('ground truth');

    subplot(1,3,3);
    imagesc(predTensor(:,:,2,i),[0 1]); axis equal; axis tight; axis off; colorbar
    title('prediction'); 
    
    pause
end
