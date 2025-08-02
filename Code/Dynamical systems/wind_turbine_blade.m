clearvars; close all; clc

% Geometry
geo = importGeometry('NREL5MW_Blade.stl');

figure(1)
pdegplot(geo,"FaceLabels","on",'FaceAlpha',0.3)

%% Mesh
model = createpde('structural','modal-solid');
model.Geometry = geo;

h = 0.05;
msh = generateMesh(model,'Hmin',h);
figure(2)
pdemesh(msh)
set(gcf,'Color','w')

%% Modal analysis
E   = 30e9;       % Young's modulus (Pa)
nu  = 0.3;        % Poisson's ratio
rho = 2000*0.3;  % Density (kg/m^3) (adjusted for solid body)

structuralProperties(model,'YoungsModulus',E,...
                             'PoissonsRatio',nu,...
                             'MassDensity',rho);
structuralBC(model,'Face',3,'Constraint','fixed');

sol = solve(model,FrequencyRange = [0 200]);
lambda = 1i*sol.NaturalFrequencies;
f = imag(lambda)/(2*pi);
Phi = sqrt((sol.ModeShapes.ux).^2 + (sol.ModeShapes.uy).^2 + (sol.ModeShapes.uz).^2);
%%
disp('Natural frequencies (Hz):')
disp(f)

modes = [1,3,7,13,14];
figure(3)
for i=1:5
        subplot(5,1,i)
        k = modes(i);
        pdeplot3D(model,'ColorMapData',Phi(:,k),'Mesh','off')
        clim([0,0.015])
        delete(findobj(gca,'type','Text')); 
        delete(findobj(gca,'type','Quiver'));
        colorbar('off')
end
set(gcf,"Color",'w')


