
clc; %Clear command window
clear all; %Clear all variables and functions from memory

a=[0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0;0,0,1,1,1,1,0,0;0,0,1,1,1,1,0,0;0,0,0,0,0,0,0,0;0,0,0,0,0,0,0,0];
b=[0,1,0;1,1,1;0,0,0];

erode = imerode(a,b);
comp = imcomplement(erode);
subplot(2,2,1); imshow(comp); title('left side of equation');

acomp = imcomplement(a);
rot = imrotate(b,180);

dil = imdilate(acomp,rot);
subplot(2,2,2); imshow(dil); title('right side of equation');
