% Mamougiorgi Maria 10533
% Dimitris Christos Kyriakou 10842

function Group9Exe5Fun1(filteredData, season, uniqueSeasons, uniqueHours)

    nameSeason = {'Winter','Spring','Summer','Autumn'};

    alpha = 0.05; 
    max_rho = 0;

    % Season subset table of filteredData
    season_data = filteredData(filteredData.Seasons==uniqueSeasons(season), :);
    fprintf("Season: %s \n", nameSeason{season});
        
    %significant_hours is an empty array that will contain the hours for 
    % which the p_value will be less than alpha = 0.05
    significant_hours = [];

    for h=1:length(uniqueHours)
        %Bikes for a specific Hour of the Season
        Bikes = season_data.RentedBikeCount(season_data.Hour==uniqueHours(h));
        %Temperature for a specific Hour of the Season
        Temperature = season_data.Temperature__C_(season_data.Hour==uniqueHours(h));
    
        % Pearson Coefficient for Bikes and Temperature (for the same hour of the season)
        [r, p] = corrcoef(Bikes, Temperature);
        rho(h) = r(1,2);
        p_values(h) = p(1,2);

        %Max Correlation Coefficient of each Season
        if (rho(h) > max_rho)
            max_rho = rho(h);
            max_hour = h;
        end

        if (p_values(h) < alpha)
            significant_hours = [significant_hours; h];
        end

        fprintf("Hour: %d --> correlation_coefficient: %f --> p_value: %f  \n", uniqueHours(h),rho(h),p_values(h));        
    end

    fprintf("Max correlation_coefficient for Season %s: %f -->%d hour!",nameSeason{season}, max_rho, max_hour);
    fprintf("\n\n");
    
    % Correlation Coefficient Pearson & Significance Test(p-value)
    figure;
    plot(rho, 'o-');
    title(['Season ' num2str(uniqueSeasons(season))]);
    xlabel('Hour of the Day');
    ylabel('Pearson Correlation Coefficient');
    grid on; %plegma

    % Highlight statistically significant correlations
    hold on;
    scatter(significant_hours, rho(significant_hours), 'r', 'filled');
    legend('Non-Significant correlations');%, 'Significant correlations' ,'wtf','significant correlations');
    xticks(1:length(uniqueHours));
    xticklabels(uniqueHours);
    hold off;

    subtitle("Significant correlations --> red dots");