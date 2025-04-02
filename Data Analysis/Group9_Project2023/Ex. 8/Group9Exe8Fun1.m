% Mamougiorgi Maria 10533
% Dimitris Christos Kyriakou 10842

function Group9Exe8Fun1(data, season1, season2, uniqueSeasons, myHour)
    
    %warning off;
    nameSeason = {'Winter','Spring','Summer','Autumn'};
    
    %Filter my data for the specific Season & hour
    data_season1 = data(data.Seasons==season1 & data.Hour==myHour, :);
    data_season2 = data(data.Seasons==season2 & data.Hour==myHour, :);
    
    linear_season1 = fitlm(data_season1.Temperature__C_ , data_season1.RentedBikeCount, 'linear');
    R2_season1 = linear_season1.Rsquared.Ordinary;    
    linear_season2 = fitlm(data_season2.Temperature__C_ , data_season2.RentedBikeCount, 'linear');
    R2_season2 = linear_season2.Rsquared.Ordinary;
    
    fprintf("------------- %s(%d) vs %s(%d)----------------\n",nameSeason{season1}, uniqueSeasons(season1), nameSeason{season2}, uniqueSeasons(season2));        

    R2_difference = R2_season1-R2_season2;
    
%BOOTSTRAP (page 59-61 of Notes)-----------------------------------------------------
    % like the difference of means --> x=season1 and y=season2 
    % (and internally x=temperature and y=Bikes)
    B = 1000; %samples
    M = 100;
    alpha = 0.05;         
    rng(1); %for reproducibility

    % Create B samples for each Season & find their correlation values
    bootstatR2_season1 = bootstrp(B, @(x) fitlm(x.Temperature__C_, x.RentedBikeCount, 'linear').Rsquared.Ordinary, data_season1);
    bootstatR2_season2 = bootstrp(B, @(x) fitlm(x.Temperature__C_, x.RentedBikeCount, 'linear').Rsquared.Ordinary, data_season2);
   
    % Difference of R-squared --> find the confidence interval
    bootstat_difference = bootstatR2_season1 - bootstatR2_season2;
    bootstat_difference = sort(bootstat_difference);

    k = floor((B+1)*alpha/2);
    ci(1) = bootstat_difference(k);
    ci(2) = bootstat_difference(B+1-k); 

    % Elegxos statistikis simantikothtas - null hypothesis: 
    fprintf("Difference of R-squared: [%f , %f]\n",ci(1), ci(2));
    if (ci(1)<0 && ci(2)>0)
        fprintf('R-squared δεν διαφέρουν σημαντικά (Περιλαμβάνεται το 0 στο δ.ε.)\n\n');
    else
        fprintf('R-squared διαφέρουν σημαντικά\n\n');
    end

% m = length(data_season1.RentedBikeCount); %megethos season1
% n = length(data_season2.RentedBikeCount); %megethos season2
%    for i = 1:B       
        %bootstat_season1 = datasample(data_season1, m , 'Replace',true);
        %bootstat_season2 = datasample(data_season2, n, 'Replace',true);

        %bootstat_bikes1 = bootstat_season1.RentedBikeCount;
        %bootstat_bikes2 = bootstat_season2.RentedBikeCount;
        %bootstat_temp1 = bootstat_season1.Temperature__C_;
        %bootstat_temp2 = bootstat_season2.Temperature__C_;

        % R-squared of bootstrap 
        %model1 = fitlm(bootstat_temp1, bootstat_bikes1, 'linear');
        %model2 = fitlm(bootstat_temp2, bootstat_bikes2, 'linear');
        %bootstatR2_season1(i) = model1.Rsquared.Ordinary; 
        %bootstatR2_season2(i) = model2.Rsquared.Ordinary;        
%    end