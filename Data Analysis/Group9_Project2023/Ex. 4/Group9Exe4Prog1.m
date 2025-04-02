% Mamougiorgi Maria 10533
% Dimitris Christos Kyriakou 10842
clc; clear; close all;

% RentedBikeCount se 2 Seasons kai se Hour

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

%Define Seasons
uniqueSeasons = unique(filteredData.Seasons);
num_seasons = length(uniqueSeasons);

%Define Hours
uniqueHours = unique(filteredData.Hour);
num_hours = length(uniqueHours);

% 6 pair of seasons 
Group9Exe4Fun1(filteredData, 1, 2, uniqueHours);
Group9Exe4Fun1(filteredData, 1, 3, uniqueHours);
Group9Exe4Fun1(filteredData, 1, 4, uniqueHours);
Group9Exe4Fun1(filteredData, 2, 3, uniqueHours);
Group9Exe4Fun1(filteredData, 2, 4, uniqueHours);
Group9Exe4Fun1(filteredData, 3, 4, uniqueHours);

%% Statistika simantiki diafora
% Bootstrap gia median difference, opote prepei sto diastima empistosinis
% na entopizetai h timi 0 gia na iparxei periptosi oi diamesoi na einai
% isoi. (dld. stis 2 seasons na einai konta ta RentedBikeCount gia tin
% sigkekrimeni ora tis meras)

%% Yparxoun diafores sto meso plithos noikiasmenon podilaton metaksi epoxon kai gia poia ora kai poies epoxes?
%Genika iparxoun diafores analoga tin ora kai tin epoxi. Eidikotera:
%   Winter - Spring:
% --> i diafora to apogeuma ftanei to peak tis (tin ora 18) kai apo tis 14
% eos tis 22 paramenei megali, eno tis protes proines ores sxedon midenizetai.(0-6)
%   Winter - Summer: 
% --> megaliteri diafora apo winter-spring, to apogeuma ftanei to peak 
% tis diaforas (18-22) eno tis protes proines ores einai poli mikroteri(2-6)
%   Winter - Autumn:
% --> megali diafora tis apogeumatines ores (12-21) eno tis
% protes proines ores sxedon midenizetai(1-6)
%   Spring - Summer:
% --> i diafora ayxomeionetai, poli proi kai mesimerianes ores einai pio 
% mikrh (1-6) kai (10-15) se sxesi me to apogeuma vradi kai to proi pou einai ayximeni
% (18-23)
%   Spring - Autumn:
% --> genikotera iperisxiei to Autumn. megali diafora ores (7-8 kai 16-20) 
% eno  to ximeroma plisiazei para poli to 0.(2-6)
%   Summer - Autumn:
% --> poli entones diafores eidikotera to vradi (17-23) kai to proi (7-8) 