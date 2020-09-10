function img_plotter(original_image, corners, radius)
%IMG_PLOTTER This is mostly a helper function that plots little red circles
% on each corner detected onto the original image given, with a larger
% yellow circle indicating the radius we set for ANMS.
    
    % Throw up the original image
    figure;
    imshow(original_image);
    
    % Iterate over all the corners
    for cPos = 1:size(corners, 1)
        
        % Grab the corner positions
        i = corners(cPos, 1);
        j = corners(cPos, 2);
        
        % Draw the red circle, this is the corner point
        drawcircle('Center',[j,i], 'Color', [1,0,0], 'Radius', 3, 'InteractionsAllowed', 'none');
        
        % Draw this points neighbourhood radius in yellow.
        drawcircle('Center',[j,i], 'Color', [1,1,0], 'Radius', radius, 'InteractionsAllowed', 'none', 'FaceAlpha', 0.1);
        
        % Dramatic work illusion, remove this if you are not a fan of
        % theatrics.
        pause(0.1);
    end

end

