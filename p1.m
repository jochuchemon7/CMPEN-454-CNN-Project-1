  
format compact

testData = load('cifar10testdata.mat');
testData;

parameters = load('CNNparameters.mat');
parameters;

debugTest = load('debuggingTest.mat');
debugTest;

debTest_Layer_1 = debugTest.layerResults{1};

disp('Original image data showing 5x5: ')
disp(testData.imageset(1:5,1:5,1,1))
disp('From 32x32 imnormalize showing 5x5: ')
disp(result1(1:5,1:5))
disp('From 32x32 relu showing 5x5')
disp(result2(1:5,1:5))

image = testData.imageset(:,:,:,3);


% 18 LAYERS OF CNN

% Image Normalization 1 (Layer 1)
layer1 = apply_imnormalize(image);

% Convolution 1 (Layer 2) 
layer2 = apply_convolve(layer1)

% Relu 1 (Layer 3)
layer3 = apply_relu(layer2);

% Convolution 2 (Layer 4)
later4 = apply_convolve(layer3)

% Relu 2 (Layer 5)
layer5 = apply_relu(layer4)

% Maxpool 1 (Layer 6)
layer6 = apply_maxpool(layer5);

% Convolution 3 (Layer 7)
layer7 = apply_convolve(layer6)

% Relu 3 (Layer 8)
layer8 = apply_relu(layer7)

% Convolution 4 (Layer 9)
layer9 = apply_convolve(layer8)

% Relu 4 (Layer 10)
layer10 = applu_relu(layer9)

% Maxpool 2 (Layer 11)
layer11 = apply_maxpool(layer10)

% Convolution 5 (Layer 12)
layer12 = apply_convolve(layer11)

% Relu 5 (Layer 13)
layer13 = apply_relu(layer12)

% Convolution 6 (Layer 14)
layer14 = apply_convolve(layer13)

% Relu 6 (Layer 15)
layer15 = apply_relu(layer14)

% Maxpool 3 (Layer 16)
layer16 = apply_maxpool(layer15)

% Fullconnect 1 (Layer 17)
layer17 = apply_fullconnect(layer16)

% Softmax 1 (Layer 18)
layer18 = apply_softmax(layer17)



