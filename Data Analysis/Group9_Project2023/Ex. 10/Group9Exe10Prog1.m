% Mamougiorgi Maria 10533
% Dimitris Christos Kyriakou 10842

clc; clear;
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

% Create empty arrays to store data for each hour
hourly_data = cell(24, 1);

% Loop through each group and store data in corresponding arrays
for hour = 0:23
    selected_hour = hour+1;
    % Extract data for the current hour
    data_hour = filtered_data(filtered_data.Hour == hour, :);
    
    % Store data in corresponding array
    hourly_data{selected_hour} = data_hour;
end
figure;
hours_delay_comperrison_pca = cell(15, 1);
hours_delay_comperrison_svd = cell(15, 1);
for p = 1:15
adjusted_r_squared = [];
    for hour = 0:23 
        selected_hour = hour+1;
        previous_data = [];
        for i = selected_hour-p:selected_hour-1
            % Ensure the selected hour is within the valid range (1-24)
            if i >= 1
                % Concatenate data for the current hour to the previous_data array
                previous_data = [previous_data; hourly_data{i}];
            else
                % If the selected hour is before hour 1, adjust to wrap around to hour 24
                previous_data = [previous_data; hourly_data{24 + i}];
            end
        end


        % Define the variables for training and testing
        independent_vars = {'Temperature__C_', 'Humidity___', 'WindSpeed_m_s_', 'Visibility_10m_', ...
        'DewPointTemperature__C_', 'SolarRadiation_MJ_m2_', 'Rainfall_mm_', 'Snowfall_cm_'};
        dependent_var = 'RentedBikeCount';

        % Initialize arrays for training and testing data
        training_data_X = [];
        training_data_Y = [];
        test_data_X = [];
        test_data_Y = [];

        % Concatenate data for independent and dependent variables for training data
        for i = 1:height(previous_data)
            % Extract independent variables for training data
            training_data_X = [training_data_X; previous_data{i, independent_vars}];
            % Extract dependent variable for training data
            training_data_Y = [training_data_Y; previous_data{i, dependent_var}];
        end

        % Extract independent and dependent variables for test data
        test_data_X = hourly_data{selected_hour}{:, independent_vars};
        test_data_Y = hourly_data{selected_hour}{:, dependent_var};

        % Standardize the data
        mean_train_data = mean(training_data_X);
        std_train_data = std(training_data_X);
        standardized_training_data = (training_data_X - mean_train_data) ./ std_train_data;

        % Perform PCA
        [coeff, score, latent, ~, explained] = pca(standardized_training_data);

        % Select components the sum of which explain more than 95% of data
        % variation
        num_components = find(cumsum(explained) >= 0.95*100, 1);

        % Rewrite our data using only the main ideas that PCA found
        projected_training_data = score(:, 1:num_components);

        % Train linear regression model
        pca_linear_model = fitlm(projected_training_data, training_data_Y);
        
        % Perform SVD
        [U, S, V] = svd(standardized_training_data);

        % Select components based on desired rank
        desired_rank = 8; % Example: Select 8 components
        U_truncated = U(:, 1:desired_rank);
        S_truncated = S(1:desired_rank, 1:desired_rank);

        % Project data onto selected singular vectors
        projected_training_data_svd = standardized_training_data * V(:, 1:desired_rank);

        % Train linear regression model
        svd_linear_model = fitlm(projected_training_data_svd, training_data_Y);
        
        adjusted_r_squared_pca(selected_hour) = pca_linear_model.Rsquared.Adjusted;
        adjusted_r_squared_svd(selected_hour) = svd_linear_model.Rsquared.Adjusted;
    end
    hours_delay_comperrison_pca{p} = adjusted_r_squared_pca;
    hours_delay_comperrison_svd{p} = adjusted_r_squared_svd;
    subplot(3, 5, p);
    plot(1:24, adjusted_r_squared_pca, 'o', 1:24, adjusted_r_squared_svd, 'x');
    legend('PCA', 'SVD')
    title('Adj R-sqrt for hours delay', p);
end

% Initialize cell arrays to store the maximum adjusted R-squared values and corresponding delays for each hour
max_r_squared_per_hour_pca = cell(24, 1);
best_p_per_hour_pca = cell(24, 1);

max_r_squared_per_hour_svd = cell(24, 1);
best_p_per_hour_svd = cell(24, 1);

