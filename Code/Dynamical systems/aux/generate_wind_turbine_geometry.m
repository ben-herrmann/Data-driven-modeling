%% generate_NREL5MW_blade_STL_blended_oriented.m
% Generates NREL 5-MW blade STL using blended NACA airfoils
% Oriented: X = span, Y = leading edge, Z = thickness

clear; clc;

%% 1. Blade data (NREL 5-MW reference)
r = [2.8 5.6 8.4 11.2 14.0 16.8 19.6 22.4 25.2 28.0 30.8 33.6 36.4 39.2 ...
     42.0 44.8 47.6 50.4 53.2 56.0 58.8 61.5];
chord = [3.542 3.854 4.167 4.557 4.652 4.458 4.249 4.007 3.748 3.502 3.256 ...
         3.010 2.764 2.518 2.273 2.027 1.781 1.535 1.289 1.043 0.797 0.724];
twist = [13.308 13.308 13.308 13.308 11.480 10.162 8.845 7.529 6.212 4.895 ...
         3.579 2.262 1.132 0.567 0 0 0 0 0 0 0 0];

%% 2. Thickness profile (blend 30% → 12% → 6%)
thicknessRoot = 30;   % 30% at hub
thicknessMid  = 12;   % 12% mid-span
thicknessTip  = 6;    % 6% at tip

midRadius = 0.6 * max(r);  % transition point at 60% span

thicknessDist = zeros(size(r));
for i = 1:length(r)
    if r(i) <= midRadius
        thicknessDist(i) = thicknessRoot - (thicknessRoot-thicknessMid)*(r(i)/midRadius);
    else
        thicknessDist(i) = thicknessMid - (thicknessMid-thicknessTip)*((r(i)-midRadius)/(max(r)-midRadius));
    end
end

%% 3. Discretization
nSections = length(r);
nPoints = 50;  % airfoil resolution

X = []; Y = []; Z = [];

for i = 1:nSections
    % Generate symmetric NACA profile for given thickness
    airfoil = naca4coords(thicknessDist(i), nPoints);

    % Scale airfoil to actual chord
    airfoil(:,1) = airfoil(:,1) * chord(i);
    airfoil(:,2) = airfoil(:,2) * chord(i);

    % Apply twist (about chord)
    R_twist = [cosd(twist(i)) -sind(twist(i)); sind(twist(i)) cosd(twist(i))];
    xy = (R_twist * airfoil')';

    % Rotate so LE faces +Y (−90° about Z)
    R_le = [cosd(-90) -sind(-90); sind(-90) cosd(-90)];
    xy = (R_le * xy')';

    % Append spanwise coordinate (Z axis → span before final rotation)
    X = [X; xy(:,1)];
    Y = [Y; xy(:,2)];
    Z = [Z; r(i)*ones(size(xy,1),1)];
end

%% 4. Remove duplicate points
pts = unique([X Y Z],'rows','stable');

%% 5. Create manifold solid via alphaShape
alpha = 2.0; 
shp = alphaShape(pts(:,1), pts(:,2), pts(:,3), alpha);
shp.HoleThreshold = 1e6;

[faces, vertices] = boundaryFacets(shp);

%% 6. Rotate entire blade so span aligns with X axis
% Convert span (Z) → X
R_span = [0 0 1; 0 1 0; -1 0 0];
vertices = (R_span * vertices')';

%% 7. Export STL
TR = triangulation(faces, vertices);
stlwrite(TR,'NREL5MW_Blade.stl');
disp('Saved: NREL5MW_Blade.stl');

%% 8. Visualize
figure
trisurf(faces,vertices(:,1),vertices(:,2),vertices(:,3), ...
    'FaceColor',[0.8 0.8 1],'EdgeColor','none');
axis equal
xlabel('X (span)'); ylabel('Y (chord - LE)'); zlabel('Z (thickness)');
title('NREL 5-MW Blade (Blended Airfoils, Oriented)')
view(45,20)
