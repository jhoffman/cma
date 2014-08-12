function [Xt_cgfk, Xt_csa] = cma(expt, Xs, Xt)
% Usage: [Xt_cgfk, Xt_csa] = cma(expt, Xs, Xt)
%
% Implements the algorithm from:
% Continuous Manifold Based Adaptation for Continuously Evolving Domains.
% Judy Hoffman, Trevor Darrell, Kate Saenko. In Proc. CVPR 2014. 
%
% If using code please cite the above paper.
% Author: Judy Hoffman (jhoffman@eecs.berkeley.edu)

% Required Parameters
block_size = expt.block_size;
alpha      = expt.alpha;

% Compute the source subspace (PCA)
T = size(Xt, 1);
[~,Ss,Vs] = svd(Xs);
if ~isfield(expt, 'dim') || expt.dim == -1
    dim = sum(diag(Ss)>10);
    fprintf('[Adapt] Chosen dim%d\n', dim);
else
    dim = expt.dim;
end
Ps = Vs(:, 1:dim);
Q = [Ps, null(Ps')];
Ut = Ps; % Initialize
m = min(size(Ss,1),dim);
S = diag(Ss(1:m,1:m));
S((m+1):dim) = 0;
mu = mean(Xs)';
nprev = size(Xs,1);
Xt_cgfk = zeros(size(Xt));
Xt_csa = zeros(size(Xt));
fprintf('[Adapt] Continuous Manifold Adaptation (CMA) '); t_osvd = tic;
wfig = waitbar(0, 'Continuous Domain Adaptation');
for i = block_size:block_size:T
    ind = (i-block_size+1):i;
    
    [Ut, S, mu, nprev] = sklm(Xt(ind,:)', Ut, S, mu, nprev, alpha, dim);
    if expt.fast_mode
        G = fastGFK(Q, Ut);
    else
        G = GFK(Q, Ut);
    end
    Xt_cgfk(ind,:) = Xt(ind,:) * G;
    Xt_csa(ind,:) = Xt(ind,:) * (Ut*Ut');
    if mod(i/expt.block_size, 10) == 0
        fprintf('.');
    end
    time_so_far = toc(t_osvd);
    iter = i/block_size;
    max_iter = T / block_size;
    expected_time = time_so_far / iter * max_iter;
    waitbar(i/T, wfig, sprintf('Continuous Domain Adaptation: %2.1f/%2.1f (s)', time_so_far, expected_time));
end
close(wfig);
fprintf('done.%f(s)\n',time_so_far);
end