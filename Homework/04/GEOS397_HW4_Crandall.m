%% Homework 4
%%
% *Authors: Alex Edwards and Curtis Crandall*

%% *Part 1: Make a basemap and determine a crude ocean volume*
%%
% In order to predict sea-level change we need to know the current state 
% of sea level.
% Step 1: Load the topo.mat data set
% Use load to load the 1x1 deg MATLAB global topography data into memory.

%% Part 1 - Step 1: Load the topo.mat data set
load ('topo.mat')

%% Part 1 - Step 2: Plot a basemap

h = figure;
h.InvertHardcopy = 'off'; % (1 pt.) uses the same colors as those on the display
h.Color = 'k'; % Changes axes color
h.Position = [100 100 1000 500]; % Location and size of figures
h.PaperPositionMode = 'auto'; % Directive to use displayed figure size when printing or saving
% setup the map axes
ax = axesm('Mollweid', 'Frame', 'on', 'Grid', 'on'); % Define map axes and set map properties
setm(ax,'MLabelLocation',60); % Sets the longitude values at every 60 degrees. 
setm(ax,'PLabelLocation',30); % Sets the latitude values at every 30 degrees. 
mlabel('MLabelParallel',0); % Labels the latitude values
plabel('PLabelMeridian',-25); % Labels the longitude values
axis('off'); % Changed color of the map black.
setm(ax,'FontColor',['0.9 0.9 0.9']); % Set axes font color
setm(ax,'GColor',['0.9 0.9 0.9']); % Grid line color

load coastlines
geoshow(topo , topolegend , 'DisplayType' , 'texturemap')
demcmap(topo)
CData = topo;
FaceColor = 'texturemap'
c = colorbar;
c.Label.String = 'Elevation (m)'
c.Color = 'white'
geoshow(coastlat,coastlon,'Color','r')

%% Part 1 - Step 3: Modify the topo matrix to represent ocean depth

distdim(topo , 'm' , 'km');
kmtopo = ans;

h = figure;
h.InvertHardcopy = 'off'; 
h.Color = 'k'; 
h.Position = [100 100 1000 500]; 
h.PaperPositionMode = 'auto'; 
ax = axesm('Mollweid', 'Frame', 'on', 'Grid', 'on'); 
setm(ax,'MLabelLocation',60); 
setm(ax,'PLabelLocation',30);
mlabel('MLabelParallel',0); 
plabel('PLabelMeridian',-25); 
axis('off'); 
setm(ax,'FontColor',['0.9 0.9 0.9']);
setm(ax,'GColor',['0.9 0.9 0.9']);
load coastlines
geoshow(kmtopo , topolegend , 'DisplayType' , 'texturemap')
demcmap(kmtopo)
CData = kmtopo;
FaceColor = 'texturemap';
c = colorbar;
c.Label.String = 'Elevation (km)';
c.Color = 'white'
geoshow(coastlat,coastlon,'Color','r')

if kmtopo > 0;
    Seatopo = 0;
else kmtopo < 0;
end 

Seatopo = (kmtopo.*ans);

h = figure;
h.InvertHardcopy = 'off'; 
h.Color = 'k'; 
h.Position = [100 100 1000 500]; 
h.PaperPositionMode = 'auto'; 
ax = axesm('Mollweid', 'Frame', 'on', 'Grid', 'on'); 
setm(ax,'MLabelLocation',60); 
setm(ax,'PLabelLocation',30);
mlabel('MLabelParallel',0); 
plabel('PLabelMeridian',-25); 
axis('off'); 
setm(ax,'FontColor',['0.9 0.9 0.9']);
setm(ax,'GColor',['0.9 0.9 0.9']);
load coastlines
geoshow(Seatopo , topolegend , 'DisplayType' , 'texturemap')
demcmap(Seatopo)
CData = Seatopo;
FaceColor = 'texturemap';
c = colorbar;
c.Label.String = 'Elevation (km)';
c.Color = 'white';
geoshow(coastlat,coastlon,'Color','r')
%%
% To find the volume of the sea water, you would need to calculate each
% pixel area and multiply it by its corresponding depth. This means that we
% will only be dealing with values that are less than zero. If you
% calculate the volume of each pixel with a nonzero value, then add them,
% the result should be the total volume of the oceans.

