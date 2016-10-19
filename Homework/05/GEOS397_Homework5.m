%% Homework 5: Seafloor subsidence due to cooling
% Partners: Paige Roban and Curtis Crandall
%
%% Part 1: Conductive heat flow
%% Step 1: A model
% Imagine an infinitely long and wide solid plate. The plate has thickness
% d. The temperature at the top of the plate is T1 and the temperature at
% the bottom of the plate is T2. Draw a diagram of this plate and label
% these parameters. 

%           T1                T1
%   ____________________________________   
%  |                                    |  ?
%  |                                    |  |
%  |                                    |  d = thickness
%  |                                    |  |
%  |____________________________________|  ? 
%           T2                T2

%% Step 2: Heat flow
% Assuming that T2>T1, the rate of change of heat flow per unit area up
% through the plate is proportional to (T2-T1)/d. 
% 
% In fact the rate of heat flow per unit area (Q) down through the plate is
% Q = -k(T2-T1)/d,
% where is k is called the thermal conductivity. Q is the rate of heat flow
% per unit area and has units Wm^-2; k has units Wm^-1C^-1. 
% Why does the heat flow down in this equation?

% Heatflow is negative because we are losing heat as we are moving away 
% from the source.
% If heatflow were positive, heat would be gained as it mvoes away from
% the source.
%% Step 3: Thermal conductivities 
% Give the values of thermal conductivity for the following items. Make
% sure to cite where you found this value and make sure the units are in
% the SI units given in step 2.

% Silver: 406.0 (W/mK)
% Magnesium:156 (W/mK)
% Glass:0.8 (W/mK)
% Rock:2-7 (W/mK)
% Wood:0.12-0.04 (W/mK)
% Sources used to determine thermal conductivity:
% http://hyperphysics.phy-astr.gsu.edu/hbase/tables/thrcn.html and 
% http://www.engineeringtoolbox.com/thermal-conductivity-d_429.html
%% Step 4: The heat transport equation 
% Let's assume that the temperature of the upper surface(i.e. at z) is T
% and at the temperature at the lower surface (i.e. z+Sz) is T+ST. Substitute these values
% into equation 1 (Think about how to replace d, T1, and T2). 

% In the limit that Sz goes to zero, some part of the right-hand side of
% your new equation becomes a derivative. 

% Write this derivative. 

% Write the heat flow using this derivative. 
%% Step 5: The conservation equation

% Use the heat transport equation and compute the derivative dQ/dz and
% insert this into the conservation equation. 

% Assume that internal heat generation is zero, write the updated the
% conservation equation from the previous step. 

% What is the value of kappa in this case? 

%% Part 2: Oceanic lithosphere cooling 

%% Step 1: Setup the model domain and compute
%% Nested for loop with erf function
tic
z = 1:100;
t = 1:100;
k = 31.556;
To = 640;
T1 = [];

for ii = 1:length(z);
    for jj = 1:length(t);
        T1(ii,jj) = To.*erf((ii)./(2*sqrt(k.*(jj))));
    end
end

figure(1);clf 
imagesc(T1);
xlabel('Time [Ma]');
ylabel('Depth [km]');
c = colorbar;
c.Label.String = 'Temperature [C]'
colormap(jet)
toc
%% Nested for loop with erf function and Meshgrid
tic
[X,Y] = meshgrid(z,t);
T1 = [];

for ii = 1:length(X);
    for jj = 1:length(Y);
        T1(ii,jj) = To.*erf((ii)./(2*sqrt(k.*(jj))));
    end
end
figure(2); clf
imagesc(T1);
xlabel('Time [Ma]');
ylabel('Depth [km]');
c = colorbar;
c.Label.String = 'Temperature [C]'
colormap(jet) 
toc
% 1. Use two for loops to compute the function T(z,t). 
% 2. Use the meshgrid() command to setup matrices for z and t and then
% compute the function T(z,t). 

% Extra credit: Time how long it takes to compute T(z,t) using the two
% methods. If you don't notice a difference, try decreasing the sample
% interval in z and t. Discuss the differences in computation time. 

% The first figure took 1.343534 seconds to run on TREX. The second figure
% takes 0.447624 seconds to run. 

%% Step 2: Analyze the model output

% Answer the following questions in as much detail as possible. 

% * Does your model make sense given the boundary conditions used to derive
% the solution? 
% * What controls the rate at which the temperature decays? 
% * How could we convert this model from age to distance from ridge axis? 
% * What would be a more appropriate boundary condition at T(z=0) given
% what we know abot the oceans? 
% * Is 640C an appropriate value for the temperature at a mid-ocean ridge?
% Why or why not? 

%% Part 3: Plate velocty and the depth of oceans
%% Step 1: Load and plot sea-floor depth data
% Load the file spreadingData.mat in MATLAB. This will load the structure
% Bath. 
load('spreadingData.mat');
% These data are for the Pacific and Atlantic Oceans. The fields that end
% in z are the ocean depths [m] measured along a profile normal to a
% mid-ocean ridge. The fields that end in x are the distance [km] from the
% ridge where the data were collected. Plot depth vs. distance from the
% ridge; plot each ocean in its own subplot. make sure to label axes. 

