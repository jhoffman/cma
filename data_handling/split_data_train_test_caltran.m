function [Xs, Xt, Ys, Yt, fnames_s, fnames_t] = split_data_train_test_caltran(...
    features, labels, fnames, param)
ns = param.ns; % number of training data points
start = param.start; % index of first training image
Tmax = param.Tmax; % maximum number of test images to use

tr_ind = start:(ns+start);
T = min(Tmax,size(features, 1)); % can't go beyond the number of data points available
te_ind = (ns+start+1):(ns+start+1+T);

% Create training and test split
Xs = features(tr_ind, :);
Ys = labels(tr_ind);
fnames_s = fnames(tr_ind);

Xt = features(te_ind,:);
Yt = labels(te_ind);
fnames_t = fnames(te_ind);
end