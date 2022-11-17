addpath('C:\VSG_IPA_toolbox'); %Setup the paths
addpath('C:\VSG_IPA_toolbox\images');
clc;
clear all; % Clear command window.
clear all; % Clear all variables and functions from memory

%Load the parrot image
img = imread('parrot.jpg');
h=figure; imshow(uint8(img)); set(h,'Name','Original Image');

%Convert to grey-scale image
gray = rgb2gray(img);
h=figure; imshow(uint8(gray)); set(h,'Name','Gray Image');

%Convert to uint8
gray1=uint8(gray);

lowpass_img = vsg('LowPass',gray1);
h=figure; imshow(uint8(lowpass_img)); set(h,'Name','Lowpass image');

median_img = vsg('Median',gray1);
h=figure; imshow(uint8(median_img)); set(h,'Name','Median image');

li = uint8(lowpass_img);
mi = uint8(median_img);
k1 = imnoise(mi, 'gaussian', 0, 0.001);

median_img1 = vsg('Median',k1);
h=figure;subplot(3,2,1); imshow(uint8(median_img1));title('Median 0.001 Noise');
k2= imnoise(mi, 'gaussian', 0, 0.002);

median_img2 = vsg('Median',k2);
subplot(3,2,2); imshow(uint8(median_img2));title('Median 0.002 Noise');
k3= imnoise(mi, 'gaussian', 0, 0.004);

median_img3 = vsg('Median',k3);
subplot(3,2,3); imshow(uint8(median_img3));title('Median 0.004 Noise');
k4= imnoise(mi, 'gaussian', 0, 0.006);

median_img4 = vsg('Median',k4);
subplot(3,2,4); imshow(uint8(median_img4));title('Median 0.006 Noise');
k5= imnoise(mi, 'gaussian', 0, 0.008);

median_img5 = vsg('Median',k5);
subplot(3,2,5); imshow(uint8(median_img5));title('Median 0.008 Noise');
k6= imnoise(mi, 'gaussian', 0, 0.01);

median_img6 = vsg('Median',k6);
subplot(3,2,6); imshow(uint8(median_img6));title('Median 0.01 Noise');
