function G = fastGFK(Q,Pt)
% Input: Q = [Ps, null(Ps')], where Ps is the source subspace, column-wise orthonormal
%        Pt: target subsapce, column-wise orthonormal, D-by-d, d < 0.5*D
% Output: G = \int_{0}^1 \Phi(t)\Phi(t)' dt
%
% ref: Geodesic Flow Kernel for Unsupervised Domain Adaptation.  
% B. Gong, Y. Shi, F. Sha, and K. Grauman.  
% Proceedings of the IEEE Conference on Computer Vision and Pattern Recognition (CVPR), Providence, RI, June 2012.
%
% Faster approximate version of GFK
% Contact: Judy Hoffman (jhoffman@eecs.berkeley.edu)
% adapted from Boqing Gong (boqinggo@usc.edu)

N = size(Q,2); % 
dim = size(Pt,2);

Ps = Q(:,1:dim);
R = Q(:,(dim+1):end);
A = Ps'*Pt;
B = R'*Pt;

Binv = pinv(B);
[V1,S,V2] = svds(A*Binv,dim);
if size(S,1) < dim
    [V1, S, V2] = svd(A*Binv);
end
% compute the principal angles
%QPt = Q' * Pt;
%[V1,V2,V,Gam,Sig] = gsvd(QPt(1:dim,:), QPt(dim+1:end,:));
V2 = -V2;
%theta = real(acos(diag(Gam))); % theta is real in theory. Imaginary part is due to the computation issue.
theta = real(atan(1./diag(S)));

% compute the geodesic flow kernel
eps = 1e-20;
B1 = 0.5.*diag(1+sin(2*theta)./2./max(theta,eps));
B2 = 0.5.*diag((-1+cos(2*theta))./2./max(theta,eps));
B3 = B2;
B4 = 0.5.*diag(1-sin(2*theta)./2./max(theta,eps));

PsV1 = Q(:,1:dim)*V1;
%RsV2 = Q(:,(dim+1):end)*V2;
% since we will only use the first dim columns dont waste time computing
% them all
RsV2 = Q(:,(dim+1):end)*V2(:,1:dim);

Qv = [PsV1, RsV2];
Bsub = [B1, B2; B3, B4];
Q1 = Qv(1:2*dim, 1:2*dim);
Q3 = Qv((2*dim+1):end, 1:2*dim);

Q3_Bsub = Q3 * Bsub;
Q1_Bsub_Q1t = Q1 * Bsub * Q1';
Q3_Bsub_Q1t = Q3_Bsub * Q1';
Q3_Bsub_Q3t = Q3_Bsub * Q3';

G = [Q1_Bsub_Q1t, Q3_Bsub_Q1t'; Q3_Bsub_Q1t, Q3_Bsub_Q3t];
