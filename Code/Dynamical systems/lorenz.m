clear variables; close all; clc

% parameters
sigma = 10;
beta = 8/3;
rho = 28;

f = @(t,x) [sigma*(x(2)-x(1));
            x(1)*(rho-x(3))-x(2);
             x(1)*x(2)-beta*x(3)];

% time discretization
m = 10000;
t = linspace(0,50,m);

% initial condition
x0 = [10,-10,25];

% solve dx/dt = f(t,x)
[~,X] = ode45(f,t,x0);
X = X';
%%
% plot solution
figure('IntegerHandle','off','Position',[1500 0 800 300])
set(gcf, ...
    'defaultTextInterpreter','Latex', ...
    'defaultAxesTickLabelInterpreter','Latex', ...
    'defaultAxesFontSize',18, ...
    'defaultLineLineWidth',1.2, ...
    'defaultFigureColor','w')

plot3(X(1,:),X(2,:),X(3,:)), axis equal, axis tight
xlabel('$x$'); ylabel('$y$'); zlabel('$z$')
grid on