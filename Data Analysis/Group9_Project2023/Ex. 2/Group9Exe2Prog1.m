% Mamougiorgi Maria 10533
% Dimitris Christos Kyriakou 10842

clc; clear; close all;

% load the data
data = readtable("SeoulBike.xlsx");

%DATA FILTER
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

%Define seasons
uniqueSeasons = unique(data.Seasons);
num_seasons = length(uniqueSeasons);

% for all the possible pairs of seasons. 
% (1,2)(1,3)(1,4) + (2,3)(2,4) + (3,4)
for i = 1:num_seasons
    for j = i+1:num_seasons
        Group9Exe2Fun1(filteredData,i,j);
    end
end

% Comments about the results: ---------------------------------------------
% 1. Sample is small --> not accurate results
%    If I increase my sample (M = 1000), the percentages are almost 0% (distributions
%    are almost same), except Winter(1) and Autumn(4) that keep an almost 25%
%    percentage difference.
% 2. The distributions have a very small (percentage_no_difference) most of the times
%    It is (<50%) meaning that the null hypothesis (no difference between the distributions)
%    , is rejected in the majority of the tests.
% 3. We did not use chi2gof because for a larger sample size it showed a
%    percentage of times equal to 0. Tin ilopoihisame manually me tous
%    tipous tis theorias.