addpath('C:\VSG_IPA_toolbox');
addpath('C:\VSG_IPA_toolbox\images');
addpath('H:\');
clc;
clear all;

%Load image
img=imread('nut.jpg');
%img = imnoise(img,'gaussian',0,0.01);
%img = imnoise(img,'poisson');
img = imnoise(img,'salt & pepper',0.05);
h=figure;subplot(4,4,1); imshow(uint8(img)); title('salt & pepper Noise');
%Grey scale image
grey = rgb2gray(img);
subplot(4,4,2);imshow(uint8(grey));title('Grey Image');

%Data-driven threshold,filter
high_grey = vsg('HighestGrey',grey);
low_grey = vsg('LowestGrey',grey);
thresh = uint8((high_grey + low_grey)/2);
threshold = vsg('Threshold', grey, thresh);
subplot(4,4,3); imshow(uint8(threshold));title('Data-Driven Thresholding');
filter_noise=vsg('RAFilter',threshold,3);
subplot(4,4,4); imshow(uint8(filter_noise)); title('Filter');
threshold1= vsg('MidThresh',filter_noise);
subplot(4,4,5); imshow(uint8(threshold1)); title('Mid Threshold');

%Blob filliing and thresholding
fill=vsg('BlobFill',threshold1);
subplot(4,4,6); imshow(uint8(fill)); title('Blob Filling');
dil2=vsg('Dilation',fill,8);
dil6=vsg('Dilation',dil2,8);

% Auto-Canny
canny = edge(dil6,'Canny');
subplot(4,4,7); imagesc((canny(:,:,1)));colormap(gray);title('Auto-Canny');
dil3=vsg('Dilation',canny,8);

%Hough and threshold
out_img= vsg('Hough',dil3);
subplot(4,4,8); imagesc((out_img(:,:,1)));colormap(gray);title('Hough');
high_grey1 = vsg('HighestGrey',out_img);
low_grey1 = vsg('LowestGrey',out_img);
thresh1 = uint8((high_grey1 + low_grey1)/2);
threshold3 = vsg('Threshold', out_img, thresh1);

%White pixel count
wp=vsg('WPCounter',threshold3);
subplot(4,4,9); imshow(uint8(threshold3)); title('Threshold');

%Inverse Hough
out_img3=vsg('InvHough',out_img,wp);
high_grey1 = vsg('HighestGrey',out_img3);
low_grey1 = vsg('LowestGrey',out_img3);
thresh1 = uint8((high_grey1 + low_grey1)/2);
t3 = vsg('Threshold', out_img3, thresh1);
subplot(4,4,10);imagesc((t3(:,:,1)));colormap(gray) ; title('Inverse Hough');
