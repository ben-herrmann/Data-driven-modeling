function [x,f] = burgers()

n = 128;
x = linspace(0,1,n)';
nu = 0.01;
[D,D2] = dst_diff(n);
f = @(t,q) nu*D2*q - q.*(D*q);

end