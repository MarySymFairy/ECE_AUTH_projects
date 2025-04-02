% Mamougiorgi Maria 10533
% Dimitris Christos Kyriakou 10842

function Group9Exe8Fun2(data, uniqueSeasons, myHour)
%Print R-squared for all the Seasons
        fprintf("R-squared of ALL the Seasons for Selected_Hour --> %d\n",myHour);
        nameSeason = {'Winter','Spring','Summer','Autumn'};

    for i = 1:length(uniqueSeasons)
        data_season = data(data.Seasons==uniqueSeasons(i) & data.Hour==myHour, :);

        season_model = fitlm(data_season.Temperature__C_, data_season.RentedBikeCount, 'linear');
        R2 = season_model.Rsquared.Ordinary;

        fprintf("%s(%d): %f\n",nameSeason{i}, uniqueSeasons(i), R2);
    end
    