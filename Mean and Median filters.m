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
h=figure; 
imshow(uint8(gray)); 
set(h,'Name','Gray Image');

%Convert to uint8
gray1=uint8(gray);

lowpass_img = vsg('LowPass',gray1);
h=figure; 
imshow(uint8(lowpass_img)); 
set(h,'Name','Lowpass image');

median_img = vsg('Median',gray1);
h=figure; 
imshow(uint8(median_img)); 
set(h,'Name','Median image');

