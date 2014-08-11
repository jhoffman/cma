% Add External Dependencies
if exist('external/vlfeat', 'dir')
    addpath external/vlfeat/toolbox/plotop
    addpath external/vlfeat/toolbox/misc
else
    warning(['Missing vlfeat dependency: Run external/get_vlfeat.sh\n',...
     '  or checkout the git repo with external/checkout_vlfeat.sh\n']);
end
if exist('external/ivt', 'dir')
    addpath external/ivt/
    addpath external/ivt/pca_comparison/
else
    warning('Missing ivt dependency: Run external/get_ivt.sh\n');
end
if exist('external/GFK', 'dir')
    addpath external/GFK/
else
    warning('Missing GFK dependency: Run external/get_GFK.sh\n');
end
if exist('external/liblinear', 'dir')
    addpath external/liblinear/matlab/
else
    warning('Missing liblinear dependency: Run external/get_liblinear.sh\n');
end

% Add subdirectories needed
addpath cache_fts/
addpath classifiers/
addpath config/
addpath data_handling/
addpath util/
