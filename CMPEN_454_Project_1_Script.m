format compact

testData = load('cifar10testdata.mat');
testData;

parameters = load('CNNparameters.mat');
parameters;

debugTest = load('debuggingTest.mat');
debugTest;

debTest_Layer_1 = debugTest.layerResults{1};

%Image Normalization Example
result1 = testData.imageset(:,:,1,1)/255.0 - .5;

%ReLu layer Example
result2 = max(testData.imageset(:,:,1,1),0);

disp('Original image data showing 5x5: ')
disp(testData.imageset(1:5,1:5,1,1))
disp('From 32x32 imnormalize showing 5x5: ')
disp(result1(1:5,1:5))
disp('From 32x32 relu showing 5x5')
disp(result2(1:5,1:5))

image = testData.imageset(:,:,:,3);
filterbank = parameters.filterbanks{2};
biasvals = parameters.biasvectors{2};


%Example of one image going thru two 'layers'
layer1 = imageNormalization(image);
%layer2 = convolution(layer1, filterbank, biasvals);
%layer3 = relu(layer2);
%layer4 = convolution(layer3);

%More exmaples
maxExample = maxpool(double(image(:,:,1)));
newMaxExample = maxpool(double(image));
softExample = softmax(image(:,:,1));



topLeft = newImage(1:2:end,1:2:end,1);
topRight = newImage(1:2:end,2:2:end,1);
bottomLeft = newImage(2:2:end,1:2:end,1);
bottomRight = newImage(2:2:end,2:2:end,1);

im_max = max(cat(3,topLeft,bottomLeft,bottomRight,topRight),[],3)


function result = imageNormalization(image)

out = image/255.0 -.5;
result = out;

end

function result = convolution(image, filterbank, biasvals)
out = imfilter(image,filterbank ,'same', 'conv',0);
result = out;
end

function result = relu(image)

out = max(image,0)
result = out;

end


function result = maxpool(image)

topLeft = image(1:2:end,1:2:end);
topRight = image(1:2:end,2:2:end);
bottomLeft = image(2:2:end,1:2:end);
bottomRight = image(2:2:end,2:2:end);

im_max = max(cat(3,topLeft,bottomLeft,bottomRight,topRight),[],3)

result = im_max;

end


function result = softmax(image)
image = double(image);
out = exp(image - max(image))/sum(exp(image - max(image)));
result = out;
end




