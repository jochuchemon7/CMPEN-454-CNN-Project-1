format compact
%{
Input: should be a 32x32x10 array but only works with 32x32x1
Output: should be half of each 32 (e.i 16x16x10)
%}


function result = maxpool(image)


topLeft = image(1:2:end,1:2:end); %We take all the top left values on a 2x2 basis
topRight = image(1:2:end,2:2:end); %We take all the top right values on a 2x2 basis
bottomLeft = image(2:2:end,1:2:end);
bottomRight = image(2:2:end,2:2:end);

%We find the max value of the concatenation of each element from the 'boxes'
im_max = max(cat(3,topLeft,bottomLeft,bottomRight,topRight),[],3) 

result = im_max;

end