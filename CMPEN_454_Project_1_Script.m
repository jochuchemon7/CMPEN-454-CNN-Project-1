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

image = testData.imageset(:,:,:,2);
filterbank = parameters.filterbanks{2};
biasvals = parameters.biasvectors{2};


%Example of one image going thru two 'layers'
layer1 = imageNormalization(image);
layer2 = apply_convolve(layer1, filterbank, biasvals);
layer3 = relu(layer2);
layer4 = apply_convolve(layer3, parameters.filterbanks{4}, parameters.biasvectors{4});
layer5 = relu(layer4);
layer6 = maxpool(layer5);
layer7 = apply_convolve(layer6, parameters.filterbanks{7}, parameters.biasvectors{7});
layer8 = relu(layer7);
layer9 = apply_convolve(layer8, parameters.filterbanks{9}, parameters.biasvectors{9});
layer10 = relu(layer9);
layer11 = maxpool(layer10);
layer12 = apply_convolve(layer11, parameters.filterbanks{12}, parameters.biasvectors{12});
layer13 = relu(layer12);
layer14 = apply_convolve(layer13, parameters.filterbanks{14}, parameters.biasvectors{14});
layer15 = relu(layer14);
layer16 = maxpool(layer15);
layer17 = apply_fullconnect(layer16, parameters.filterbanks{17}, parameters.biasvectors{17});
layer18 = softmax(layer17);



%More exmaples
maxExample = maxpool(double(image(:,:,1)));
newMaxExample = maxpool(double(image));
softExample = softmax(image(:,:,1));


%4


function result = imageNormalization(image)

out = image/255.0 -.5;
result = out;

end


function outarray = apply_convolve(inarray, filterbank, biasvals)
    % Declaration for output array size NxMxD2 (where D2 = 10) and spacial
    % size of filter (RxC) 
    outarray = double(zeros(size(inarray, 1), size(inarray, 2), 10));
    output_sum = double(zeros(size(inarray, 1), size(inarray, 2)));
    % Loop the number of filter banks (10)
    for l = 1 : 10
       % Now run the convolution over all D1 (below) for each filter bank (loop above)
       for x = 1 : size(inarray, 3)
           output_sum = output_sum + double(imfilter(inarray(:, :, x), filterbank(:, :, x, l), 'conv'));
       end
       % Add convolution result to outarray with bias values in place
       outarray(:, :, l) = output_sum + biasvals(l);
       % Reset summation array
       output_sum = double(zeros(size(inarray, 1), size(inarray, 2)));
    end
end


function outarray = apply_fullconnect(inarray, filterbank, biasvals)
    % Declarations for output values and final array
    output = 0;
    outarray = double(zeros(1, 1, 10));
    % Loop the number of filter banks (10)
    for l = 1 : 10
        % Triple loop for computing the sum of the products between the set of
        % filters and the input array.  
        for i = 1 : 4
            for j = 1 : 4
                for k = 1 : 10
                    output = output + filterbank(i, j, k, l) * inarray(i, j, k);
                end
            end
        end
        outarray(1, 1, l) = output + biasvals(l);
    end
end


function result = relu(image)

out = max(image,0)
result = out;

end


function result = softmax(image)
image = double(image);
out = exp(image - max(image))/sum(exp(image - max(image)));
result = out;
end


function result = maxpool(image)
[row,col,dim] = size(image);

topLeft = image(1:2:end,1:2:end,1);
topRight = image(1:2:end,2:2:end,1);
bottomLeft = image(2:2:end,1:2:end,1);
bottomRight = image(2:2:end,2:2:end,1);
im_max = max(cat(3,topLeft,bottomLeft,bottomRight,topRight),[],3)

for i = 2:dim    
    topLeft = image(1:2:end,1:2:end,i);
    topRight = image(1:2:end,2:2:end,i);
    bottomLeft = image(2:2:end,1:2:end,i);
    bottomRight = image(2:2:end,2:2:end,i);

    im_max(:,:,i) = max(cat(3,topLeft,bottomLeft,bottomRight,topRight),[],3)
    
end
result = im_max;

end








