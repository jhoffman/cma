function [fts, labels, fnames] = load_fts_caltran(expt)
% Usage: [fts, labels, fnames] = load_fts_caltran(expt)
% Load the features for caltran data of type feature type
%
% expt: struct that has at least the params ft_type and norm_type
ft_type   = expt.feature_type;
norm_type = expt.norm_type;
switch ft_type
    case 'gist'
        load caltran_gist.mat
        load caltran_dataset_labels
        features = data.features;
        labels = labels';
        fnames = names;
        
        % Remove NANs
        [r,c] = find(isnan(features));
        ind = find(~ismember(1:size(features,1), r));
        features = features(ind,:);
        features = double(features);
        labels = labels(ind);
        labels = labels(:);
        fnames = fnames(ind);
        
        fts = NormalizeData(features', norm_type)';
    case 'sift_sp'
        load caltran_spm.mat
        labels = labels(:);
        features = pyramid_all;
        fnames = filenames;
        fts = NormalizeData(features, norm_type);
    otherwise
        error('[Load features] Unknown feature type: %s', ft_type);
end
end