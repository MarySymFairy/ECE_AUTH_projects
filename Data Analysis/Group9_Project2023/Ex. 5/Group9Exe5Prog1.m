% Mamougiorgi Maria 10533
% Dimitris Christos Kyriakou 10842

clc; clear; close all;

% Load the data
data = readtable("SeoulBike.xlsx");

%DATA FILTER---------------------------------------------------------------
    % Step 1 --> get unique Dates 
    uniqueDates = unique(data.Date);    
      
    % Step 2 --> exclude dates that do not consist of 24 hours
    filteredDates = [];
    for i = 1:length(uniqueDates)
        % check how many hours each day has
        hoursOfDay = unique(data.Hour(data.Date == uniqueDates(i)));
    
        if length(hoursOfDay) == 24
            % the new date should be added as a new row in the array filteredDates
            filteredDates = [filteredDates; uniqueDates(i)];
        end
    end
        
    % Step 3 --> Filter data table to exclude rows with invalid dates
    filteredData = data(ismember(data.Date, filteredDates), :);
%--------------------------------------------------------------------------

%Define seasons
uniqueSeasons = unique(data.Seasons);
num_seasons = length(uniqueSeasons);

%Define Hours
uniqueHours = unique(filteredData.Hour);
num_hours = length(uniqueHours);

%Define Temperature
uniqueTemperature = unique(filteredData.Temperature__C_);

nameSeason = {'Winter','Spring','Summer','Autumn'};
%Repeat for all 4 Seasons
for season = 1:num_seasons
    Group9Exe5Fun1(filteredData, season, uniqueSeasons, uniqueHours);
end

%% Find the max correlation coefficients for each Season & comment the hour for each season 
% --> the hour is TOTALLY different for each Season!!
% Max correlation_coefficient for Season 1: 0.639346 -->15 hour!
% Max correlation_coefficient for Season 2: 0.730059 -->18 hour!
% Max correlation_coefficient for Season 3: 0.108221 -->20 hour!
% Max correlation_coefficient for Season 4: 0.706615 -->1 hour!

%Statistical importance is found with p-value --> 
% p_value < 0.05 means more important statistically

%Sto diagramma fainontai oi sintelestes sisxetisis tis kathe oras kai
%epoxis, me kokkinismenes tis statistika simantikes sisxetiseis.
% Genika h sxesh enoikiasmou polilaton os pros thermokrasia einai metria.
%To kalokairi i sisxetisi einai i mikroteri (sxedon midamini). 
