% Mamougiorgi Maria 10533
% Dimitris Christos Kyriakou 10842

function Group9Exe1Fun1(data, mySeason, nameSeason)
    warning off;
    % Create a RentedBikeCount column vector of mySeason
    subset = data(data.Seasons == mySeason, :);
    BikesSeason = subset.RentedBikeCount;

    % All the known distributions from the Documentation of "fitdist"
    distributions = {'Beta','Binomial','BirnbaumSaunders','Burr','Exponential','Extreme Value','Gamma','Generalized Extreme Value','Generalized Pareto','Half Normal','InverseGaussian','Kernel','Logistic','Loglogistic','Lognormal','Nakagami','Negative Binomial','Normal','Poisson','Rayleigh','Rician','Stable','tLocationScale','Weibull'};
    
    % organised print
    fprintf("\n----------------------------DISTRIBUTIONS OF %s---------------------------------\n",nameSeason);

    % (try-catch) to catch and print the errors
    p = zeros(length(distributions), 1);
    for i=1:length(distributions) %24 times
        try
            subset_fit = fitdist(BikesSeason, distributions{i});
            %katanomi pithanotitas --> CDF
            [~,p(i)] = chi2gof(BikesSeason,'CDF',subset_fit);
            fprintf("%s --> %f \n",distributions{i},p(i));
        catch ERR
            fprintf("%s --> ERROR: %s\n",distributions{i},ERR.message);
        end
    end


    % Find the maximum probability --> p-value from chi2gof
    p_max = 0;
    for i=1:length(distributions)
        if (p(i) > p_max)
            distribution_max = distributions{i};
            p_max = p(i);
        end
    end 
    fprintf ("Η κατάλληλη γνωστή παραμετρική κατανομή που ταιριάζει: %s με %f ποσοστό.\n\n", distribution_max, p_max*100);
    

    % Histogram of the Season
    figure;
    histogram(BikesSeason);
    title ([num2str(nameSeason) ' BIKES']);


end