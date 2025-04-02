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
%Parameters-----------------------------------------------------------------
alpha=0.05;
L = 1000; %random permutation 
GMIC = zeros(24, 1); 
MIC = zeros(24, 1);
uniqueHours = unique(filteredData.Hour);

%CHOOSE A SEASON-----------------------------------------------------------
% If you want only for 1 Season, choose whichever season you want
mySeason = 4; %1,2,3,4

% If you want to check it for each season. 
%for mySeason = 1: 4        %(uncomment this comment)
    Group9Exe6Fun1(mySeason, filteredData, alpha, L, uniqueHours)
%end                        %(uncomment this comment)


%% %%%%%%%%%%%%%%%%%%%%%%%%%%% SXOLIA %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% In general we observe that GMIC and MIC ranges in very small values.
%
% MIC is particularly useful when you want to detect relationships that may 
%     not be linear.
% GMIC becomes more robust to scaling discrepancies,(compared to MIC) making 
%      it better suited for comparing relationships across different scales.

% The relationship between variables like Bike rentals and Temperature may 
% vary throughout the day, due to various factors 
% (for example: weather conditions, holidays, traffic)
%                  
%% SEASON 1 - WINTER---------------------------------   
%   We observe that r & r_mvn range in very small amounts. 
% r between 0.10-0.64
% r_mvn between 0.10-0.68
% in early hours in the morning the correlation coefficients use to be
% extremely small (hour 4,5,6,7,8) (logical as most people use to sleep at 
% those hours regardless the weather) & 
% the highest correlations (around 0.56-0.68) appear at (hours 0,12,13,14,15,16) 
% that people can be outside and the temperature plays a vital role in 
% whether or not someone will rent a bike, as it is usually cold outside. 
%
% In general there isn't a VERY strong correlation (>0.85) between bike rentals and
% temperature through winter (we guess due to the weather conditions)
%
%% SEASON 2 - SPRING---------------------------------     
% During spring there is a relatively strong correlation between bike
% rentals and temperature, with most correlation coefficients values vary
% through [0.60-0.75], except in the early in the morning values (till 9
% o'clock in the morning) that people use to sleep regardless of the
% weather. (we guess due to the nice weather conditions and high temperature)
%
%% SEASON 3 - SUMMER---------------------------------     
% During summer r and r_mvn range in extremelly small values [0.01 - 0.15]
% (hour 0,1,2,3,4,5,6,7,8,9,17,18,19,20,21,22,23) & 
% in still relatively small values [approximately mean value 0.24] 
% (hour 10,11,12,13,14,15,16)
%
% In general we conclude that during summer there isn't any relation
% between bikes rental and temperature (we guess due to the holidays, and 
% the strong sun that prevails all day long)
%
%% SEASON 4 - AUTUMN---------------------------------     
% During autumn the correlation coefficients are low during the
% morning hours (till 13:00 o'clock) indicating there is not any
% correlation between bike rentals and temperature during those hours, as 
% people tend to sleep. The coefficients are mostly approximately at
% [0.5-0.66] through the day, indicating there is still not a strong 
% correlation. We guess this happens due to the unpredictable weather 
% conditions of autumn, as it is usually the raining season (not ideal 
% for bike rides).
