%shahbaz malik


clear all;
clc;

FRAMES = 1;
WIDTH = 512;
HEIGHT = 512;

img = rgb2gray(imread("coinss.jpg"));
img = double(img);

xOut = 1;
yOut = 1;
img_out = zeros(HEIGHT, WIDTH);

for y = 0:HEIGHT-1
    for x = 0:WIDTH-1
        if y >= 0 && y < HEIGHT && x >= 0 && x < WIDTH
            pixData1 = img(y+1,x+1);
        else
            pixData1 = 0;
        end


        [xOut, yOut, dataOut] = ...
            sobel_edge_detection(x, y, pixData1);


        if yOut >= 0 && yOut < HEIGHT && xOut >= 0 && xOut < WIDTH
            img_out(yOut+1,xOut+1,:) = dataOut;
        end
    end
end


figure(1);
subplot(1,2,1);
imshow(uint8(img));
subplot(1,2,2);
imshow(uint8(img_out));
imwrite(uint8(img_out), "output.png")



