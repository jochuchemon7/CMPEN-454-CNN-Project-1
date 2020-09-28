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


%Example of one image going thru two 'layers'

layer1 = imageNormalization(image);
layer3 = relu(layer1);

maxpool(image);

function result = imageNormalization(image)

out = image(:,:,:,1)/255.0 -.5;
result = out;

end

function result = relu(image)

out = max(image(:,:,:,1),0)
result = out;

end


function result = maxpool(image)

im_nw = image(1:2:end,1:2:end);
im_sw = image(2:2:end,1:2:end);
im_se = image(2:2:end,2:2:end);
im_ne = image(1:2:end,2:2:end);

im_max = max(cat(3,im_nw,im_sw,im_se,im_ne),[],3)


imshow(im_max)
%figure(2); imshow(im_max, imref2d(size(im_max))) 



result = im_max;

end


