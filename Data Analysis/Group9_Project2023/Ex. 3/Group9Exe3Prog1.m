% Mamougiorgi Maria 10533
% Dimitris Christos Kyriakou 10842
clc; clear; close all;

% Load the data
data = readtable("SeoulBike.xlsx");

%DATA FILTER --------------------------------------------------------------
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
   
%Number of Hours
uniqueHours = unique(filteredData.Hour);
num_hours = length(uniqueHours);

for s = 1: num_seasons  %4 Seasons
    %Subset for each Season
    season_data = filteredData(filteredData.Seasons == uniqueSeasons(s), :);
        
    %Instantiation of matrices
    p_values = zeros(num_hours, num_hours);
    average_differences = zeros(num_hours, num_hours);
     
    % Test for all hour pairs of ALL the Season dates(276 pairs) 
    %OF THE SEASON
        for i = 1:num_hours 
            for j = 1 : num_hours
                % Take the column of Bikes those specific dates & hours
                Bikes_one = season_data.RentedBikeCount(season_data.Hour==uniqueHours(i)); 
                Bikes_two = season_data.RentedBikeCount(season_data.Hour==uniqueHours(j)); 

                sample = Bikes_two - Bikes_one;
                % Null hypothesis for difference with mean_value==0
                [~, p] = ttest(sample);
                        
                % Store results of the hypothesis in matrice p_values
                p_values(i, j) = p; 
                % Average Difference between 2 different hours of the Season days
                average_differences(i, j) = abs(mean(sample));
            end
        end
   
    %Visualize results using a colormap
    Group9Exe3Fun1(average_differences, p_values, uniqueHours, num_hours, uniqueSeasons(s))

end


% Do the result maps look alike in the 4 seasons or are there significant
% differences for any season?----------------------------------------------------
%------------------------------------------------------------------
% 1. The result of average_differences is symmetric, with diagonal
%    separating the 2 parts. Einai simmetriko dioti ta zeugaria oron einai
%    idia gia 1-5 kai 5-1.
% 2. Hour pairs that are near the diagonal have nearby mean values, which
%    is logical, as they are nearby time zones of the day.
% 3. Only spring(2) & autumn(4) have alike results.