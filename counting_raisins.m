addpath('C:\VSG_IPA_toolbox'); %Setup the paths
addpath('C:\VSG_IPA_toolbox\images');
clc; %Clear command window
clear all; %Clear all variables and functions from memory

%Load the image and convert it to greyscale
img=imread('raisins.jpg');
h=figure;subplot(3,3,1); imshow(uint8(img)); title('Original Image');
grey = rgb2gray(img);
subplot(3,3,2);imshow(uint8(grey)); title('Greyscsale Image');

%Data driven threshold
high_grey = vsg('HighestGrey',grey);
low_grey = vsg('LowestGrey',grey);
thresh = uint8((high_grey + low_grey)/2);
threshold = vsg('Threshold', grey, thresh);
subplot(3,3,3); imshow(uint8(threshold)); title('Thresholded Image');

%The image obtained is inverted
thresh_invert=vsg('Inverse',threshold);
subplot(3,3,4); imshow(uint8(thresh_invert)); title('Inverted Image');
%filter is applied to remove noise
filter_noise=vsg('RAFilter',thresh_invert,3);
subplot(3,3,5); imshow(uint8(filter_noise)); title('Noise filter');
%Threshold again
threshold1= vsg('MidThresh',filter_noise);
subplot(3,3,6); imshow(uint8(threshold1)); title('Threshold 2nd time');

%Boundary Raisins Removal
marker = threshold1;
marker(7:size(threshold1,1)-7,7:size(threshold1,2)-7,:)=0;
subplot(3,3,7);imshow(uint8(marker)); title('Marker Image');
[out_img1,out_img2]=vsg('ReconByDil',thresh_invert,marker,4);
subplot(3,3,8); imshow(uint8(out_img1)); title('Reconstructed Image');
filter_noise1=vsg('RAFilter',out_img2,3);
threshold2= vsg('MidThresh',filter_noise1);
subplot(3,3,9); imshow(uint8(threshold2)); title('Removal of boundary
raisins');

%Finding centroids of different blobs
label=vsg('Labeller',threshold2);
centroid=vsg('Centroid',label);
h=figure; imshow(uint8(centroid)); set(h,'Name','Centroid');
point=vsg('Point2Square',centroid);
point=vsg('Add',point,img);
h=figure; imshow(uint8(point)); set(h,'Name','Boxes on Centroid');

%Counting the raisins
count=vsg('WPCounter',centroid);
str=[' The no. of raisins are: ' num2str(count)];
disp(str); 
