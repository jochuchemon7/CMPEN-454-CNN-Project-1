format compact
%{
Input: should be a 32x32x10, 16x16x10 or 8x8x10
Output: should be half of each 32 (e.i 16x16x10, 8x8x10, or 4x4x10)
%}



function result = maxpool(image)
[row,col,dim] = size(image); %Gets the dimension

%We do the first dimention fist so we can combine the rest 
topLeft = image(1:2:end,1:2:end,1); %We take all the top left values on a 2x2 basis
topRight = image(1:2:end,2:2:end,1); %We take all the top right values on a 2x2 basis
bottomLeft = image(2:2:end,1:2:end,1); %We take all the bottom left values on a 2x2 basis
bottomRight = image(2:2:end,2:2:end,1); %We take all the bottom right values on a 2x2 basis

%Gets the max value for each 'box' for the concatenation
im_max = max(cat(3,topLeft,bottomLeft,bottomRight,topRight),[],3)

%Gets the rest
for i = 2:dim    
    topLeft = image(1:2:end,1:2:end,i);
    topRight = image(1:2:end,2:2:end,i);
    bottomLeft = image(2:2:end,1:2:end,i);
    bottomRight = image(2:2:end,2:2:end,i);

    %Merges them
    im_max(:,:,i) = max(cat(3,topLeft,bottomLeft,bottomRight,topRight),[],3)
    
end

%Final result
result = im_max;

end

