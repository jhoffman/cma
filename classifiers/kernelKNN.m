function [preds, V, Inds, prob, pred2] = kernelKNN(labels, K, nKtr, nKtest)
%
[n,ntr] = size(K);

nKtest_mat = repmat(nKtest, 1, ntr);
nKtr_mat = repmat(nKtr', n, 1);
D = nKtest_mat + nKtr_mat - 2 * K;
%D = -K ./ (nKtest_mat .* nKtr_mat);

% we want small distances - sort from low to high
[V, Inds] = sort(D, 2, 'ascend');
preds = labels(Inds(:,1));

classes = unique(labels);
prob = zeros(n,length(classes));

for c = 1:length(classes)
    pos_ind = (labels == classes(c));
    neg_ind = (labels ~= classes(c));
    for i = 1:n
        min_dist_pos = min(D(i,pos_ind));
        min_dist_neg = min(D(i,neg_ind));
        prob(i,c) = exp(-min_dist_pos / min_dist_neg);
    end
end

pred2 = prob;
if numel(classes) == 2
    % assume label=1 is positive
    prob = prob(:,classes == 1);
end
end