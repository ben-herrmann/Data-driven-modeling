function [x,f] = reaction_diffusion()

n = 128;
x = linspace(0,1,n)';
nu = 0.01;
[~,D2] = dst_diff(n);
f = @(t,q) nu*D2*q + q - q.^3;

end