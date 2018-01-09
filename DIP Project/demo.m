InputImage = rgb2gray(imread('images/pens.jpg'));   
%InputImage = imread('images/pens1.jpg'); 
figure
imshow(InputImage); title('Input Image');

%%% Variable value
sigma=0.05;
alpha=0.3;
beta=0.5;
gamma=1;
kappa=0.05;
wLine=0.2;
wEdge=0.6;
wTerm=1;
iterations=80;
%%%%%%%%%%%%%%%%%%%

mask = fspecial('gaussian', ceil(3*sigma), sigma);
SmoothedImage = filter2(mask, InputImage, 'same');

[xs,ys]=getsnake;
%[xs,ys]=getboxsnake;
[xs,ys]=movesnake(double(InputImage), xs, ys, alpha, beta, gamma, kappa, wLine, wEdge, wTerm, iterations);
disp('Done')

segmented=segmentation(InputImage,xs,ys);

figure
imshow(segmented);
imwrite(segmented,'images/pens1.jpg');