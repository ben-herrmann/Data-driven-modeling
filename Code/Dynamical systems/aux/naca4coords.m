function coords = naca4coords(t, nPoints)
% Generates symmetric NACA 00XX profile
% t: thickness percentage (e.g., 12 = 12%)
% nPoints: number of points along airfoil (upper+lower combined)

t = t/100;  % convert to fraction
x = linspace(0,1,nPoints)';     % chordwise points
yt = 5*t*(0.2969*sqrt(x) - 0.1260*x - 0.3516*x.^2 + 0.2843*x.^3 - 0.1015*x.^4);

% Upper/lower surfaces
xu = x;  yu = yt;
xl = x;  yl = -yt;

% Combine into closed curve (upper reversed)
coords = [flipud(xu), flipud(yu); xl(2:end), yl(2:end)];
end
