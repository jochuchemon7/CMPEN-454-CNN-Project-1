function outarray = apply_imnormalize(inarray)
    outarray = inarray(:,:,:,1)/255.0 -.5;
end