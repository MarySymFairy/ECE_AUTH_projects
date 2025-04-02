% Mamougiorgi Maria 10533
% Dimitris Kyriakou 10842

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

nameSeason = {'Winter','Spring','Summer','Autumn'};
% Season ---> Winter-1, Spring-2, Summer-3, Autumn-4
for j = 1:num_seasons
    Group9Exe1Fun1(filteredData, j, nameSeason{j});
end

% Is the best distribution the same for the 4 Seasons??
% --------------------------------------------------------
% No the best distribution does not differ among the seasons, they all end up in Kernel distribution. 
% Autumn distribution has the smallest possibility in Kernel than the
% rest seasons. (57.661798%) --> almost rejected distribution
% Winter has the highest possibility in Kernel