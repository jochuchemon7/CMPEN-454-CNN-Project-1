%{
Description: A function that serves as a convolutional layer.  

Inputs: inarray (array size NxMxD1), filterbank (array 3x3x10x10), biasvals
(array size 10)

Outputs: outarray (array size NxMxD2)
%}

function outarray = apply_convolve(inarray, filterbank, biasvals)
    % Declaration for output array size NxMxD2 (where D2 = 10) and spacial
    % size of filter (RxC) 
    outarray = zeros(size(inarray, 1), size(inarray, 2), 10);
    output_sum = double(zeros(size(inarray, 1), size(inaray, 2)));
    % Loop the number of filter banks (10)
    for l = 1 : 10
       % Now run the convolution over all D1 (below) for each filter bank (loop above)
       for x = 1 : size(inarray, 3)
           output_sum = output_sum + double(imfilter(inarray(:, :, x), filterbank(:, :, x, l), 'conv'));
       end
       % Add convolutuo result to outarray with bias values in place
       outarray(:, :, l) = output_sum + biasvals(l);
       % Reset summation array
       output_sum = double(zeros(size(inarray, 1), size(inarray, 2)));
    end
end