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
nameSeason = {'Winter','Spring','Summer','Autumn'};

%Define Hours
uniqueHours = unique(filteredData.Hour);
num_hours = length(uniqueHours);

%Define Temperature
uniqueTemperature = unique(filteredData.Temperature__C_);

%--------------------------------------------------------------------------
mySeason = 1; % The Season for which I am making the test 

% Data table for that specific season
season_data = filteredData(filteredData.Seasons == mySeason, :);

ideal_adjR2 = zeros(length(uniqueHours));
poly_degree = 2;  % polynomial degree

% Repeat for all the 24 hours of the Season
for h=1:length(uniqueHours)
    %Bikes for a specific Hour of the Season
    Bikes = season_data.RentedBikeCount(season_data.Hour==uniqueHours(h));
    %Temperature for a specific Hour of the Season
    Temperature = season_data.Temperature__C_(season_data.Hour==uniqueHours(h));

    %Linear Model
    linear_model = fitlm(Temperature, Bikes, 'linear');
    linear_adjR2(h) = linear_model.Rsquared.Adjusted;

    %Non Linear Model 
    % Polionimikes Synartiseis
    % y = b(0) + b(1)*x + b(2)*x^2
    polynomial2_model = fitlm(Temperature, Bikes, 'poly2');
    polynomial2_adjR2(h) = polynomial2_model.Rsquared.Adjusted;

    %y = b(0) + b(1)*x + b(2)*x^2 + b(3)*x^3
    polynomial3_model = fitlm(Temperature, Bikes, 'poly3');
    polynomial3_adjR2(h) = polynomial3_model.Rsquared.Adjusted;    

    % Eggeneis sinartiseis (page 107)
    exponential_model = fitlm(Temperature, log(Bikes), 'linear'); % y'=ln(y)
    exponential_adjR2(h) = exponential_model.Rsquared.Adjusted;

    reversed_model = fitlm(1/Temperature, Bikes, 'linear'); % x'=1/x
    reversed_adjR2(h) = reversed_model.Rsquared.Adjusted;


    % Find the ideal model --> (maximum adjR2)
    [ideal_adjR2(h), idx(h)] = max([linear_adjR2(h), polynomial2_adjR2(h), polynomial3_adjR2(h), exponential_adjR2(h), reversed_adjR2(h)]);

    if (idx(h)==1)
        ideal_model{h} = 'Linear';
    end
    if(idx(h)==2)
        ideal_model{h} = 'Polynomial (Degree 2)';
    end
    if(idx(h)==3)
        ideal_model{h} = 'Polynomial (Degree 3)';
    end
    if(idx(h)==4)
        ideal_model{h} = 'Exponential ( ln(y) )';
    end
    if(idx(h)==5)
        ideal_model{h} = 'Reversed (1/x)';
    end
end


fprintf("Adjusted R-squared for Season --> %s(%d)\n", nameSeason{mySeason}, uniqueSeasons(mySeason));
fprintf("Ώρα     Καταλληλότερο Μοντέλο      adjR2\n");
fprintf("--------------------------------------------\n");
for h=1:length(uniqueHours)
    if(idx(h)==1)
        fprintf("%d         %s                  %f \n",uniqueHours(h), ideal_model{h}, ideal_adjR2(h));
    end
    if (idx(h)==2 || idx(h)==3 || idx(h)==4)
            fprintf("%d    %s        %f \n",uniqueHours(h), ideal_model{h}, ideal_adjR2(h));
    end
    if (idx(h)==5)
        fprintf("%d         %s             %f \n",uniqueHours(h), ideal_model{h}, ideal_adjR2(h));
    end
end


%% Comment if there is a non-linear dependence of Bikes(y) in terms of Temperature(x) AND for which hours
%-------------------------------------------------------------------------------
%For Season 1 --> WINTER   

% NON-LINEAR DEPENDENCE
% Time 5 --> polynomial (degree 2)
% Time 0, 2, 14-19, 22, 23 --> polynomial (degree 3)

% EGGENEIS GRAMMIKES SYNARTISEIS - dld. grammikes me metasximatismo
% Time 3, 4 --> exponential
