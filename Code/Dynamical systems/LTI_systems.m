clear variables; close all; clc

A = [0 1;
    -1 -0.2];

B = [0;
     1];

C = [1 0];

D = 0;

sys = ss(A,B,C,D);

% Eigenvalues
[~,lambda] = eig(A,'vector');
figure(1)
plot(real(lambda),imag(lambda),'o','LineWidth',1.4)
axis equal, axis tight, axis(1.5*[-1,1,-1,1])
hold on
plot([0,0],[-2,2],'--k','LineWidth',1.2)
hold off
xlabel('Re$(\lambda)$','Interpreter','latex','FontSize',18)
ylabel('Im$(\lambda)$','Interpreter','latex','FontSize',18)

% Impulse response
figure(2)
impulse(sys)

%Frequency response
figure(3)
bode(sys)

% Arbitrary forcing
m = 500;
t = 0:m-1;
for i=1:m/20
u((i-1)*20+1:i*20) = randn(1);
end

y = lsim(sys,u,t);
figure(4)
plot(t,u,t,y)

%% Discrete-time systems

A = [0 1;
    +1 -0.01];

B = [0;
     1];

C = [1 0];

D = 0;

sys = ss(A,B,C,D);
sysd = c2d(sys,0.05);
Ad = sysd.A;

% Eigenvalues
[~,lambda] = eig(A,'vector');
[~,lambda_d] = eig(Ad,'vector');
figure(5)

subplot(1,2,1)
plot(real(lambda),imag(lambda),'o','LineWidth',1.4)
axis equal, axis tight, axis(1.5*[-1,1,-1,1])
hold on
plot([0,0],[-2,2],'--k','LineWidth',1.2)
hold off
xlabel('Re$(\lambda)$','Interpreter','latex','FontSize',18)
ylabel('Im$(\lambda)$','Interpreter','latex','FontSize',18)

subplot(1,2,2)
plot(real(lambda_d),imag(lambda_d),'o','LineWidth',1.4)
axis equal, axis tight, axis(1.5*[-1,1,-1,1])
hold on
plot(cos(0:0.1:2*pi),sin(0:0.1:2*pi),'--k','LineWidth',1.2)
hold off
xlabel('Re$(\lambda)$','Interpreter','latex','FontSize',18)
ylabel('Im$(\lambda)$','Interpreter','latex','FontSize',18)