figure(3);clf
subplot(2,1,1);
load('spreadingData.mat');
plot(extractfield(Bath,'atlanticx'),(extractfield(Bath,'atlanticz')));
xlabel('Distance [km]')
ylabel('Depth [m]')
title('Atlantic Mid-Ocean Ridge')

subplot(2,1,2);
plot(extractfield(Bath,'pacificx'),(extractfield(Bath,'pacificz')));
xlabel('Distance [km]')
ylabel('Depth [m]')
title('Pacific Mid-Ocean Ridge')

% What does 2.65 represent in the equation (3)?

% It is an offset of the ridge axis depth.

%What are the plate veolocities [km/Ma] that match your data the closest?
%List both oceans.



% Convert these plate veolocities to [cm/yr] and compare with an estimate
% from the literatur from these ocean basins. Do your estimates agree with
% published Pacific and Atlantic Ocean spreading rates? 

%% Step 2: A half-space model
% 
atlanticT = ((extractfield(Bath,'atlanticz')-2.65)/0.345).^2; 
pacificT = ((extractfield(Bath,'pacificz')-2.65)/0.345).^2;

atlanticV = (extractfield(Bath,'atlanticx')./atlanticT);
pacificV = (extractfield(Bath,'pacificx')./pacificT);

figure(4);clf
subplot(2,2,1);
load('spreadingData.mat');
plot(extractfield(Bath,'atlanticx'),(extractfield(Bath,'atlanticz')));
xlabel('Distance [km]')
ylabel('Depth [m]')
title('Atlantic Mid-Ocean Ridge')

subplot(2,2,2);
plot(extractfield(Bath,'pacificx'),(extractfield(Bath,'pacificz')));
xlabel('Distance [km]')
ylabel('Depth [m]')
title('Pacific Mid-Ocean Ridge')

subplot(2,2,3);
load('spreadingData.mat');
plot(atlanticT,(extractfield(Bath,'atlanticz')));
xlabel('Time [Ma]')
ylabel('Depth [m]')
title('Atlantic Mid-Ocean Ridge')

subplot(2,2,4);
plot(pacificT,(extractfield(Bath,'pacificz')));
xlabel('Time [Ma]')
ylabel('Depth [m]')
title('Pacific Mid-Ocean Ridge')
%% Part 4: Global oceanic plate ages
%% Step 1: Load topo data and plot sea-floor depths

load('topo'); % Load global topography
load('coastlines'); % load coastlines
[platelat,platelon] = importPlates('All_boundaries.txt');

h = figure(5);
h.InvertHardcopy = 'off'; % ensures color of saved fig. matches display
h.Color = 'k'; % (1 pt.) % changes fig. color to black
h.Position = [100 100 1000 500]; % specifies location/size of fig's drawable area
h.PaperPositionMode = 'auto'; % preserves fig's aspect ratio when printing
% setup the map axes
ax = axesm('Mollweid','Frame', 'on', 'Grid', 'on'); % sets map projection, inserts globe outline, inserts grid
setm(ax,'MLabelLocation',60); % sets lon. labels to every 60 degrees
setm(ax,'PLabelLocation',30); % sets lat. labels to every 30 degrees
mlabel('MLabelParallel',0); % sets lon. label location to the equator
plabel('PLabelMeridian',-25); % sets lat. label location to prime meridian
axis('off'); % prevents axes display
setm(ax,'FontColor',[0.9 0.9 0.9]); % brightens text
setm(ax,'GColor',[0.9 0.9 0.9]); % brightens grid
LAT = topolatlim(1):topolatlim(2);
LON =  topolonlim(1):topolonlim(2);
[lon, lat] = meshgrid(LON,LAT); % compute the lat/lon of every grid point in topo
pcolorm(lat,lon,topo); % plot the matrix of elevations on the map
hold on;
demcmap(topo); % give it a better colormap
c = colorbar; %
c = colorbar('color', [0.9 0.9 0.9]); % changes text color on color bar
c.Label.String = 'Elevation [M]';
plotm(coastlat, coastlon, 'w', 'LineWidth', 0.5); %plots coast lines
plotm(platelat,platelon,'k', 'LineWidth', 1.5); % plots plate boundaries

%% Kill the queen
[iy, ix] = find(topo > 0);

ocean = topo; % creates another matrix to hold values from the forloop

% for loop finds values of elevations that are negative
for ii = 1 : size( ix, 1 )
    ocean( iy(ii), ix(ii) ) = 0;
end 

ocean = ocean.*-1e-3; % creates ocean depths, converts units, makes them positive

