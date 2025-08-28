function [D1, D2] = dst_diff(n, L)
%DST_DIFF_MATS  Dirichlet spectral collocation.
%   [D1, D2] = dst_diff_mats_slow(n, L)
%   n  - total grid points INCLUDING endpoints (n >= 3)
%   L  - domain length on [0, L]
%   D1 - first-derivative matrix on interior (size (n-2)x(n-2))
%   D2 - second-derivative matrix on interior (size (n-2)x(n-2))
%
% Builds D1, D2 via:  a = S^T u,  u' = (2/(N+1)) C diag(k*pi/L) a,
%                     u''= (2/(N+1)) S diag(-(k*pi/L)^2) a,
% where S_{jk}=sin(jkπ/(N+1)), C_{jk}=cos(jkπ/(N+1)), j,k=1..N, N=n-2.

    if nargin < 2, L = 1; end
    N = n - 2;
    if N <= 0, D1 = []; D2 = []; return; end

    j = (1:N).';                      % interior row indices
    k = (1:N);                        % mode indices
    theta = pi*(j*k)/(N+1);           % matrix of jkπ/(N+1)

    S = sin(theta);                   % sine synthesis at interior nodes
    C = cos(theta);                   % cosine synthesis at interior nodes
    scale = 2/(N+1);

    lam = (pi*(1:N)/L);               % k*pi/L, row vector
    D1  = scale * C * diag(lam)    * S.';     % first derivative
    D2  = scale * S * diag(-(lam.^2)) * S.';  % second derivative (symmetric)
end
