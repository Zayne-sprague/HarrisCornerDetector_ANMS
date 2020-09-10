% SET UP - constants - 
IMAGE = "Notre-Dame-test-image.jpg";
radius = 24;
number_of_points = 50;
threshold = 1.1;

% PREPROCESSING
original_image = imread(IMAGE);

grayed_image = grayscale(original_image);

smoothed_image = smooth(grayed_image, 32, 3);

% HARRIS CORNER DETECTION
[xDerivative, yDerivative] = derivative(smoothed_image); 

hess = hessian(xDerivative, yDerivative);

corners = interest_measure(hess, 'HARMONIC_MEAN');

% ADAPTIVE NON-MAXIMAL SUPRESSION 
max_corner_positions = anms(corners, number_of_points, radius, threshold);

% MAP CORNER POSITIONS TO THE IMAGE IN A NICE FORMAT
img_plotter(original_image, max_corner_positions, radius);