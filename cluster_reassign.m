% re-assign cluster ids
function [cluster_id] = cluster_reassign(skin_ycbcr, M, C)
% calculate the distane to each clusters
for i=1:size(M,1)

    m = M(i,:);
    c = reshape(C(i,:,:), 3, 3);
    
    delta = skin_ycbcr - repmat(m, size(skin_ycbcr,1), 1);
    distance(:,i) = sum(delta*inv(c) .* delta, 2);
end;

[D cluster_id] = min(distance,[],2);
