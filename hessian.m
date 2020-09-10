function hess = hessian(dx, dy)
%HESSIAN Give the two derivative images, we will compute the Hessian matrix
%for every pixel.
    
    % The Hessian is a 2x2 matrix, so each pixel will actually have 4
    % values.  We will grab the original width and height from the image
    % and store them in some easy to understand vars, where we pull these
    % values (from dx/dy doesn't really matter since they are both the same
    % size
    [height, width] = size(dx);
 
    
    % The hessian is characterized by 
    %  -  the squared X derivative in the top left at (1,1) 
    %  -  the X derivative multiplied by the Y derivative at (1,2)
    %  -  the Y derivative squared in the bottom left (2, 1)
    %  -  the Y derivative multiplied by the X derivative at (2,2)
    % we can actually do this in one line and each of these equations are
    % written out in their respective indicies. dx.^2 for example is the X
    % derivative squared in the top left (1,1).
    
    % Because we have 4 values for every pixel, the image is really the
    % height x width x 2 x 2 instead of width x height (hence the reshape)
    hess = reshape([ [ dx.^2, dx.*dy], [dx.*dy, dy.^2] ], [height, width, 2, 2]);
end

