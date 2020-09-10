function gs_img = grayscale(img)
% Given an image, apply a gray scale filter. I read somewhere that the best
% way to gray scale an image is to take 11% of the red channel, 59% of the
% green channel, and 31% of the blue channel.  It allows for a brighter
% gray scale instead of taking 33% of each channel which could be darker.
% Unfortunately I cannot find the link where I read that

    rows = size(img, 1);
    cols = size(img, 2);
    
    %Reshape the matrix so that each row is a pixel where the columns are the set of all 3 color channels
    reshaped = reshape(img , [rows * cols, 3]);
    
    % Create our gray scale vector of the corresponding channel weights
    gray_scale_vector = [0.11, 0.59, 0.31];
    % Transform the vector into a 3x3 for matrix multiplication
    gray_scale_matrix = reshape([gray_scale_vector, gray_scale_vector, gray_scale_vector], [3,3]);
    
    % Type case the image to a double, then multiply with our weighted
    % matrix, then cast it back into uint8 for display, finally reshape the
    % matrix back  into a rows:cols:3 matrix.    
    gs_img = double(reshaped) * gray_scale_matrix;
    
    % Because we are only really wanting the grayscale value, and the
    % grayscale value is the same in all channels now, we can drop the
    % other two channels and just kepp the first one - hence the
    % gs_img(:,1)
    gs_img = reshape(gs_img(:,1), [rows, cols]);
    
end
