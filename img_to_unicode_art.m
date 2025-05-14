
% imread returns a 3D matrix that stores pixel color data
% might return something like [550, 550, 3]
% [height, width, # of color channels]
img = imread('iStock.jpg');


% converts the matrix to [height, width]
% the values in each cell represent brightness
% that is a weighted sum of R, G, & B
% 255 is white and 0 is black
gray = rgb2gray(img);


% resize the image to have 64 rows
% the height will have 96 rows
% since the unicode characters are much
% taller than they are wide, you must 
% compensate for this vertical stretch
% with a proportional horizontal stretch
% 4 / 2.5 = 1.6 times taller
[H, W] = size(gray);
% do W / H to get the horizontal stretch
% multiply by horizontal stretches
gray2 = imresize(gray,[1024 (1024*(W/H)*1.6)]);


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

        char_index = ceil(value / 51);

        if char_index == 0
            char_index = 1;
        end
        
        unicode{row, col} = gradient_chars{char_index};
    end
end


% put each row of unicode in one concatenated cell
unicode_str = cell(r, 1);
for i = 1:r
    unicode_str{i} = strjoin(unicode(i, :), '');
end


% plot figure
fig = uifigure('Name', 'Unicode Matrix', 'Position', [100, 100, 500, 500]);

txt = uitextarea(fig, 'Position', [10, 10, 480, 480]);
txt.FontSize = 0.5;
txt.FontName = 'Courier New';
txt.Value = unicode_str;






