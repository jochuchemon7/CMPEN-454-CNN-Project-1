% PROJECT 1 MAIN SCRIPT  

% Load dataset (cifar10) and parameters 

% Grab the Ground Truth Parameters
load('cifar10testdata.mat');

% Parameters for the Convolution and Full Connect Layers 
load('CNNparameters.mat');

% Debugging Material
load('debuggingTest.mat');

% 18 LAYERS OF CNN

% Define the number of images to test; we will use 20 here
images = 20;

% Define the array for storing predicted values
outcomes = zeros(10);

% Loop through test images and send through layers

for i = 1 : images
    
    % First, get image
    image = imageset(:, :, :, i);
    
    % Then go through layers of CNN
    
    % Image Normalization 1 (Layer 1)
    layer1 = apply_imnormalize(image);

    % Convolution 1 (Layer 2) 
    layer2 = apply_convolve(layer1, filterbanks{1, 2}, biasvectors{1, 2});

    % Relu 1 (Layer 3)
    layer3 = apply_relu(layer2);

    % Convolution 2 (Layer 4)
    later4 = apply_convolve(layer3, filterbanks{1,4}, biasvectors{1,4});

    % Relu 2 (Layer 5)
    layer5 = apply_relu(layer4);

    % Maxpool 1 (Layer 6)
    layer6 = apply_maxpool(layer5);

    % Convolution 3 (Layer 7)
    layer7 = apply_convolve(layer6);

    % Relu 3 (Layer 8)
    layer8 = apply_relu(layer7);

    % Convolution 4 (Layer 9)
    layer9 = apply_convolve(layer8, filterbanks{1, 7}, biasvectors{1, 7});

    % Relu 4 (Layer 10)
    layer10 = applu_relu(layer9);

    % Maxpool 2 (Layer 11)
    layer11 = apply_maxpool(layer10);

    % Convolution 5 (Layer 12)
    layer12 = apply_convolve(layer11, filterbanks{1, 12}, biasvectors{1, 12});

    % Relu 5 (Layer 13)
    layer13 = apply_relu(layer12);

    % Convolution 6 (Layer 14)
    layer14 = apply_convolve(layer13, filterbanks{1, 14},biasvectors{1, 14});

    % Relu 6 (Layer 15)
    layer15 = apply_relu(layer14);

    % Maxpool 3 (Layer 16)
    layer16 = apply_maxpool(layer15);

    % Fullconnect 1 (Layer 17)
    layer17 = apply_fullconnect(layer16, filterbanks{1, 17},biasvectors{1, 17});

    % Softmax 1 (Layer 18)
    layer18 = apply_softmax(layer17);

    % Run Accuracy Test and Update the Confusion Matrix 
    
    % Remove unwanted one-dims of layer 18 (i.e. output is 1x1xD)
    class = squeeze(layer18);
    
    % Find the class prediction in resulting 1-D array
    [maxprob, maxclass] = max(class);
    
    % Display the result for each image
    fprintf('Estimated class is %s with probability %.4f\n',...
            classlabels{maxclass}, maxprob);
    
    % Update confusion matrix (actual image identity vs predicted one)
    % NOTE: trueclass comes from debug file loaded at start 
    outcomes(i) = maxclass;
end

% Now we generate confusion matrix and display
matrix = confusionmat(trueclass, outcomes);
confusionchart(matrix)

% Compute the accuracy score
rate = accuracy(matrix);

% Display accuracy score (or classification rate)
fprintf('The Classification Rate for the CNN is %.2f', rate);

