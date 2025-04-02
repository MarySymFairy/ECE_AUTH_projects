% Mamougiorgi Maria 10533
% Dimitris Christos Kyriakou 10842

function Group9Exe3Fun1(average_differences, p_values, uniqueHours, num_hours, uniqueSeason)
    
    figure;
    subplot(1,2,1);
    imagesc(average_differences);
    colorbar;
    title(['Average Differences in Bikes for Season ' num2str(uniqueSeason)]);
    xlabel('Hour');
    ylabel('Hour');
    % More precise 
    xticks(1:num_hours);
    yticks(1:num_hours);
    xticklabels(uniqueHours);
    yticklabels(uniqueHours);
    
    subplot(1,2,2);
    imagesc(p_values); % Show the p-values in the same figure
    colorbar;
    title(['p-values for Season ' num2str(uniqueSeason)]);
    xlabel('Hour');
    ylabel('Hour');
    % More precise 
    xticks(1:num_hours);
    yticks(1:num_hours);
    xticklabels(uniqueHours);
    yticklabels(uniqueHours);

end