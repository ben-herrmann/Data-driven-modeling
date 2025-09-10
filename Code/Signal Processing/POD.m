%% Load cylinder flow data
clearvars; close all; clc;

load('cylinder_flow.mat');
q0 = mean(X,2);
X = X - q0;
nx = length(x); ny = length(y);

%% Animate field

m = size(X,2);
for i=1:m
q = X(:,i);
pcolor(reshape(q+q0,ny,nx))
shading interp, axis equal, axis tight, axis off
colormap('jet')
colorbar()
clim(0.4*[-max(abs(X(:,1))),max(abs(X(:,1)))])
drawnow()

end

%% POD

W = speye(n); F = sqrt(W);
[U,s,V] = svd(F*X,'econ','vector');
e = cumsum(s.^2)/sum(s.^2);
r = find(e>0.999,1);

figure(1)
semilogy(1:m-1,s(1:m-1),'ko',[r],[s(r)],'ro')

Phi = F\U(:,1:r);
a = diag(s(1:r))*V(1:m,1:r)';

figure(2)
for i=1:9
q = Phi(:,i);
subplot(3,3,i)
pcolor(reshape(q,ny,nx)), shading interp, axis equal, axis tight, axis off
colormap('jet')
clim(0.5*[-max(abs(q)),max(abs(q))])

end

%% Animate projected field

m = size(X,2);
figure(3)
for i=1:m

subplot(1,2,1)
q = X(:,i);
pcolor(reshape(q+q0,ny,nx)), shading interp, axis equal, axis tight, axis off
colormap('jet')
clim(0.3*[-max(abs(X(:,1))),max(abs(X(:,1)))])

subplot(1,2,2)
q = Phi*a(:,i);
pcolor(reshape(q+q0,ny,nx)), shading interp, axis equal, axis tight, axis off
colormap('jet')
clim(0.3*[-max(abs(X(:,1))),max(abs(X(:,1)))])

drawnow()

end

%% Load wake data
clearvars; close all; clc;

load('wake.mat');
[n,m] = size(X);
q0 = mean(X,2);
X = X - q0;

%% Animate field

m = size(X,2);
for i=1:m
q = X(:,i);
pcolor(reshape(q+q0,ny,nx))
shading interp, axis equal, axis tight, axis off
colormap('jet')
colorbar()
clim(0.5*[-max(abs(X(:,1))),max(abs(X(:,1)))])
drawnow()

end

%% POD

W = speye(n); F = sqrt(W);
[U,s,V] = svd(F*X,'econ','vector');
e = cumsum(s.^2)/sum(s.^2);
r = find(e>0.2,1);

figure(1)
semilogy(1:100,s(1:100),'ko',[r],[s(r)],'ro')

Phi = F\U(:,1:r);
a = diag(s(1:r))*V(:,1:r)';

figure(2)
for i=1:9
q = Phi(:,i);
subplot(3,3,i)
pcolor(reshape(q,ny,nx)), shading interp, axis equal, axis tight, axis off
colormap('jet')
clim(0.5*[-max(abs(q)),max(abs(q))])

end

%% Animate projected field

m = size(X,2);
figure(3)
for i=1:m

subplot(1,2,1)
q = X(:,i);
pcolor(reshape(q+q0,ny,nx)), shading interp, axis equal, axis tight, axis off
colormap('jet')
clim(0.3*[-max(abs(X(:,1))),max(abs(X(:,1)))])

subplot(1,2,2)
q = Phi*a(:,i);
pcolor(reshape(q+q0,ny,nx)), shading interp, axis equal, axis tight, axis off
colormap('jet')
clim(0.3*[-max(abs(X(:,1))),max(abs(X(:,1)))])

drawnow()

end

%% Load K-S data
clearvars; close all; clc;

load('kuramoto_sivashinsky.mat');
[n,m] = size(X);
pcolor(t,x,X), shading interp, axis tight
xlabel('t'), ylabel('x')
fontsize(18,"points"), fontname('times')
colormap('jet')

%% POD

W = speye(n); F = sqrt(W);
[U,s,V] = svd(F*[X -flipud(X)],'econ','vector');
e = cumsum(s.^2)/sum(s.^2);
r = find(e>0.999,1);

figure(1)
semilogy(1:100,s(1:100),'ko',[r],[s(r)],'ro')

Phi = F\U(:,1:r);
a = diag(s(1:r))*V(1:m,1:r)';

figure(2)
for i=1:9
q = Phi(:,i);
subplot(3,3,i)
plot(x,q,'k','LineWidth',1.2)
clim(0.5*[-max(abs(q)),max(abs(q))])

end

%% Plot projected data

figure(3)
subplot(2,1,1)
pcolor(t,x,X), shading interp, axis tight, axis off
colormap('jet')

subplot(2,1,2);
pcolor(t,x,Phi*a), shading interp, axis tight, axis off
colormap('jet')