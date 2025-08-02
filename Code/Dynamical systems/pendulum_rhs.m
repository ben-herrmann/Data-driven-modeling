function dxdt = pendulum_rhs(x,beta)

theta = x(1);
omega = x(2);

dtheta = omega;
domega = -sin(theta) - beta*abs(omega)*omega;

dxdt = [dtheta; domega];

end