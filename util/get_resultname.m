function resultname = get_resultname(database, expt)
% Usage: result_name = get_resultname(database, expt)

% Collect parameters
alpha        = expt.alpha;
ns           = expt.ns;
dim          = expt.dim;
C            = expt.C;
Tmax         = expt.Tmax;
block_size   = expt.block_size;
norm_type    = expt.norm_type;
start        = expt.start;
feature_type = expt.feature_type;

switch database
    case 'caltran'
        resultname = 'caltran_alpha%1.2f_C%d_ns%d_start%d_T%d_dim%d_blk%d_%s_nrm%s.mat';
        resultname = sprintf(resultname, alpha, C, ns, start, Tmax, dim, ...
            block_size, feature_type, norm_type);

        resultname = fullfile('results/caltran', resultname);
    case 'sedandatabase'
    otherwise
        error('Unknown database %s', database);
end


end