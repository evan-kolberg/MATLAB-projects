
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


% 5 levels - 5, 4, 3, 2, clear
% 255 / 5 = 51
% ranges for each level
% 0-51, 52-102, 103-153, 154-204, 205-255
% for this, do ceiling division
gradient_chars = {'█', '▓', '▒', '░', ' '};


[r, c] = size(gray2);

unicode = cell(r, c);


for row = 1:r
    for col = 1:c
        value = gray2(row, col);

        disp(value)
        fprintf('gray2(%d, %d) = %d, char_index = %d\n', row, col, value, ceil(value / 51));


        char_index = ceil(value / 51);

        if char_index == 0
            char_index = 1;
        end
        
        unicode{row, col} = gradient_chars{char_index};
    end
end


unicode_str = cell(r, 1);
for i = 1:r
    unicode_str{i} = strjoin(unicode(i, :), '');
end

fig = uifigure('Name', 'Unicode Matrix', 'Position', [100, 100, 500, 500]);

txt = uitextarea(fig, 'Position', [10, 10, 480, 480]);
txt.FontSize = 6;
txt.FontName = 'Courier New';
txt.Value = unicode_str;



