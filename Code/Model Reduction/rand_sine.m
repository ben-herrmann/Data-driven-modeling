function q0 = rand_sine(x,k)

q0 = sin(pi*x*(1:k))*randn(k,1);
q0 = q0/max(abs(q0));
q0 = q0(2:end-1);

end