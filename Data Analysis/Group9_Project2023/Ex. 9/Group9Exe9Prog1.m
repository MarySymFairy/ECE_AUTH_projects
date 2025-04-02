% Mamougiorgi Maria 10533
% Dimitris Christos Kyriakou 10842

clc; clear; close all;
% Load and filter the data from the Excel file
data = readtable('SeoulBike.xlsx');
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

% CHOOSE A SEASON-----------------------------------------------------------
mySeason = 1; %1,2,3,4
filtered_data = filteredData(filteredData.Holiday == 0 & filteredData.Seasons == mySeason, :);

% Extract relevant predictors and response variable
predictors = filtered_data{:, {'Temperature__C_', 'Humidity___', 'WindSpeed_m_s_', 'Visibility_10m_', 'DewPointTemperature__C_', 'SolarRadiation_MJ_m2_', 'Rainfall_mm_', 'Snowfall_cm_', 'Hour'}};
response = filtered_data{:, 'RentedBikeCount'};

% Split data into training and testing sets
allDays = length(unique(filtered_data.Date));
train_data = filtered_data(1:(allDays-20)*24, :); % First (allDays-20) days
test_data = filtered_data((allDays-20)*24+1:end, :); % Last 20 days

%%%%%%%%%%%%%%%%%%% MODEL 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
num_hours = 24;
models1a = cell(1, num_hours);
models1b = cell(1, num_hours);

for hour = 1:num_hours
    % Filter data for the current hour
    train_hour_data = train_data(train_data.Hour == (hour - 1), :);
    
    % Extract predictors and response variable for the current hour
    predictors_hour = train_hour_data{:, {'Temperature__C_', 'Humidity___', 'WindSpeed_m_s_', 'Visibility_10m_', 'DewPointTemperature__C_', 'SolarRadiation_MJ_m2_', 'Rainfall_mm_', 'Snowfall_cm_'}};
    response_hour = train_hour_data{:, 'RentedBikeCount'};
    
    % Train model 1 for a multiple regression model for the current hour
    mdl1a = fitlm(predictors_hour, response_hour);
    models1a{hour} = mdl1a;

    % Train model 2 for to perform stepwise regression for the current hour
    mdl1b = stepwiselm(predictors_hour, response_hour, 'linear', 'Criterion', 'aic');
    models1b{hour} = mdl1b;
end

num_test_hours = size(test_data, 1);
num_days = num_test_hours / 24;
predictions1a = zeros(num_days, num_hours);
predictions1b = zeros(num_days, num_hours);

for hour = 1:num_hours
    % Filter data for the current hour
    test_hour_data = test_data(test_data.Hour == (hour - 1), :);
    
    % Extract predictors for the current hour
    predictors_test_hour = test_hour_data{:, {'Temperature__C_', 'Humidity___', 'WindSpeed_m_s_', 'Visibility_10m_', 'DewPointTemperature__C_', 'SolarRadiation_MJ_m2_', 'Rainfall_mm_', 'Snowfall_cm_'}};
    
    % Predict the number of rented bikes for the current hour using the corresponding model
    predictions1a(:, hour) = predict(models1a{hour}, predictors_test_hour);
    predictions1b(:, hour) = predict(models1b{hour}, predictors_test_hour);
end

%%%%%%%%%%%%%%%%%%%%%% MODEL 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Train model 2 for all hours of the day
models2a = fitlm(predictors, response);
models2b = stepwiselm(predictors, response, 'linear', 'Criterion', 'aic');

% Make predictions for all hours of the last 20 days
predictions2a = predict(models2a, test_data{:, {'Temperature__C_', 'Humidity___', 'WindSpeed_m_s_', 'Visibility_10m_', 'DewPointTemperature__C_', 'SolarRadiation_MJ_m2_', 'Rainfall_mm_', 'Snowfall_cm_', 'Hour'}});
predictions2b = predict(models2b, test_data{:, {'Temperature__C_', 'Humidity___', 'WindSpeed_m_s_', 'Visibility_10m_', 'DewPointTemperature__C_', 'SolarRadiation_MJ_m2_', 'Rainfall_mm_', 'Snowfall_cm_', 'Hour'}});

%%%%%%%%%%%%%%%%%%%%%%%%% MODELS PLOTTING %%%%%%%%%%%%%%%%%%%%%%%%%%%
% Concatenate date and hour into a single datetime array
date_hour = datetime(test_data.Date, 'InputFormat', 'dd/MM/yyyy') + hours(test_data.Hour);

