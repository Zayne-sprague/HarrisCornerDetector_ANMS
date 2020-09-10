function corners = anms(corner_map, number_of_points, radius, threshold)
%ANMS This function is an implementation of Adaptive Non-Maximal
%Suppression. The goal is to only keep points of the image that are the
%highest valued out of the entire image but also the highest point in a
%region of the image.  The region is defined by the radius, so if we choose
%a radius of 24, we will be picking the local max of the corner map in a
%48x48 window.  This produces an evenly distributed arrangement of corner
%points that are also max (or most interesting).  In order to determine
%true max points, we specify a threshold, 1.1 means 10% greater than all
%other points in the window.
    
    % we don't want to include any points that overlap with another point.
    % We do this by multiplying the radius by 2, then making sure no
    % centroids of a corner fall into that bound.
    bound = radius*2;

    image_size = size(corner_map);
    
    % Sort all the pixels in the map from largest to smallest
    [sorted_corners, inds] = sort(corner_map(:), 'descend');

    % Our list of corners, we start with them all zeros
    corners = zeros(number_of_points, 2);
    
    % This is the count of corners we have found.  This is a helper indexer
    ith_corner = 0;
    
    
    % We are going to iterate over every point in the corner map with the
    % largest value to the smallest value
    for cI = 1:size(sorted_corners)
        
        % We don't want points that are overlapping with a corner we have
        % already taken.
        does_this_corner_overlap = false;
        
        % Get the x,y position of the current corner point we are looking
        % at
        [cY, cX] = ind2sub(image_size, inds(cI));
        
        % Iterate over all of our accepted corners to see if they overlap
        % with the one we are looking at.
        for c = 1:ith_corner
            % Get the y,x pair for the current accepted corner we want to
            % compare with our new corner
            point = corners(c, :);
            
            % If the new corner overlaps with an existing accepted corner,
            % we will set the overlap flag, break, and then skip this
            % corner
            if point(1) >= cY - bound && point(1) <= cY + bound && point(2) >= cX - bound && point(2) <= cX + bound
                does_this_corner_overlap = true;
                break;
            end
        end
        
        % This maximum is in the radius of a different point.  So skip it
        if does_this_corner_overlap
            continue;
        end
        
        % This point is not a local max in its neighbourhood
        if ~local_maximum(cY, cX, corner_map, corner_map(cY, cX) * threshold, radius)
            continue;
        end
        
        % We have found a corner! Update the indexer by 1
        ith_corner = ith_corner + 1;
        % Put the x,y coordinates in the accepted corners array.
        corners(ith_corner, :) = [cY, cX];
        
        % If this was the last corner we needed to accept before we hit our
        % max number of points we break early and stop finding corners
        % (since we've found all the most important ones - no need to do
        % any more).
        if ith_corner == number_of_points
            break
        end
        
    end
    
    % This removes the zero points if we found less corners than the
    % specified number of points.
    corners = corners(1:ith_corner, :);
    
end


function keep = local_maximum(i, j, map, val, radius)
    % This function is to determine if a value is larger than all the
    % values in a window at the center pixel, (i,j) with a radius.  
    
    % by default, lets say we are going to keep the point (or the point is
    % a local max)
    keep = true;
    
    % Lets find the windows start and end positions in the x and y
    % directions.
    x_start = max(1, j - radius);
    x_end = min(size(map, 2), j + radius);
    y_start = max(1, i - radius);
    y_end = min(size(map, 1), i + radius);
    
    % Grab the window from the map
    window = map(y_start:y_end, x_start:x_end);
    
    % Sort all the pixel values in the map from largest to smallest
    [vals, inds] = sort(window(:), 'descend');
    
    % If the largest value in the window is larger than the value passed
    % into this function, return false (as in this point is NOT a local
    % max)
    if vals(1) > val
        keep = false;
    end

end


% TODO - so this is most likely incredibly inefficient.  It does do the job
% but if anyone can think of a better way or more optimized way of doing
% this let me know!