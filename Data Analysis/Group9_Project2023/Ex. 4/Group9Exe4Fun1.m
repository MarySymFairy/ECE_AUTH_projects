% Mamougiorgi Maria 10533
% Dimitris Christos Kyriakou 10842

function Group9Exe4Fun1(filteredData, season1, season2, uniqueHours)
    warning off;
    rng(1);
    % Set the number of bootstrap samples and confidence level
    B = 1000;
    alpha = 0.05;
    ci = zeros(24, 1);
    nameSeason = {'Winter','Spring','Summer','Autumn'};
    
    for s = 1 : length(uniqueHours) %0-23 hour
        % Instantiate Bikes in 2 diff. Seasons & 1 specific hour of the day
        BikesSeasonOne = filteredData.RentedBikeCount(filteredData.Hour==uniqueHours(s) & filteredData.Seasons==season1);
        BikesSeasonTwo = filteredData.RentedBikeCount(filteredData.Hour==uniqueHours(s) & filteredData.Seasons==season2);
        
        % Bootstrap ci for Median Difference
        bootstrapOne = bootstrp(B, @median, BikesSeasonOne);
        bootstrapTwo = bootstrp(B, @median, BikesSeasonTwo);
        bootstrap_diff = bootstrapOne - bootstrapTwo;
    
        bootstrap_diff = sort(bootstrap_diff);
        k_low = floor((B+1)*alpha/2);
        k_up = B+1-k_low;
    
        %ci = prctile(bootstrap_diff, [k_low*(100/B), k_up*(100/B)]);  %!!!! %[100*alpha/2, 100 - (100*alpha/2)])
        ci(s,1) = bootstrap_diff(k_low);
        ci(s,2) = bootstrap_diff(k_up);
    end
    
    % Ci diagram for Median Difference (statistika simantiki diafora --> if 0 is included in ci)
    figure;
    errorbar(0:23, zeros(24,1), ci(:,1), ci(:,2), '*');
    title(['Season Pair: ' num2str(nameSeason{season1}) ' vs ' num2str(nameSeason{season2})]);
    xlabel('Hour of the Day');
    ylabel('Difference in Medians');
    xticks(0:23);
    xticklabels(uniqueHours);