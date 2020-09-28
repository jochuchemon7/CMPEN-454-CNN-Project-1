%{
Description: A function to normalize the input image

Inputs: Array size NxMx3

Outputs: Array size NxMx3
%}

function outarray = apply_imnormalize(inarray)
    outarray = inarray(:,:,:,1)/255.0 -.5;
end