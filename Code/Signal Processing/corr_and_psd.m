%%
clearvars; close all; clc;

load('kuramoto_sivashinsky.mat');
pcolor(t,x,X), shading interp, axis tight
xlabel('t'), ylabel('x')
fontsize(18,"points"), fontname('times')
colormap('bone')
%% Spatial correlation
m = length(t);
C = 1/m*(X*X');
pcolor(x,x,C),shading interp, axis equal, axis tight
xlabel('x'), ylabel('x')
fontsize(18,"points"), fontname('times')
colormap('bone')

%% Temporal correlation
n = length(x);
C = 1/n*(X'*X);
pcolor(t,t,C),shading interp, axis equal, axis tight
xlabel('t'), ylabel('t')
fontsize(18,"points"), fontname('times')
colormap('bone')

%% Spatial power spectrum

S = abs(fft(X)/sqrt(n)).^2;
L = x(n)+x(2);
k = 2*pi/L*(-n/2:n/2-1)';
k = fftshift(k);
loglog(k(k>0),2*S(k>0,:),'color',[0.8,0.8,0.8])
hold on
loglog(k(k>0),2*mean(S(k>0,:),2),'k','LineWidth',1.3)
hold off
xlabel('k'), ylabel('PSD')
fontsize(18,"points"), fontname('times')

%% Temporal power spectrum
m = length(t);
S = abs(fft(X')/sqrt(m)).^2;
T = t(n)+t(2);
w = 2*pi/T*(-m/2:m/2-1)';
w = fftshift(w);
loglog(w(w>0),2*S(w>0,:),'color',[0.8,0.8,0.8])
hold on
loglog(w(w>0),2*mean(S(w>0,:),2),'k','LineWidth',1.3)
hold off
xlabel('omega'), ylabel('PSD')
fontsize(18,"points"), fontname('times')





