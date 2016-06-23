%% skin color detection
clear
close all
load skin
% Read training images
gt = imread('parts_lfw_funneled_gt_images\Aaron_Peirsol_0003.ppm');
face_gt = gt(:,:,2);
im = imread('lfw_funneled\Aaron_Peirsol\Aaron_Peirsol_0003.jpg');
imYCbCr = rgb2ycbcr(im);
imYCbCr = double(imYCbCr);
imL=reshape(imYCbCr, size(imYCbCr,1)*size(imYCbCr,2),3); % linearize
% calculate distance
for i=1:size(M,1)

    m = M(i,:);
    c = reshape(C(i,:,:), 3, 3);
    
    delta = imL - repmat(m, size(imL,1), 1);
    distance(:,i) = sum(delta*inv(c) .* delta, 2);
end;
dist_min = min(distance, [], 2);
% threshold
skin_pt=find(dist_min < 10);
skin_map = zeros(size(im,1)*size(im,2),1);
skin_map(skin_pt,1) = 1;
skin_map = reshape(skin_map, size(im,1), size(im,2));
figure, imshow(skin_map,[])