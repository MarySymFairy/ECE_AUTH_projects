% Mamougiorgi Maria 10533
% Dimitris Christos Kyriakou 10842

function Group9Exe2Fun1(data,i,j)
    % i --> 1st season , j --> 2nd season
    
    M = 1000; % Number of repetitions
    sample_size = 100; % Size of Random Sample
    differences_count = 0; % initialize the counter
    success_count = 0;
    alpha = 0.05;
    rng(1); %for reproducibility

    % Bikes for 2 different Seasons
    subset_first = data(data.Seasons == i, :);
    subset_second = data(data.Seasons == j, :);
    fprintf("----------SEASONS(%d,%d)----------\n",i,j);
    
    % Test for M times
    for k = 1:M
        % Random Sample of 100 from each Season 
        random_first = datasample(subset_first.RentedBikeCount, sample_size, "Replace", false);
        random_second = datasample(subset_second.RentedBikeCount, sample_size, "Replace", false);
          
        % Calculate observed and expected values from histograms
        % observed values --> from 1st season histogram 
        % expected values --> from 2nd season histogram
        [observed_counts, ~] = histcounts(random_first);
        expected_counts = histcounts(random_second, length(observed_counts));
    
        %[h,p,stats] = chi2gof(1:length(observed_counts), 'Frequency', observed_counts, 'Expected', expected_counts)
    
        % Check if the distributions do NOT differ 
        %if (h==0) %(null hypothesis accepted --> distributions)
        %    success_count = success_count + 1;
        %end

        % Perform the chi2 test
        chi2_stat = sum((observed_counts - expected_counts).^2 ./ expected_counts);
            
        % Check if the distributions differ
        if chi2_stat >= chi2inv(1 - alpha, length(observed_counts) - 1)
            differences_count = differences_count + 1;
        end
    end

    % Calculate the percentage of times the distributions do not differ
    %percentage_no_difference = 100 * (success_count / M);
    percentage_no_difference = 100*(M - differences_count) / M ;


    fprintf("Observed values: season %d    ",i);
    fprintf("Expected values: season %d\n",j);
    fprintf("Percentage of times the distributions do NOT differ: %f\n\n",percentage_no_difference);

end