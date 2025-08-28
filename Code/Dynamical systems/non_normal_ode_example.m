clear variables; close all; clc
addpath('../src'); % Add the source files to the path

% build A matrix and integration weights
mu = 100.0;
A = [-1 mu 0; 0 -2 mu; 0 0 -mu];
% A = [-0.75 1; -0.3 -0.75];
n = size(A,1);
I = eye(n);
sys = ss(A,I,I,0);

%
Wo = gram(sys,'o');
[Vwo,Lambda] = eig(Wo);
lambda = diag(Lambda);
[~,p] = sort(-real(lambda));
Vwo = Vwo(:,p)

Wc = gram(sys,'c');
[Vwc,Lambda] = eig(Wc);
lambda = diag(Lambda);
[~,p] = sort(-real(lambda));
lambda(p);
Vwc = Vwc(:,p);

%
[~,~,Ti,T] = balreal(sys);
Vba = Ti'; Vbd = T;
Vba./vecnorm(Vba)
% vba = Vba(:,2)/norm(Vba(:,2));
% vbd = Vbd(:,1)/norm(Vbd(:,1));

% figure(1); lw=2;
% plot3([0,-vwo(1)],[0,-vwo(2)],[0,-vwo(3)],'b','linewidth',lw)
% hold on; grid on
% plot3([0,vwc(1)],[0,vwc(2)],[0,vwc(3)],'r','linewidth',lw)
% plot3([0,vba(1)],[0,vba(2)],[0,vba(3)],'g--','linewidth',lw)
% plot3([0,vbd(1)],[0,vbd(2)],[0,vbd(3)],'y--','linewidth',lw)
% axis equal
% hold off

%
t = (0:0.01:8);
m = length(t);
[X_delta,~]=impulse(sys,t');

p = 1;
sys_wo = ss(A,Vwo(:,1:p)*Vwo(:,1:p)',I,0);
[X_wo,~]=impulse(sys_wo,t');

sys_ba = ss(A,(Vba(:,1:p)/(Vba(:,1:p)'*Vba(:,1:p)))*Vba(:,1:p)',I,0);
[X_ba,~]=impulse(sys_ba,t');
%%
figure(1)
for i=1:n
subplot(1,n,i)
plot(t,vecnorm(X_delta(:,:,i)'),'k')
% hold on
% plot(t,vecnorm(X_wo(:,:,i)'),'b-')
% plot(t,vecnorm(X_ba(:,:,i)'),'r--')
% hold off
end

