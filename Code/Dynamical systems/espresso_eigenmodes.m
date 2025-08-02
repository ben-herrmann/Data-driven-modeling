clear variables; close all; clc

% Geometry
geo = importGeometry('espresso.step');
geo = rotate(geo,90,[0,0,0],[1,0,0]);
figure(1)
pdegplot(geo,"FaceLabels","on",'FaceAlpha',0.3)

% Mesh
model = createpde("thermal","modal");
model.Geometry = geo;
h = 0.005;
msh = generateMesh(model,'Hmin',h,'Hmax',h);
figure(2)
pdemesh(msh)

%%
% Material properties
k = 3; % (W/mK)
rho = 2000; % (kg/m3)
Cp = 500; % (J/kgK)
model.thermalProperties('ThermalConductivity',k, ...
    "MassDensity",rho,"SpecificHeat",Cp);

% Boundary conditions
thermalBC(model,'Face',[1,3],'HeatFlux',0); % bottom
thermalBC(model,'Face',[5,10], ...
    'ConvectionCoefficient',100,'AmbientTemperature',80); % interior (coffee)
thermalBC(model,'Face',[2,4,6,7,8,9], ...
    'ConvectionCoefficient',15,'AmbientTemperature',20); % exterior (air)

% Perform modal analysis
sol = solve(model,'DecayRange',[0,1]);
Phi = sol.ModeShapes;
lambda = -sol.DecayRates;
figure(3)
for i=1:4
    for j=1:4
        k = (j-1)*4+i;
        subplot(4,4,k)
        pdeplot3D(model,'ColorMapData',Phi(:,k),'Mesh','on')
        delete(findobj(gca,'type','Text')); 
        delete(findobj(gca,'type','Quiver'));
        % camlight
        colorbar('off')
    end
end
set(gcf,"Color",'w')
