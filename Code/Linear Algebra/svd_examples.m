%% Dominant subspaces

clearvars; close all; clc;
load('teapot.mat');

[U,S,~] = svd(M,'econ');
disp(S);

vectors(3*U)
hold on
scatter3(M(1,:),M(2,:),M(3,:),'.')

P = U(:,1:2)*U(:,1:2)';
PM = P*M;
scatter3(PM(1,:),PM(2,:),PM(3,:),'.')
hold off

%% Matrix approximation

clearvars; close all; clc;
photo = imread('poincare.jpg');
A = double(rgb2gray(photo));

[U,S,V] = svd(A,'econ');
s = diag(S);
var = cumsum(s.^2)/sum(s.^2);

k = 10;
Ak = U(:,1:k)*S(1:k,1:k)*V(:,1:k)';
subplot(2,2,1)
imagesc(A), colormap("bone"), axis equal, axis tight
subplot(2,2,2)
imagesc(Ak), colormap("bone"), axis equal, axis tight
subplot(2,2,3)
semilogy(s,'ok','MarkerFaceColor','k','MarkerSize',2)
hold on
semilogy([k],[s(k)],'om','MarkerFaceColor','m','MarkerSize',3)
pbaspect([2.4 2 1])
hold off
xlabel('Rank')
ylabel('Singular value')
subplot(2,2,4)
plot(var,'ok','MarkerFaceColor','k','MarkerSize',2)
hold on
plot([k],[var(k)],'om','MarkerFaceColor','m','MarkerSize',3)
xlim([0,40])
ylabel('Variance')
xlabel('Rank')
pbaspect([2.4 2 1])

hold off

%% Eigenpets

clearvars; close all; clc;
load('eigenpets.mat')
n = 64;
imagesc(reshape(C(:,10),n,n))
colormap("bone"), axis equal, axis tight

%%
[U,S,V] = svd([C D],"econ");
[Uc,Sc,Vc] = svd(C,"econ");
[Ud,Sd,Vd] = svd(D,"econ");

figure(1)
semilogy(diag(S),'k.');
hold on
semilogy(diag(Sc),'r.');
semilogy(diag(Sd),'b.');
hold off
axis tight
xlabel('Rank')
ylabel('Singular value')
xlim([1,79])

%%
k=4;

figure(2)
subplot(1,3,1)
imagesc(reshape(U(:,k),n,n)), colormap("bone"), axis equal, axis tight

subplot(1,3,2)
imagesc(reshape(Uc(:,k),n,n)), colormap("bone"), axis equal, axis tight

subplot(1,3,3)
imagesc(reshape(Ud(:,k),n,n)), colormap("bone"), axis equal, axis tight

%%
figure(3)
bar(U(:,2)'*[C D])
xlabel('column index')
ylabel('alignment with u')