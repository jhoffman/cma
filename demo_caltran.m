function results = demo_caltran(feature_type, start_index)

%% Parameters
% Edit to include the correct parameters for experimental setup
expt = config_caltran(feature_type, start_index);
%norm_type = expt.norm_type;
%ns = expt.ns; % number of training data points
%dim = expt.dim; % dimension to project onto
%start = expt.start; % index of first training image
%Tmax = expt.Tmax; % maximum number of test images to use
%block_size = expt.block_size; % how many images to consider per time step
%alpha = expt.alpha; % forgetting factor
%C = expt.C; % C-SVM parameter


resultname = get_resultname('caltran', expt);
if exist(resultname, 'file')
    results = load(resultname);
    return;
end
disp(resultname)
%% Load Data
tic
fprintf('Loading Caltran Data: Feature Type %s', feature_type);
% considering the feature type and normalization etc load the data
[features, labels, fnames] = load_fts_caltran(expt);
fprintf(' (%2.2f s)\n', toc);
[Xs, Xt, Ys, Yt, fnames_s, fnames_t] = split_data_train_test_caltran(...
    features, labels, fnames, expt);
T = length(Yt);

%% No Adaptation Baselines
expt.classifier = 'knn';
model_knn  = train_model(expt, Xs, Ys);
results.knn = classify_data(expt, model_knn, Xs, Ys, Xt, Yt);

expt.classifier = 'linearsvm';
model_svm = train_model(expt, Xs, Ys);
results.svm = classify_data(expt, model_svm, Xs, Ys, Xt, Yt);

%% Continuous Manifold Adaptation (CMA)
[Xt_cgfk, Xt_csa] = cma(expt, Xs, Xt);
expt.classifier = 'knn';
results.cgfk_knn = classify_data(expt, model_knn, Xs, Ys, Xt_cgfk, Yt);
results.csa_knn = classify_data(expt, model_knn, Xs, Ys, Xt_csa, Yt);

expt.classifier = 'linearsvm';
results.cgfk_svm = classify_data(expt, model_svm, Xs, Ys, Xt_cgfk, Yt);
results.csa_svm = classify_data(expt, model_svm, Xs, Ys, Xt_csa, Yt);

algs = fieldnames(results);
colors = {'k', 'c', 'b', 'g', 'y', 'r', 'm'};
lines = {'--', '-', ':', '-.'};
fprintf('\n\nSummary results:\t Accuracy \t   AP\n');
for i = 1:length(algs)
    alg = algs{i};
    str = '%s:\t\t';
    if length(alg) < 7 % less than a tab
        str = [str, '\t'];
    end
    str = [str, ' %6.2f \t %6.2f\n'];
    fprintf(str, alg, results.(alg).acc, results.(alg).ap);
end
figure(5), clf; 
hold on;
legend_str = cell(length(algs),1);
for i = 1:length(algs)
    alg = algs{i};
    ci = mod(i-1,length(colors))+1;
    c_str = [colors{ci}, lines{floor((i-1)/length(colors))+1}];
    plot(results.(alg).recall, results.(alg).prec, c_str, 'LineWidth', 2);
    legend_str{i} = sprintf('%s: ap=%6.2f', regexprep(alg,'_',' '), results.(alg).ap);
end
set(gca, 'FontSize', 14);
title(sprintf('Caltran Dataset Scene Classification - %d test', T));
xlabel('Recall'); ylabel('Precision');
legend(legend_str,'Location', 'SouthWest');

if isfield(expt,'save_result') && expt.save_result
    save(resultname, 'results', 'expt');
end
end

