clearvars; close all; clc;

load('wake.mat');

%% Animate field

m = size(X,2);
for i=1:m
q = X(:,i);
pcolor(reshape(q,ny,nx)), shading interp, axis equal, axis tight
colormap('jet')
colorbar()
clim(0.5*[-max(abs(X(:,1))),max(abs(X(:,1)))])
drawnow()

end

%% Mean

qbar = mean(X,2);

pcolor(reshape(qbar,ny,nx)), shading interp, axis equal, axis tight
colormap('jet')
colorbar()
clim(0.2*[-max(abs(qbar)),max(abs(qbar))])

%% Variance

qvar = mean((X-qbar).*(X-qbar),2);
pcolor(reshape(qvar,ny,nx)), shading interp, axis equal, axis tight
colormap('jet')
colorbar()
clim(0.8*[0,max(abs(qvar))])

%% Animate fluctuations

m = size(X,2);
for i=1:m
q = X(:,i)-qbar;
pcolor(reshape(q,ny,nx)), shading interp, axis equal, axis tight, axis off
colormap('jet')
colorbar()
clim(2*[-max(sqrt(qvar)),max(abs(sqrt(qvar)))])
drawnow()

end

%% Autocorrelation

for tau=0:30
% tau = 10;
figure(1)
qcorr = mean((X(:,1:m-tau)-qbar).*(X(:,tau+1:m)-qbar),2);
pcolor(reshape(qcorr,ny,nx)), shading interp, axis equal, axis tight
colormap('jet')
colorbar()
clim(0.8*[0,max(abs(qcorr))])
drawnow()
pause(0.3);
end