% Reshape the transposed predictions array into a single column
predictions_stacked1a = reshape(predictions1a', [], 1);
predictions_stacked1b = reshape(predictions1b', [], 1);
predictions_stacked2a = reshape(predictions2a', [], 1);
predictions_stacked2b = reshape(predictions2b', [], 1);

figure;

subplot(2, 2, 1);
plot(date_hour, test_data.RentedBikeCount, 'o', date_hour, predictions_stacked1a, 'x');
legend('Data', 'Predictions1a');
grid on;
title('Predictions 1a');

subplot(2, 2, 2);
plot(date_hour, test_data.RentedBikeCount, 'o', date_hour, predictions_stacked1b, 'x');
legend('Data', 'Predictions1b');
grid on;
title('Predictions 1b');

subplot(2, 2, 3);
plot(date_hour, test_data.RentedBikeCount, 'o', date_hour, predictions_stacked2a, 'x');
legend('Data', 'Predictions2a');
grid on;
title('Predictions 2a');

subplot(2, 2, 4);
plot(date_hour, test_data.RentedBikeCount, 'o', date_hour, predictions_stacked2b, 'x');
legend('Data', 'Predictions2b');
grid on;
title('Predictions 2b');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% MODELS EVALUATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Calculate Mean Squared Error for Model 1
mse_1a=mean((test_data{:, 'RentedBikeCount'} - predictions_stacked1a).^2);
mse_1b=mean((test_data{:, 'RentedBikeCount'} - predictions_stacked2a).^2);
if mse_1a>=mse_1b
    fprintf("Stepwise regression model is better for Season %d in Model 1\n",mySeason);
    mse1=mse_1b;
else 
    fprintf("Full multiple regression model is better for Season %d in Model 1\n",mySeason);
    mse1=mse_1a;
end

% Calculate Meane Squared Error for Model 2
mse_2a=mean((test_data{:, 'RentedBikeCount'} - predictions_stacked2a).^2);
mse_2b=mean((test_data{:, 'RentedBikeCount'} - predictions_stacked2b).^2);
if mse_2a>=mse_2b
    fprintf("Stepwise regression model is better for Season %d in Model 2\n",mySeason);
    mse2=mse_2b;
else 
    fprintf("Full multiple regression model is better for Season %d in Model 2\n",mySeason);
    mse2=mse_2a;
end

% Compare Model 1 with Model 2
if mse1>mse2
    fprintf("Model 2 is better for Season %d\n",mySeason);
elseif mse1<mse2
    fprintf("Model 1 is better for Season %d\n",mySeason);
elseif mse1==mse2
    fprintf("There is no difference between the two models for Season %d\n",mySeason);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% STANDARD ERROR %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

residuals1a = test_data{:, 'RentedBikeCount'} - predictions_stacked1a;
sum_squared_residuals1a = sum(residuals1a.^2);
std_dev1a = sqrt(sum_squared_residuals1a/(480-1));
std_err1a = std_dev1a/sqrt(480);
fprintf('\nStandard Errors of Model1a: %f', std_err1a);

residuals1b = test_data{:, 'RentedBikeCount'} - predictions_stacked1b;
sum_squared_residuals1b = sum(residuals1b.^2);
std_dev1b = sqrt(sum_squared_residuals1b/(480-1));
std_err1b = std_dev1b/sqrt(480);
fprintf('\nStandard Errors of Model1b: %f', std_err1b);

residuals2a = test_data{:, 'RentedBikeCount'} - predictions_stacked2a;
sum_squared_residuals2a = sum(residuals2a.^2);
std_dev2a = sqrt(sum_squared_residuals2a/(480-1));
std_err2a = std_dev2a/sqrt(480);
fprintf('\nStandard Errors of Model2a: %f',std_err2a);

residuals2b = test_data{:, 'RentedBikeCount'} - predictions_stacked2b;
sum_squared_residuals2b = sum(residuals2b.^2);
std_dev2b = sqrt(sum_squared_residuals2b/(480-1));
std_err2b = std_dev2b/sqrt(480);
fprintf('\nStandard Errors of Model2b: %f',std_err2b);

%%%%%%%%%%%%%%%%%%%% STANDARD DEVIATION PLOTTING WITH REAL DATA %%%%%%%%%%%%%%%%%%%%

figure;

subplot(2, 2, 1);
plot(test_data{:, 'RentedBikeCount'}, residuals1a, 'o');
title('Residuals for Model 1a');

subplot(2, 2, 2);
plot(test_data{:, 'RentedBikeCount'}, residuals1b, 'o');
title('Residuals for Model 1b');

subplot(2, 2, 3);
plot(test_data{:, 'RentedBikeCount'}, residuals2a, 'o');
title('Residuals for Model 2a');

subplot(2, 2, 4);
plot(test_data{:, 'RentedBikeCount'}, residuals2b, 'o');
title('Residuals for Model 2b');

% Arxika fortwnoume ta dedomena, xorizoume tous deiktes se predictors kai responses kai tis 82 imeres se training kai testing. 
% Meta arxizoume me to 1o montelo pairnontas mono tous deiktes twn training days pou xrisimopoioume gia tin ekpaideysi tou montelou 
% mas, arxika me to plires montelo pollaplis palindromisis kai meta me tin vimatiki palindromisi. Sti synexeia dimiourgoume kenous 
% pinakes opou tha apothikeysoume tis provlepseis tou parapano montelou me 2 diaforetikous tropous gia tis 20 teleutaies meres me th 
% voitheia tis sinartisis predict, pou pairnei san orismata to grammiko montelo gia kathe wra ksexorista kai tous antistoixousς deiktes twn orwn 
% gia tis teleytaies 20 meres. Sto deytero montelo douleoume akrivos me ton idio tropo aplos san orismata stis synartiseis twn grammikwn 
% montelwn vazoume ta predictors kai ta antistoixa responses olwn twn wrwn twn prwtwn 62 imerwn. Arxika apeikonizoume tis 
% provlepomenes times se sygkrisi me tis pragmatikes kai tis 20 teleytaies meres. Gia na aksiologisoume tin apotelesmatikotita twn montelwn mas, 
% ypologizoume to meso tetragwniko sfalma, diladi tim mesi tetragoniki diafora twn pragmatikwn kai provlepomenwn timwn twn podilatwn. 
% Aytes oi times aksiologountai sto models, evaluation, apo to opoio prokiptei oti kai gia tous 2 typous ekpaideysis twn montelwn mas,
% i stepwise einai i pio akrivhs. Eno sygkrinontas ta 2 montela pou diaferoun sta dedomena ekpaideysis prokyptei oti to 2o montelo 
% einai pio apotelesmatiko. Telos, ypologizetai to standard error kathe montelou to opoio einai stathero opote den yparxei logos sximatikhs apeikonisis tou, 
% ektos an me tin ennoia diagnwstika diagrammata ennoeitai i apeikonisi twn residuals (diafora pragmatikis me provlepomeni timi) 
% pou episis apeikonizetai san deytero figure gia ola ta montela