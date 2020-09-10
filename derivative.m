
function [xDerivative,yDerivative] = derivative(img)
%DERIVATIVE This function takes an image and finds the derivative of the
%image in both directions and returns them.

    % These kernels are used to find the derivatives in each direction of the
    % image, you can do tons of other kernels, including just a simple [-1,
    % 1] more on sobel https://en.wikipedia.org/wiki/Sobel_operator
    SOBEL_X = [ 
        [1, 0, -1]
        [2, 0, -2]
        [1, 0, -1]
    ];

    SOBEL_Y = [
        [1, 2, 1]
        [0, 0, 0]
        [-1, -2, -1]
    ];

   
    % convn is a convolve function that sums up all the pixels in a window
    % and adds them to the pixel in the middle.  So when we use our sobel
    % derivatives we are taking a weighted sum of all the pixels that
    % overlap with each value in the kernel.  You can implement a convolve
    % function yourself pretty easily - but convn is suuuuuuper fast and
    % heavily optimized.  Here's some good intuition https://setosa.io/ev/image-kernels/
   
    xDerivative = convn(img, SOBEL_X, 'same');
    yDerivative = convn(img, SOBEL_Y, 'same');

end

