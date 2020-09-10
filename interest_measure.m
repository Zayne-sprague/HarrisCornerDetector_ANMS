function corner_map = interest_measure(hess, distance_metric)
%INTEREST_MEASURE Given a hess image map, where each pixel has a 2x2
%hessian of the gradients, and given a specific distance_metric, compute
%the corner map for the image.  You can find most of whats implemented here
%described in https://en.wikipedia.org/wiki/Harris_Corner_Detector

    % If the user didn't specify a distance metric, default to the harmonic
    % mean
    if ~exist('distance_metric', 'var')
        distance_metric = 'HARMONIC_MEAN';
    end
    
    % Get the height and width of the image, we are going to loop over it.
    % TODO - perhaps theres a more efficent way to do this, but looping is
    % pretty straight forward.
    height = size(hess, 1);
    width = size(hess, 2);
    
    
    % Create an empty (zero) matrix for our new corner map.  This is also
    % technically an image, just blank or black.  We are going to be
    % filling this array with values from our specified distance metric.
    corner_map = zeros([height, width]);
    
    
    % Loop over the image
    for i = 1:height
        for j = 1:width
            
            % This is code to grab the 2x2 Hessian matrix per pixel
            pixel_hessian = reshape(hess(i, j, :, :), [2,2]);
            
            
            % Depending on the distance metric you chose, we will be
            % storing the value of that metric in the ith and jth pixel of
            % our corner map.
            switch(distance_metric)
                case {'HARMONIC_MEAN'}
                    corner_map(i, j) = harmonic_mean(pixel_hessian);
                case {'HARRIS_STEPHENS'}
                    corner_map(i, j) = harris_stephens(pixel_hessian);
                otherwise
                    corner_map(i, j) = harmonic_mean(pixel_hessian);
            end
            
            
            
        end
    end
    
end

% These distance functions are designed to tell us how the two eigenvalues
% of the hessian relate, but without actually finding the eigenvalues
% (sometimes a computational complex operation).  Instead we can use one of
% these below and try to find values that indicate two large eigenvalues
% which is indicative of large pixel intensity changes in both directions
% which implies a corner.

function val = harmonic_mean(pixel_hessian)
    % The harmonic mean is equivalent to the two eigenvalues of the hessian
    % multiplied together, divided by the sum of the two eigenvalues.  This
    % This is a nice distance metric, because when both eigenvalues are
    % equal to each other, we get a smooth area (if we were to plot the two
    % eigenvalues possible values on a graph).  When they are both large,
    % we get a high value, when both are small or one is small we get a
    % smaller value.
    
    val = det(pixel_hessian) / trace(pixel_hessian);

end

function val = harris_stephens(pixel_hessian)
    % This detector is rotational invariant, down weights edges, and
    % doesn't require us to calculate the actual eigenvalues.  You can
    % learn more about this specific distance metric in the paper that
    % this project is based off of http://www.bmva.org/bmvc/1988/avc-88-023.pdf
    alpha = 0.06;
    val = det(pixel_hessian) - alpha * trace(pixel_hessian).^2;
end