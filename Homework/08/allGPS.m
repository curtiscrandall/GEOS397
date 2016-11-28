%% 2.5: Process all of the data
function allGPS

myFolderInfo= dir('GPSdata');

for n=3:9;
    getGPSdata(myFolderInfo(n).name)
end

warning('off','all')
Etable=readtable('residualTableEast.xlsx')
Ntable=readtable('residualTableNorth.xlsx')
Vtable=readtable('residualTableVertical.xlsx')



end