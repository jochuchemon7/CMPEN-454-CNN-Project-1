format compact

%{
Description: Relu replaces the negative values with 0 value

Input: 32x32x10, 16x16x10 or 8x8x10
Output: 32x32x10, 16x16x10 or 8x8x10
%}


function result = relu(image)

out = max(image,0) 
result = out;

end
