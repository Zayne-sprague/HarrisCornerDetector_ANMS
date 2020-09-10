function smoothed_image = smooth(image, size, sigma)
    kernel = create_gaussian_kernel(size, sigma);
    smoothed_image = convn(image, kernel, 'same');
end

function kernel = create_gaussian_kernel(size, sigma)
    indicies = -floor(size/2) : floor(size/2);
    [X, Y] = meshgrid(indicies, indicies);

    kernel = exp(-(X.^2 + Y.^2) / (2 * sigma * sigma));

    kernel = kernel / sum(kernel(:));
end