h = figure(6);
h.InvertHardcopy = 'off'; % ensures color of saved fig. matches display
h.Color = 'k'; % (1 pt.) % changes fig. color to black
h.Position = [100 100 1000 500]; % specifies location/size of fig's drawable area
h.PaperPositionMode = 'auto'; % preserves fig's aspect ratio when printing
% setup the map axes
ax = axesm('Mollweid','Frame', 'on', 'Grid', 'on'); % sets map projection, inserts globe outline, inserts grid
setm(ax,'MLabelLocation',60); % sets lon. labels to every 60 degrees
setm(ax,'PLabelLocation',30); % sets lat. labels to every 30 degrees
mlabel('MLabelParallel',0); % sets lon. label location to the equator
plabel('PLabelMeridian',-25); % sets lat. label location to prime meridian
axis('off'); % prevents axes display
setm(ax,'FontColor',[0.9 0.9 0.9]); % brightens text
setm(ax,'GColor',[0.9 0.9 0.9]); % brightens grid
LAT = topolatlim(1):topolatlim(2);
LON =  topolonlim(1):topolonlim(2);
[lon, lat] = meshgrid(LON,LAT); % compute the lat/lon of every grid point in topo
pcolorm(lat,lon,ocean); % plot the matrix of elevations on the map
hold on;
demcmap(ocean); % give it a better colormap
c = colorbar; %
c = colorbar('color', [0.9 0.9 0.9]); % changes text color on color bar
c.Label.String = 'Elevation [km]';
plotm(coastlat, coastlon, 'w', 'LineWidth', 0.5); %plots coast lines
plotm(platelat,platelon,'k', 'LineWidth', 1.5); % plots plate boundaries
colormap(flipud(jet(20))); %Flipud inverts the array of colors on the colormap and adds 20 increments of color scale

%% Step 3 Compute sea-floor age
d = ocean; % resaves matrix to hold values of depth for later
% for loop finds values of elevations that are negative
t = zeros(size(d));
for ii = 1:size(d)
    for jj = 1:length(d)
        t(ii,jj) = (((d(ii,jj) - 2.65)/0.345))^2;
    end
    t(t==59.000210039907586)=-10;
end 

h = figure(7);
h.InvertHardcopy = 'off'; % ensures color of saved fig. matches display
h.Color = 'k'; % (1 pt.) % changes fig. color to black
h.Position = [100 100 1000 500]; % specifies location/size of fig's drawable area
h.PaperPositionMode = 'auto'; % preserves fig's aspect ratio when printing
% setup the map axes
ax = axesm('Mollweid','Frame', 'on', 'Grid', 'on'); % sets map projection, inserts globe outline, inserts grid
setm(ax,'MLabelLocation',60); % sets lon. labels to every 60 degrees
setm(ax,'PLabelLocation',30); % sets lat. labels to every 30 degrees
mlabel('MLabelParallel',0); % sets lon. label location to the equator
plabel('PLabelMeridian',-25); % sets lat. label location to prime meridian
axis('off'); % prevents axes display
setm(ax,'FontColor',[0.9 0.9 0.9]); % brightens text
setm(ax,'GColor',[0.9 0.9 0.9]); % brightens grid
LAT = topolatlim(1):topolatlim(2);
LON =  topolonlim(1):topolonlim(2);
[lon, lat] = meshgrid(LON,LAT); % compute the lat/lon of every grid point in topo
pcolorm(lat,lon,t); % plot the matrix of elevations on the map
hold on;
c = colorbar; %
c = colorbar('color', [0.9 0.9 0.9]); % changes text color on color bar
c.Label.String = 'Age[Ma]';
plotm(coastlat, coastlon, 'w', 'LineWidth', 0.5); %plots coast lines
plotm(platelat,platelon,'k', 'LineWidth', 1.5); % plots plate boundaries
cmap=(flipud(jet(20))); % Initializes color map as a variable (cmap) so later strings can be input to change plotting conditions.
% Flipud inverts the array of colors on the colormap and adds 20 increments of color scale
cmap = [0.5 0.5 0.5 ; cmap]; % Allows us to create a grey color for plotting negative ages.
cmap(end,:) = []; % Recreates an array to include grey within the jet color scheme.
colormap(cmap); % Compiles array of cmap RGB values and plots the new color sheme.

%% Step 5: Discuss your results

% Does your map of ocean ages make sense given the plate boundaries?
% Yes, only near spreadng centers and ocean basins.  

% What is the oldest age in your map?
% About 180 Ma

% Where does this oldest age occur and does this make sense geologically?
% Off the north-east coast of Japan, the accepted age is near 160 Ma for
% that area.  It makes sense geologically because it is near a subduction
% zone where the oldest crust should be.

% Where do the youngest ages occur? Does this conform to your knowledge of
% oceanic listhosphere generation?

% The youngest ages occur along Mid-ocean ridge axes.  This conforms to
% what we see ploted in our model.

% Are there any assumptions that have gone into this model that might not
% be accurate?

% Spreading rate is not equal on both sides of the ridge axis. Certain
% geographic areas were younging when getting close to continental shelves;
% however, they should have been aging. Our model predicts the Mediteranean
% sea as being ~20Ma, while accepted values are positing the
% Mediteranean sea as some of the oldest oceanic crust. 

