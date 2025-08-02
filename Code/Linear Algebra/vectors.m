function vectors(v, varargin)

v0 = 0*v;

% Plot single 3D arrow
quiver3(...
    v0(1,:), v0(2,:), v0(3,:), ... % origin
    v(1,:), v(2,:), v(3,:), ...    % vector components
    0, ...                   % scale (0 disables scaling)
    'MaxHeadSize', 0.3, ...  % approximate equivalent to tiplength/markerscale
    'LineWidth', 1.5,...
    varargin{:} ...
    );
axis equal, hold on
end

% function vectors(V, varargin)
% 
% n = size(V, 2);
% for i = 1:n
%     vector(V(:, i), varargin{:});
% end
% end