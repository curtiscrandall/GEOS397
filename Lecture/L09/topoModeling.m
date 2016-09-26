function zChange = topoModeling(z, kappa, dt, dx, tMax)
% Example Use
% zChange = topoModeling(z, kappa, dt, dx, tMax);
% z = [0 0 0 0 0 1 2 3 4 5 6 7 8 9 10 9 8 7 6 5 4 3 2 1 0 0 0 0 0];
% dt = 1;
% dx = 1;
% kappa = 2e-3;
% tMax = 1000;

% Step 2: Make the initial model
nNode = numel( z ); % [No] number of elements in the x-direction
t0 = dt; % time steps
% Inside this second for loop, insert your finite difference equation
zChange = zeros (nNode,tMax); % change in elevation for figure
zChange (:,1) = z;
for it = t0 + dt : dt : tMax;
    for ix = 2 : nNode -1;
        zChange (ix, it) = dt * kappa * ((zChange (ix + 1 , it - 1 ) - 2 * (zChange(ix , it - 1 )) + zChange( ix - 1 , it-1))/(dx^2)) + zChange( ix , it - 1);
    end 
end
return