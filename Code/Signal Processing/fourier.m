%% Fourier series expansion
clearvars; close all; clc;

n = 128;
L = 2;
x = linspace(0,1,n+1)'*L; 
x=x(1:n);
f = exp(-(x-L/2).^2/((0.05*L)^2));

k = (-n/2:n/2-1);
U = exp(1i*2*pi/L*x*k);

for j=1:n/2
    Uj = U(:,abs(k)<=j);
    Pf(:,j) = real(Uj*(Uj\f));
end

a = abs(U\Pf(:,end));

figure(1)
set(gcf, ...
    'defaultTextInterpreter','Latex', ...
    'defaultAxesTickLabelInterpreter','Latex', ...
    'defaultAxesFontSize',18, ...
    'defaultLineLineWidth',1.2, ...
    'defaultStemLineWidth',1.2, ...
    'Color','w')

for j=1:20

    subplot(1,2,1)
    plot(x,f,'k')
    hold on
    plot(x,Pf(:,j),'r')
    hold off
    ylim([min(f)-0.1,max(f)+0.1])
    xlabel('$x$'), ylabel('$f$')
    pbaspect([3 2 1])

    drawnow()

    subplot(1,2,2)
    stem(k,a,'ko-')
    hold on
    stem(k(abs(k)<=j & k>=0),a(abs(k)<=j  & k>=0),'r-o')
    hold off
    xlim([0,max(k)])
    xlabel('$k$'), ylabel('$|\hat{f}|$')
    pbaspect([3 2 1])

    pause(0.4)
    drawnow()
end


%% Parseval (fft/sqrt(n))
clearvars; close all; clc;

n = 64;
L = 2;
x = linspace(0,1,n+1)'*L; x=x(1:n);
% u = randn(n,1);
u = exp(-(x-L/2).^2/((0.15*L)^2)).*sin(8*pi*x/L);
uhat = fft(u)/sqrt(n);
k = 2*pi/L*(-n/2:n/2-1)';
k = fftshift(k);

disp(norm(u));
disp(norm(uhat));

figure(1)
set(gcf, ...
    'defaultTextInterpreter','Latex', ...
    'defaultAxesTickLabelInterpreter','Latex', ...
    'defaultAxesFontSize',18, ...
    'defaultLineLineWidth',1.2, ...
    'defaultStemLineWidth',1.2, ...
    'Color','w')
subplot(1,2,1)
plot(x,u,'k');
xlabel('$x$'), ylabel('$u$')
pbaspect([3 2 1])

subplot(1,2,2)
stem(k*L/(2*pi),abs(uhat),'k');
xlabel('$k$'), ylabel('$|\hat{u}|$')
pbaspect([3 2 1])


%% Noise filtering
clearvars; close all; clc;

n = 128;
L = 1;
x = linspace(0,1,n+1)'*L; x=x(1:n);
u = sin(3*2*pi*x/L) + cos(7*2*pi*x/L);
eta = 0.5*randn(n,1);
un = u+eta;
uhat = fft(u);
uhatn = fft(un);
uhatf = uhatn;
uhatf(abs(uhatn)<20) = 0;
uf = ifft(uhatf);

k = 2*pi/L*(-n/2:n/2-1)';
k = fftshift(k);

figure(1)
set(gcf, ...
    'defaultTextInterpreter','Latex', ...
    'defaultAxesTickLabelInterpreter','Latex', ...
    'defaultAxesFontSize',18, ...
    'defaultLineLineWidth',1.2, ...
    'defaultStemLineWidth',1.2, ...
    'Color','w')

subplot(1,2,1)
plot(x,u,'k-',x,un,'b-',x,uf,'r--');
legend('Clean','Noisy', 'Filtered')
xlabel('$x$'), ylabel('$u$')
pbaspect([3 2 1])

subplot(1,2,2)
stem(L*k/(2*pi),abs(uhat),'b');
hold on
stem(L*k/(2*pi),abs(uhatn),'b');
stem(L*k/(2*pi),abs(uhatf),'r--');
hold off
xlabel('$k$'), ylabel('$|\hat{u}|$')
pbaspect([3 2 1])


%% Image compression
clearvars; close all; clc;

photo = imread('poincare.jpg');
X = double(rgb2gray(photo));
Xhat = fft2(X);

N = numel(X);
pow_list = sort(abs(Xhat(:)),'descend');
pow_thresh = pow_list(round(0.1*N)); % 90% Compression
Xhatc = Xhat;
Xhatc(abs(Xhat)<pow_thresh) = 0;
Xc = real(ifft2(Xhatc));

subplot(2,2,1)
imagesc(X), colormap("bone"), axis equal, axis tight, axis off
subplot(2,2,2)
imagesc(log(abs(fftshift(Xhat)))), colormap("bone"), axis equal, axis tight, axis off
subplot(2,2,3)
imagesc(Xc), colormap("bone"), axis equal, axis tight, axis off
subplot(2,2,4)
imagesc(log(abs(fftshift(Xhatc)))), colormap("bone"), axis equal, axis tight, axis off
set(gcf,'Color','w')
%% Solving PDEs
clearvars; close all; clc;

% Grid and parameters
n = 64;
L = 1;
x = linspace(0,1,n+1)'*L - L/2;
x = x(1:n);
nu = 0.01; c = 0.2;

% Wavenumbers
k = 2*pi/L*(-n/2:n/2-1)';
k = fftshift(k);

% Dynamics in the Fourier domain
f = @(t,uhat) -nu*(k.^2).*uhat - c*1i*k.*uhat;

% Initial condition
u0 = exp(-x.^2/((0.1*L)^2));
u0hat = fft(u0);
% plot(x,u0)

% Time discretization
m = 100;
t = linspace(0,1,m);

% Solve PDE du/dt = f(t,u)
[~,Xhat] = ode45(f,t,u0hat);
X = real(ifft(Xhat'));

% Plot result
set(gcf, ...
    'defaultTextInterpreter','Latex', ...
    'defaultAxesTickLabelInterpreter','Latex', ...
    'defaultAxesFontSize',18, ...
    'defaultLineLineWidth',1.2, ...
    'Color','w')
pcolor(t,x,X), shading interp
axis tight
colormap(redblueTecplot)
xlabel('$t$'), ylabel('$x$')
clim(0.9*[min(X(:)),max(X(:))])
pbaspect([3 2 1])