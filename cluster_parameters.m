% calculate the cluster parameters
function [M C] = cluster_parameters(skin_ycbcr, cluster_id)
skin_ycbcr = double(skin_ycbcr);
for i=min(cluster_id):max(cluster_id)
    idx = find(cluster_id == i);
    cluster_color = skin_ycbcr(idx, :);
    M(i,:) = mean(cluster_color);
    delta = cluster_color - repmat(M(i,:), size(cluster_color,1), 1);
    C(i,:,:) = (delta' * delta)/(size(delta,1)-1);
end;


