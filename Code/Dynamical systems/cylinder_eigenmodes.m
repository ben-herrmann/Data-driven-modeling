clear all, close all, clc

% Load eigenvalues
eigs_file = importdata('../data/cylinder_flow/eigenvalues.txt');
lambda = eigs_file.data(:,4) + i*eigs_file.data(:,5);

for mode=1:30

file_prefix = '/Users/benherrmann/KTH_Framework/run/ext_cyl_ARN/egvext_cyl0.f';
filename = [file_prefix num2str(mode,'%05.f')];
x = load_nek_field(filename,1);
y = load_nek_field(filename,2);
q = load_nek_field(filename,4);
l = 0.7;
clims = [-l*max(abs(q)), l*max(abs(q))];

f1 = figure('DefaultTextInterpreter','Latex'); set(f1,'Position',[-1200 1000 750 200])

subplot(1,21,[1,5])
plot(imag(lambda),real(lambda),'bo')%,'MarkerSize',12)
hold on
plot(imag(lambda(mode)),real(lambda(mode)),'rx','MarkerSize',12)
plot([-8;8],[0;0],'color',[0.5 0.5 0.5])
pbaspect([1.25 1 1])
ylabel('$\lambda_r$')
xlabel('$\lambda_i$')
axis([-2.2,2.2 -0.42,0.2])
hold off

subplot(1,21,[8,21])
plotCylinder_nek(x,y,q,clims);

print(f1,['../plots/cyl_100_global_modes/mode_' num2str(mode,'%02.f')],'-depsc')

end




