function expt = config_caltran(feature_type, start_index)
% Usage: expt = config_caltran(feature_type, start_index)
% 
% feature_type: a string indicating which precomputed feature to use
% start_index: the index of the first image to use for training
% 
% Contains the configurations to reproduce the caltran experiment from the
% paper:
% Continuous Manifold Based Adaptation for Evolving Visual Domains. Judy
% Hoffman, Trevor Darrell, and Kate Saenko. In Proc. CVPR 2014.
%
% Author Judy Hoffman (jhoffman@eecs.berkeley.edu)
if nargin < 1
    feature_type = 'gist';
    start_index  = 350;
end
expt.feature_type = feature_type;

switch feature_type
    case 'gist'
        expt.dim = 10;
    case 'sift_sp'
        expt.dim = 30;
    otherwise
end

expt.norm_type  = 'l1_zscore'; % normalization method
expt.ns         = 50; % number of labeled training points
expt.alpha      = 1.5; % forgetting parameter for online subspace learning
expt.Tmax       = 480; % [480, 2400] - number of test images to use
expt.block_size = 1; % number of test images seen at each time step
expt.classes    = [1 -1]; % only binary classes for this dataset
expt.C          = 1; % C-svm param
expt.start      = start_index; % index of first training image
expt.interp     = false; % param for ap computation
expt.fast_mode  = true; % use the approx GFK if true
end