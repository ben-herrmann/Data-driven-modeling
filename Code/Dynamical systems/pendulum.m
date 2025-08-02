clear variables; close all; clc

% parameters
beta = 20;

% function f(t,x)
f = @(t,x) pendulum_rhs(x,beta);

% time discretization
ti = 0; tf = 10*2*pi;
t = linspace(ti,tf,2000);

% initial condition
x0 = [pi+0.1; -1];

% solve dx/dt = f(t,x)
[~,X] = ode45(f,t,x0);
X = X';

% plot solution
figure('IntegerHandle','off','Position',[1500 0 800 300])
set(gcf, ...
    'defaultTextInterpreter','Latex', ...
    'defaultAxesTickLabelInterpreter','Latex', ...
    'defaultAxesFontSize',18, ...
    'defaultLineLineWidth',3, ...
    'defaultFigureColor','w')

subplot(1,2,1)
plot(X(1,:),X(2,:),'g')
xlabel('$\theta$'); ylabel('$\omega$')

subplot(1,2,2)
plot(t,X(1,:),'r')
xlabel('$t$'); ylabel('$\theta$')