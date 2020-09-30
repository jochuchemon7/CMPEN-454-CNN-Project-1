%{
Description: A function for rectified linear unit, where all negative
numbers are converted to 0.

Inputs: Array size NxMxD

Outputs: Array size NxMxD
%}

function outarray = apply_relu(inarray)
    outarray = max(inarray, 0);
end