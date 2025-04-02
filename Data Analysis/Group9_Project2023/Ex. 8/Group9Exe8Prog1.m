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

myHour = 21; %An hour of my choice

%Print all the R2-squared for each Season for the specific Hour
Group9Exe8Fun2(filteredData, uniqueSeasons, myHour);

% 6 pair of seasons
Group9Exe8Fun1(filteredData, 1, 2, uniqueSeasons, myHour);
Group9Exe8Fun1(filteredData, 1, 3, uniqueSeasons, myHour);
Group9Exe8Fun1(filteredData, 1, 4, uniqueSeasons, myHour);
Group9Exe8Fun1(filteredData, 2, 3, uniqueSeasons, myHour);
Group9Exe8Fun1(filteredData, 2, 4, uniqueSeasons, myHour);
Group9Exe8Fun1(filteredData, 3, 4, uniqueSeasons, myHour);

%% Sxoliaste an fainetai i prosarmogi tou grammikoy monteloy na einai to idio kali gia oles tis epoxes h kapoies epoxes.
% --------------------------------------------------------------------------------------------------
% Oso megalitero einai to R-squared, toso kaliteri i prosarmogi toy
% grammikou monteloy gia tin en logo epoxi. Vrisko diastima empistosinis
% gia R-squared(season1) - R-squared(season2) gia na katalavo an einai 
% to idio kali h prosarmogi tou grammikou montelou gia oles tis epoxes i
% gia kapoies.

% An ta oria toy diastimatos empistosinis ths diaforas twn R-squared,
% perilamvanoun to 0, tote den yparxei statistika simantiki diafora anamesa 
% sta R2 twn 2 Seasons.
% An ta oria toy ci einai arnitika h thetika kai sxetika makria apo to 0,
% tote yparxei statistika simantiki diafora metaksi ton 2 Seasons(dld. se
% kapoio apo ta 2 Seasons i prosarmogi einai kaliteri)
% Otan kai ta 2 oria einai arnitika, tote to montelo linear regression
% prosarmozetai kalitera sta dedomena tis 2is epoxis se sigkrisi me tin 1i epoxi.
