clear all;
clc;

%% CONVERT INPUT IMAGE INTO TEXT FILE
img = imread("LENNA_IN.bmp");
img = rgb2gray(img);
img = reshape(img,[],1);
img = dec2hex(img);
writematrix(img,"LENNA_IN.txt");


%% CONVERT OUTPUT TEXT FILE INTO IMAGE
img = readmatrix("LENNA_OUTPUT_SOBEL_NEW.txt");
img = img';
img = img(1,1:262144);
img = reshape(img,512,[]);
% img = img';
img = mat2gray(img);
imshow(img);
imwrite(img,"LENNA_SOBEL.bmp");

