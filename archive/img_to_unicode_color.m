img = imread('shutterstock.jpg');
gray = rgb2gray(img);
[H, W] = size(gray);
gray2 = imresize(gray, [1024, (1024 * (W/H) * 1.6)]);
[r, c] = size(gray2);
img2 = imresize(img, [r, c]);
gradient_chars = {'█', '▓', '▒', '░', '&nbsp;'};
unicode_str = cell(r, 1);

for row = 1:r
    line_chars = cell(1,c);
    for col = 1:c
        value = gray2(row, col);
        char_index = ceil(value / 51);
        if char_index == 0
            char_index = 1;
        end
        pixel_color = img2(row, col, :);
        R = pixel_color(1);
        G = pixel_color(2);
        B = pixel_color(3);
        hex_color = sprintf('<span style="color:rgb(%d,%d,%d)">', R, G, B);
        line_chars{col} = [hex_color, gradient_chars{char_index}, '</span>'];
    end
    unicode_str{row} = [strjoin(line_chars, ''), '<br>'];
end

html_content = ['<html><body style="font-family: ''Courier New'', monospace; font-size:0.5px; line-height:1em; letter-spacing:0; white-space:pre;">', ...
    strjoin(unicode_str, ''), ...
    '</body></html>'];

current_dir = pwd;
html_file_name = fullfile(current_dir, 'unicode_color.html');
fid = fopen(html_file_name, 'w');
fprintf(fid, '%s', html_content);
fclose(fid);
disp(['HTML file saved to: ', html_file_name]);





