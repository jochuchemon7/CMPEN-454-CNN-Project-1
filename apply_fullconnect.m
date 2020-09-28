%{
Description: A function to apply a filter bank of D2 linear filters and D2
scalar bias valus to compute output, where each filter is the same
dimension as the input image. 

Inputs: inarray (array size NxMxD1), filterbank (array 4x4x10x10), biasvals
(array size 10)

Outputs: outarray (array size 1x1xD2)
%}

function outarray = apply_fullconnect(inarray, filterbank, biasvals)
    % Declarations for output values and final array
    output = 0;
    outarray = zeros(1, 1, 10);
    % Loop the number of filter banks (10)
    for l = 1 : 10
        % Triple loop for computing the sum of the products between the set of
        % filters and the input array.  
        for i = 1 : 4
            for j = 1 : 4
                for k = 1 : 10
                    output = output + filterbank(i, j, k, l) * inarray(i, j, k) + biasvals(l);
                end
            end
        end
        outarray(1, 1, l) = output;
    end
end