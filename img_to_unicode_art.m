
% imread returns a 3D matrix that stores pixel color data
% might return something like [550, 550, 3]
% [height, width, # of color channels]
img = imread('test_image.png');

% converts the matrix to [height, width]
% the values in each cell represent brightness
% that is a weighted sum of R, G, & B
% 255 is white and 0 is black
gray = rgb2gray(img);

% resize the image to have 64 rows
% the height will scale accordingly
gray2 = imresize(gray,[64 NaN]);

imshow(gray2)







