%% Part 2: Automated GPS Data Processing
% 2. 1: Download the data and import into MATLAB
function  [] = getGPSdata(filename)

nHeaderLine = 0;
fid = fopen( fullfile('GPSdata', filename), 'r' ); % Use directory with GPS data, will change with user
line = fgetl( fid ); % get the first line
nHeaderLine = nHeaderLine + 1;
line = fgetl( fid ); % get the second line
while strcmp(line(1:2),'% ')
nHeaderLine = nHeaderLine + 1;
line = fgetl( fid ); % get the second line
end
nHeaderLine = nHeaderLine + 1;



C=textscan(fid, '%.4f %.0f %.0f %.4f %.4f %.4f %.4f %.4f %.4f', 'HeaderLines', nHeaderLine);
fclose(fid);

%% 2.2: Strip out the relevant data

tDecyear     = C{1}; % Time [decimal year]
tIntyear     = C{2}; % Time [integer year]
tDaynum      = C{3}; % Time [integer day number]
Nposition    = C{4}; % North Position [m]
Eposition    = C{5}; % East Position [m]
vertPosition = C{6}; % Vertical Position [m]

% 2.3: Process the GPS data
stationName       = filename(1:4);              % pulls first four characters = station name
totalTime         = tDecyear(end)-tDecyear(1);  % time elapsed in decimal years
numDays           = length(tDaynum);            % number of days elapsed
totEdisplacement  = (Eposition(end) - Eposition(1))*100; % East displacement [cm]
totNdisplacement  = (Nposition(end) - Nposition(1))*100; % North displacement [cm]
totVdisplacement  = (vertPosition(end) - vertPosition(1))*100; % Vert displacement [cm]
meanEvelocity     = totEdisplacement/totalTime;   % East velocity [cm/yr]
meanNvelocity     = totNdisplacement/totalTime;   % North velocity [cm/yr]
meanVertvelocity  = totVdisplacement/totalTime;   % Vertical velocity [cm/yr]


%% Polyfit and Shit

residualMotion(tDecyear,Nposition);
residualN = ans;
residualMotion(tDecyear,Eposition);
residualE = ans;
residualMotion(tDecyear,vertPosition);
residualV = ans;



%% Plot and Shit
h = figure;
str=sprintf('North, East and Vertical Residual Motion at Station %s \n', stationName);
subplot (3,1,1)
plot(tDecyear, residualN, 'ob-','MarkerSize',3);
title(str)
xlabel('Time [yr]')
ylabel('North Position Residuals [cm]','FontSize',7.5)
hold on;
subplot (3,1,2)
plot (tDecyear, residualE,'-or','MarkerSize',3);
xlabel('Time [yr]')
ylabel('East Position Residuals [cm]','FontSize',7.5)
hold on;
subplot (3,1,3)
plot (tDecyear, residualV, '-og','MarkerSize',3);
xlabel('Time [yr]')
ylabel('Vertical Positon Residuals [cm]','FontSize',7.5)

%% Histogram

X = -0.015 : 0.001 : 0.015; % [cm]

h=figure
Hnorth=hist(residualN,X);
Heast=hist(residualE,X);
Hvert=hist(residualV,X);

bar(X, [Hnorth;Heast;Hvert]','stacked');
title(['Station: ', stationName, 'Higher Order Test']);
xlabel('Residual [cm]');
ylabel('Number of Points');
legend(['North'],['East'],['Vertical']);




end