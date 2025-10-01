clear variables; close all; clc

n = 15;
x = linspace(-1,1,n);
y = x;
[X,Y] = meshgrid(x,y);
U = Y;
V = -0.1*Y - X;

figure(1)
set(gcf, ...
    'defaultTextInterpreter','Latex', ...
    'defaultAxesTickLabelInterpreter','Latex', ...
    'defaultAxesFontSize',18, ...
    'defaultLineLineWidth',3, ...
    'defaultFigureColor','w')
quiver(X,Y,U,V,'k'), axis tight, axis equal
xlabel('$x$'), ylabel('$\dot{x}$')

%%

n = 10;
x = 1.2*linspace(-1,1,n);
y = x;
[X,Y] = meshgrid(x,y);
U = Y;
V = -Y + X - X.^3;

figure(1)
set(gcf, ...
    'defaultTextInterpreter','Latex', ...
    'defaultAxesTickLabelInterpreter','Latex', ...
    'defaultAxesFontSize',18, ...
    'defaultFigureColor','w')
quiver(X,Y,U,V,'LineWidth',1.3), axis tight, axis equal
xlabel('$x$'), ylabel('$\dot{x}$')