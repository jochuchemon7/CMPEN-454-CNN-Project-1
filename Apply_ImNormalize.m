format compact

%{
We want to normalized the values to either 0 or 1

Input: 32x32x3 array (image)
Output: 32x32x3

%}


function result = imageNormalization(image)

out = image/255.0 -.5; %Normalizes
result = out;

end
