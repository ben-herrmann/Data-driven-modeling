clear all, close all, clc

% Load eigenvalues
eigs_file = importdata('cylinder_eigenvalues.txt');
lambda = eigs_file.data(:,4) + i*eigs_file.data(:,5);

f1 = figure('DefaultTextInterpreter','Latex'); 

plot(imag(lambda),real(lambda),'bo','LineWidth',1.2,'MarkerFaceColor','b')
hold on
plot([-8;8],[0;0],'color',[0.5 0.5 0.5],'LineWidth',1.2)
pbaspect([1.25 1 1])
ylabel('$\lambda_r$')
xlabel('$\lambda_i$')
fontsize(18,'points'), fontname('Times')
xlim([-2.2,2.2]), ylim([-0.42,0.2])
% axis equal
hold off
pbaspect([4 2 1])
set(gcf,'Color','w')

%% Load eigenmodes
load('cylinder_eigenmodes.mat')
ny = length(y);
nx = length(x);
x_eq = reshape(x_eq,nx,ny)';
v1 = reshape(v1,nx,ny)';
v2 = reshape(v2,nx,ny)';

figure(2)
q = v2;
[xx,yy] = meshgrid(x,y);
pcolor(xx,yy,q), shading interp
axis equal, axis tight
% colorbar(), 
colormap(jet)
clim(0.5*[-max(abs(q(:))),max(abs(q(:)))])
xlim([-3,max(x)]);
xlabel('x'), ylabel('y')
fontsize(18,'points'), fontname('Times')
hold on
plot_cyl()
hold off
set(gcf,'Color','w')