%% Part 1 - Step4: Compute the area of each pixel
%%
% *Question*: what is the area in km^2 of a 1 deg x 1 deg pixel? 
%%
% *Answer*: See Below
% arclength = 2*pi*radius
% radius of earth = 6371 km
pixelarea = (2*pi*6371*(1/360))^2; % =1.2364e+04 km^2
%%
% *Question*: using this area, what is the total volume of oceans? 
%%
% *Answer*: 1.8226e+09
pixelvolume = pixelarea * Seatopo; 
estoceanvolume = abs(sum(sum(pixelvolume)));

%% *Part 2: A more accurate volume estimate*
%%
% *Question*: What does that mean in relation to our previous estimate of
% ocean volume? Are we under or overestimating the true ocean volume? 
%%
% *Answer*: This means that we are more than likely overestimating the true
% ocean volume. 

%% Part 2 - Step 1: Compute the area between two lines of latitude
%%
% Spherical cap area equation:
%%
% A = 2*pi*R*h
%%
% h = R(1-sin(lat))
%%
% Ring around the sphere: 
%%
% A_ring = 2piR^2|sin(lat1*(pi/180))-sin(lat2*(pi/180)))|
R = 6371;
A_ring = 2*pi*R^2*abs(sind(29)-sin(30)); %= 3.7562e+08 km^2

%% Part 2 - Step 2: Compute the area of each pixel
%%
% *Question*: Now that we have the area around sphere between two lines of
% latitude, what is the area of a cell between 29N-30N and two lines of
% longitude separated by 1 deg? 
%%
% *Answer*: See Below

A_cell = A_ring/360; % A_cell = 1.0434e+06 km^2
E_pixels = zeros(90,360);
for i = 0:89;
    A_ring2 = 2*pi*(6371^2)*abs(sind(i)-sind(i+1));
    E_pixels(i+1,:) = A_ring2/360;
end
E_pixels2 = flipud(E_pixels);
E_pixels3(1:90,:) = E_pixels2;
E_pixels3(91:180,:) = E_pixels;

h = figure;
imagesc(topolonlim,topolatlim,E_pixels3);
c = colorbar;
c.Label.String = 'Area [km^2]';
xlabel ('Longitude')
ylabel ('Latitude')

%% Part 2 - Step 3: Compute the oceans volume

oceansvolume = abs(E_pixels3.*Seatopo);
actualoceansvolume = sum(oceansvolume(:));
%%
% *Question*: What is the total volume of the oceans in km^3 using this new
% approach? 
%%
% *Answer*: The total volume of the earth's oceans is estimated to be 
% 1.3369e+09 km^3. 
% 
% *Question*: What is the difference in the total volume of the oceans in
% km^3 between the two approaches? 
%%
% *Answer*: oceansVolumedifference = estoceanvolume - actualoceansvolume;
% The difference between the two methods is 4.8568e+08 km^3.

%% *Part 3: Sea-level rise due to Antarctica*
% Land below 60S lat is the continent of Antartica

%% Part 3 - Step 1: Compute the volume of water contained on Antarctica
if kmtopo < 0;
    kmtopo = 0;
else kmtopo > 0;
end

Landtopo = ans.*kmtopo;
Landvolume = Landtopo.*E_pixels3;
Landvolume2 = Landvolume (151:180,:);
AntarcticLandvolume = sum(Landvolume2(:));
%%
% *Question*: What is the total volume of mass above sea level? 
%%
% *Answer*: The total volume of mass south of 60S is 9.1564e+06. 
AntarcticWatervolume = AntarcticLandvolume*0.9;
%%
% *Question*: What is the total volume of liquid water stored in ice in
% Antarctica? 
%%
% *Answer*: The total volume of liquid water is 8.2407e+06 km^3. 

%% Part 3 - Step 2: Compute the change in total ocean volume for incremental changes in sea-level height

topo = kmtopo*1000;
seaRise = zeros(1,100);
oceansvolume4 = zeros(1,100);
for i = 1:100;
    seaRise(i) = i;
    topo2 = topo-i;
    if topo2 > 0;
        topo2 = 0;
    else topo2 < 0;
    end 
    topo3 = (topo2.*ans)/1000;
    oceansvolume3 = abs(topo3.*E_pixels3);
    oceansvolume4(i) = sum(oceansvolume3(:)) - actualoceansvolume;
