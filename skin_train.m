clear
close all
% Read training images
gt = imread('parts_lfw_funneled_gt_images\Aaron_Peirsol_0001.ppm');
face_gt = gt(:,:,2);
im = imread('lfw_funneled\Aaron_Peirsol\Aaron_Peirsol_0001.jpg');
imYCbCr = rgb2ycbcr(im);
imL=reshape(imYCbCr, size(imYCbCr,1)*size(imYCbCr,2),3); % linearize
[loc]= find(face_gt);
skin_ycbcr = double(imL(loc, :));
%% plot skin distribution in YCbCr
% figure, plot3(skin_ycbcr(:,2),skin_ycbcr(:,3), skin_ycbcr(:,1),'.')
% xlabel('Cb'), ylabel('Cr'), zlabel('Y')
% axis([16 240 16 240 16 235])
figure, plot3(skin_ycbcr(:,1),skin_ycbcr(:,2), skin_ycbcr(:,3),'.')
xlabel('Y'), ylabel('Cb'), zlabel('Cr')
axis([16 235 16 240 16 240])

% initialize clusters
Y = skin_ycbcr(:,1);
maxY=max(Y);
minY=min(Y);
step = round((maxY-minY)/3);
%% assign cluster labels
idx = find(Y < minY+step);
cluster_id = zeros(13311,1);
cluster_id(idx) = 1;
idx = find((Y >= minY+step) & (Y < minY+2*step));
cluster_id(idx) = 2;
idx = find(Y >= minY+2*step);
cluster_id(idx) = 3;
%% calculate cluster parameters
[M C] = cluster_parameters(skin_ycbcr, cluster_id);

iter = 1;
while (iter <10)
    disp(['iter = ' num2str(iter)]);
    % re-assign cluster label
    [cluster_id] = cluster_reassign(skin_ycbcr, M, C);
    % calculate cluster parameters
    [M C] = cluster_parameters(skin_ycbcr, cluster_id);
    iter = iter+1;
end;
figure, axis([16 235 16 240 16 240]), xlabel('Y'), ylabel('Cb'), zlabel('Cr'), hold on;
for i=1:size(M,1)
    c = reshape(C(i,:,:), 3, 3);
    plot_gaussian_ellipsoid(M(i,:), c);
end;

save skin M C