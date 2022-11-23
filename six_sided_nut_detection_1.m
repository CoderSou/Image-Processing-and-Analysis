addpath('C:\VSG_IPA_toolbox');
addpath('C:\Users\maitis2\Downloads');
clc;
clear all;

img=imread('nut.jpg');
h=figure; subplot(4,4,1);imshow(uint8(img)); title('Original Image');
% img = imnoise(img,'gaussian',0,0.01);
% img = imnoise(img,'poisson');
%img = imnoise(img,'salt & pepper',0.05);
%Grey Scale image
grey = rgb2gray(img);
subplot(4,4,2); imshow(uint8(grey)); title('Grey Image');

%Data-driven threshold
high_grey = vsg('HighestGrey',grey);
low_grey = vsg('LowestGrey',grey);
thresh = uint8((high_grey + low_grey)/2);
threshold = vsg('Threshold', grey, thresh);
subplot(4,4,3); imshow(uint8(threshold)); title('Thresholded Image');
%Filtering and thresholding
filter_noise=vsg('RAFilter',threshold,3);
threshold1= vsg('MidThresh',filter_noise);

%Blob Filling
fill=vsg('BlobFill',threshold1);
subplot(4,4,4); imshow(uint8(fill));title('fill');
 %Finding Biggest blobs and subtract
 blob1=vsg('BiggestBlob',fill);
 subplot(4,4,5); imshow(uint8(blob1));title('Biggest Blob 1');
 subtract1=vsg('Subtract',fill,blob1);
 subplot(4,4,6);imshow(uint8(subtract1));title('Biggest Blob 1 Removed');
 blob2=vsg('BiggestBlob',subtract1);
 subplot(4,4,7); imshow(uint8(blob2));title('Biggest Blob 2');;
 subtract2=vsg('Subtract',subtract1,blob2);
 subplot(4,4,8);imshow(uint8(subtract2));title('Biggest Blob 2 Removed');

%Finding Smallest blobs and subtract
blob3=vsg('SmallestBlob',subtract2);
subplot(4,4,9);imshow(uint8(blob3));title('Smallest Blob 1 ');
 subtract3=vsg('Subtract',subtract2,blob3);
 subplot(4,4,10);imshow(uint8(subtract3));title('Smallest Blob 1
Removed');
 blob4=vsg('SmallestBlob',subtract3);
 subplot(4,4,11);imshow(uint8(blob4));title('Smallest Blob 2');
 subtract4=vsg('Subtract',subtract3,blob4);
 subplot(4,4,12); imshow(uint8(subtract4));title('Biggest Blob 2
Removed');
threshold5= vsg('MidThresh',subtract4);

%Auto-Canny
canny = edge(threshold5,'Canny');
subplot(4,4,13); imshow(double(canny));title('Canny');

%Hough and threshold
out_img= vsg('Hough',canny);
subplot(4,4,14); imagesc((out_img(:,:,1)));colormap(gray),title('Hough');
high_grey1 = vsg('HighestGrey',out_img);
low_grey1 = vsg('LowestGrey',out_img);
thresh1 = uint8((high_grey1 + low_grey1)/2);
threshold1 = vsg('Threshold', out_img, thresh1);

%Count the white pixels
wp=vsg('WPCounter',threshold1);
subplot(4,4,15); imshow(uint8(threshold1)); title('White pixels');

%Inversse Hough
out_img3=vsg('InvHough',out_img,wp);
subplot(4,4,16);imagesc((out_img3(:,:,1)));colormap(gray) ; title('Inverse
Hough');
h=figure; imshow(double(canny)); set(h, 'Name', 'canny');
grey=uint8(grey);
out_img3=uint8(out_img3);
s=vsg('Add',threshold,out_img3);
h=figure; imshow(double(s)); set(h, 'Name', 's');
h=figure; imshow(uint8(grey)); set(h,'Name', 'Noise Addition Salt and Pepper');
