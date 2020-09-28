function outarray = apply_relu(inarray)
    outarray = max(inarray(:,:,:,1),0);
end