end 

h = figure;
plot (seaRise, oceansvolume4,'o');
xlabel('Sea-level rise[m]')
ylabel('Volume of meltwater added to oceans[km^3]')

%% Part 3 - Step 3: Match the change in volume with the volume held on Antarctica

Match_volume = find (oceansvolume4 >= AntarcticWatervolume);
ActualMatch_volume = oceansvolume4(23)
%%
% Based on the find function, at 23 meters there is a sea-level rise that
% matches that of what would happen if Antarctica was melted. 

topo4 = topo-23;
if topo4 > 0;
   topo4 = 0;
   else topo4 < 0;
end
sealevelrisetopo = (topo4.*ans)/1000;

h = figure;
h.InvertHardcopy = 'off';
h.Color = 'k';
h.Position = [100 100 1000 500];
h.PaperPositionMode = 'auto';
ax = axesm('Mollweid', 'Frame', 'on', 'Grid', 'on');
setm(ax,'MLabelLocation',60); 
setm(ax,'PLabelLocation',30); 
mlabel('MLabelParallel',0);
plabel('PLabelMeridian',-25);
axis('off');
setm(ax,'FontColor',['0.9 0.9 0.9']);
setm(ax,'GColor',['0.9 0.9 0.9']);

load coastlines
geoshow(topo , topolegend , 'DisplayType' , 'texturemap')
demcmap(topo)
CData = topo;
FaceColor = 'texturemap'
c = colorbar;
c.Label.String = 'Elevation (m)'
c.Color = 'white'
geoshow(coastlat,coastlon,'Color','r')

%% 
% *Question*: list two places in the world that would inundated with water if
% all the ice Antarctica melted. 
%%
% *Answer*: The Bahamams, Hawaii, Florida, Japan... there looks to be a few 
% places that would either disappear all together, or become severely
% morphed by water.
% 
% *Question*: List all the possible things in this modeling approach that
% could be improved or made more accurate. 
%%
% *Answer*: There are multiple things that could be done in order to make this
% approach more accurate. The first is resolution. The data that we used in
% based on the average within one square degree of latitude and longitude.
% This is still an immense area, and therefore means that the actual
% coastline and its corresponding variations do not show up in this model.
% We are also assuming that the volume we are solving for is a near perfect
% rectangular prism. In reality the shape of each volume would be slightly
% narrowed as it approaches the center. This means that we have an overall
% overestimate of the values calculated. There is also the assumption of
% what Antarctica  is made up of. Antarctica is also made up rock that would
% not only effect the mass, but the volume calculations as well. This means
% that the model also cause an overestimate.

%% *Part 4: Sea Level Rise Due to Greenland*
%%
% *Question*: Explain how you would include the ice stored on Greenland in 
% your sealevel rise modeling:
%%
% *Answer*: You would need to select a range of lat/lon that contains Greenland
% inside of it. Then select all values where sealevel > 0. This should give
% you the land mass that is inside that range of cells. The different
% elevation of those points, correspond to ice thickness, assuming
% Greenland is almost entirely ice. From there you can calulate a crude
% volume for water stored as frozen mass on Greenland; but it is an
% overestimation.

%%
% *Question*: What is the liquid water volume stored on Greenland in ice form?
clc
figure
imshow('greenland1.jpg'); % saved fig1 to modify image and find polygon area
% impoly(gca,[]); allows you to create a polygon by clicking on the figure.
% Right click and copy points. Copy paste points into matlab (the empty
% brackets
poly1 = impoly(gca,[537 106;533 120;524 136;537 144;549 137;559 128;569 125;583 122;590 112;600 100;598 94;577 92;556 94;546 98]);
% Vertice coordinates approximating greenland. (same as the ones pasted
% above from impoly
points1 = [537 106;533 120;524 136;537 144;549 137;559 128;569 125;583 122;590 112;600 100;598 94;577 92;556 94;546 98];
% Area approximated by polyarea
greenlandVol = polyarea(points1(:,1), points1(:,2))*1000;
% Iceland is covered by nearly 85%
greenlandWatervolume = greenlandVol*0.85;
%%
% *Answer*: Approximately 1.804E6 km^3 of ice is stored on Iceland
% disp(greenlandWatervolume);






