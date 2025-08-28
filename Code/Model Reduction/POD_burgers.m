clearvars; close all; clc;

% Dynamics
[x,f] = burgers();

% Initial condition
q01 = rand_sine(x,10);
q02 = rand_sine(x,10);
%%

% Time discretization
m = 100;
t = linspace(0,1,m);

% solve dq/dt = f(t,q)
[~,X1] = ode45(f,t,q01);
X1 = X1';
[~,X2] = ode45(f,t,q02);
X2 = X2';

%% POD-Galerkin ROM
% POD
b = mean(X1,2);
X = X1-b;
[U,s,V] = svd([X -flipud(X)],'econ','vector');

% Select number of modes
e = cumsum(s.^2)/sum(s.^2);
% r = find(e>1-eps,1);
r = 40;
disp(r);
U = U(:,1:r);

% Build ROM
fROM = @(t,a) U'*f(t,U*a+b);

% ROM initial conditions
a01 = U'*(q01-b);
a02 = U'*(q02-b);

% Simulate ROM da/dt = f(t,a)
[~,a1] = ode45(fROM,t,a01);
a1 = a1';
[~,a2] = ode45(fROM,t,a02);
a2 = a2';

%%
figure(1)
set(gcf, ...
    'defaultTextInterpreter','Latex', ...
    'defaultAxesTickLabelInterpreter','Latex', ...
    'defaultAxesFontSize',18, ...
    'defaultLineLineWidth',1.2, ...
    'Color','w')
Z = zeros(1,m); Z = Z(1:20:end);

subplot(1,2,1)
plot(x,[Z;X1(:,1:20:end);Z],'k',...
    x,[Z;U*a1(:,1:20:end)+b;Z],'m--')
xlabel('$x$'), ylabel('$q$')
pbaspect([3 2 1])

subplot(1,2,2)
plot(x,[Z;X2(:,1:20:end);Z],'k',...
    x,[Z;U*a2(:,1:20:end)+b;Z],'m--')
xlabel('$x$'), ylabel('$q$')
pbaspect([3 2 1])

%%
figure(2)
set(gcf, ...
    'defaultTextInterpreter','Latex', ...
    'defaultAxesTickLabelInterpreter','Latex', ...
    'defaultAxesFontSize',18, ...
    'defaultLineLineWidth',1.2, ...
    'Color','w')
Z = zeros(1,m);

subplot(2,2,1)
pcolor(t,x,[Z;X1;Z]), shading interp
axis tight
colormap(redblueTecplot)
xlabel('$t$'), ylabel('$x$')
clim(0.7*[min(X1(:)),max(X1(:))])

subplot(2,2,2)
pcolor(t,x,[Z;U*a1+b;Z]), shading interp
axis tight
colormap(redblueTecplot)
xlabel('$t$'), ylabel('$x$')
clim(0.7*[min(X1(:)),max(X1(:))])

subplot(2,2,3)
pcolor(t,x,[Z;X2;Z]), shading interp
axis tight
colormap(redblueTecplot)
xlabel('$t$'), ylabel('$x$')
clim(0.7*[min(X2(:)),max(X2(:))])

subplot(2,2,4)
pcolor(t,x,[Z;U*a2+b;Z]), shading interp
axis tight
colormap(redblueTecplot)
xlabel('$t$'), ylabel('$x$')
clim(0.7*[min(X2(:)),max(X2(:))])
