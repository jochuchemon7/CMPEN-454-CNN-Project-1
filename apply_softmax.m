%{
Description: A function that converts a vector of real numbers and converts
into a set that lie between 1 and 0 i.e. probabilities that sum to 1

Inputs: Array size 1x1xD

Outputs: Array size 1x1xD
%}

function outarray = apply_softmax(inarray)
    % Alpha term implemented for numerical stability
    alpha = max(inarray(1, 1, :));
    exp_sum = sum(exp(inarray(1, 1, :) - alpha));
    outarray = exp(inarray(1, 1, :) - alpha) / exp_sum;
end