for hour = 1:24
    max_r_squared_hour_pca = -Inf; 
    best_p_hour_pca = 0;

    max_r_squared_hour_svd = -Inf;
    best_p_hour_svd = 0;
    
    for p = 1:15
        % Retrieve the adjusted R-squared values for the current hour and delay
        adjusted_r_squared_pca = hours_delay_comperrison_pca{p};
        adjusted_r_squared_svd = hours_delay_comperrison_svd{p};
        
        adjusted_r_squared_hour_pca = adjusted_r_squared_pca(hour);
        adjusted_r_squared_hour_svd = adjusted_r_squared_svd(hour);
        
        % Update the maximum adjusted R-squared value and corresponding delay for the current hour if needed
        if adjusted_r_squared_hour_pca > max_r_squared_hour_pca
            max_r_squared_hour_pca = adjusted_r_squared_hour_pca;
            best_p_hour_pca = p;
        end
        if adjusted_r_squared_hour_svd > max_r_squared_hour_svd
            max_r_squared_hour_svd = adjusted_r_squared_hour_svd;
            best_p_hour_svd = p;
        end
    end
    
    % Store the maximum adjusted R-squared value and corresponding delay for the current hour in the result arrays
    max_r_squared_per_hour_pca{hour} = max_r_squared_hour_pca;
    best_p_per_hour_pca{hour} = best_p_hour_pca;

    max_r_squared_per_hour_svd{hour} = max_r_squared_hour_svd;
    best_p_per_hour_svd{hour} = best_p_hour_svd;
end

fprintf("Season %d -------------------------------------------\n",mySeason);
for hour = 1:24
    fprintf('PCA: Hour %d: Maximum Adjusted R-squared = %.4f for delay p = %d\n', hour, max_r_squared_per_hour_pca{hour}, best_p_per_hour_pca{hour});
end
for hour = 1:24
    fprintf('SVD: Hour %d: Maximum Adjusted R-squared = %.4f for delay p = %d\n', hour, max_r_squared_per_hour_svd{hour}, best_p_per_hour_svd{hour});
end
for hour = 1:24
    if max_r_squared_per_hour_pca{hour} > max_r_squared_per_hour_svd{hour}
        fprintf('PCA has the best performance for Hour: %d with delay p = %d and Maximum Adjusted R-squared = %.4f\n', hour, best_p_per_hour_pca{hour}, max_r_squared_per_hour_pca{hour});
    elseif max_r_squared_per_hour_pca{hour} < max_r_squared_per_hour_svd{hour}
        fprintf('SVD has the best performance for Hour: %d with delay p = %d and Maximum Adjusted R-squared = %.4f\n', hour, best_p_per_hour_svd{hour}, max_r_squared_per_hour_svd{hour});
    else
        fprintf('PCA and SVD have the same performance for Hour: %d with delay p = %d and Maximum Adjusted R-squared = %.4f\n', hour, best_p_per_hour_pca{hour}, max_r_squared_per_hour_pca{hour});
    end
end

% Arxika periorizoume ta dedomena gia holiday = 0 and season = 1. Epeita se ena keli 24wrwn thesewn ksexorizoume ta dedomena me tous antistoixouw deiktes gia kathe wra. 
% Sti synexeia oi diaforetikes ysteriseis se kathe wra tis meras ksexorista. Sigkentronoume ta dedomena twn proigoumenwn wrwn pou antistoixoun stin ysterisi pou exoume kathe 
% fora kai ta xrisimopoioume os training data gia tin torini wra pou meletame. Xrisimopoioume 2 tipous grammikwn montelwn pou exoun meiosei diastaseis, PCA και SVD. 
% To PCA entopizei motiva sta dedomena kai ta metatrepei se ena neo sinolo metavlitwn ( principal component ). Efarmozoume PCA sta kanonikopoihmena dedomena kai ksana grafoume
% ta dedomena xrisimopoiwntas mono ta motiva pou ermineuoun >=95% tis diakimansis twn dedomenwn, telos ekpaideuoume to grammiko mas montelo. To SVD analyei ton arxiko pinaka dedomenwn 
% se 3 synistwses singular vectors pou deixnei tin kateythintikothta twn dedomenwn se enan polydiastato xwro dedomenwn, singular values pou deixnei tin simantikothta tis kathe 
% kateythinsis kai to set of singular vectors pou mas voitha na anakataskeuasoume ta arxika dedomena apo autew tis aplopoihmenes synistwses. Xorizoume ta dedomena stis 3 
% synistoses pou anaferame, epeita epilegoume ton arithmo twn motivwn pou tha diatirisoume apo ta arxika dedomena kai ksana grafoume ta dedomena mas gia ayta ta motiva, 
% Telos ekpaideuoume to grammiko mas montelo. Meta plotάρουμε gia SVD kai PCA to adj R-square gia kathe wra, se diaforetika diagrammata gia ysterisi. 
% Telos grafoume to megalitero adj R-square kathe wras kai tin antisoixi ysterisi gia SVD kai PCA ksexorista kai meta sygkrinoume tin apodosi
% aytwn twn 2 gia na kataliksoume sto kalytero montelo
