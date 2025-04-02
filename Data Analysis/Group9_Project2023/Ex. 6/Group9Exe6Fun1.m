% Mamougiorgi Maria 10533
% Dimitris Christos Kyriakou 10842


function Group9Exe6Fun1(mySeason, filteredData, alpha, L, uniqueHours)

fprintf("SEASON: %d\n\n",mySeason);

% For each hour of the day------------------------------------
for myHour = 1: length(uniqueHours)
    %Data of that SPECIFIC hour & that SPECIFIC Season
    hour_data = filteredData(filteredData.Hour==uniqueHours(myHour) & filteredData.Seasons==mySeason, :);
    x = hour_data.RentedBikeCount;
    y = hour_data.Temperature__C_;  
    r = corr(x,y);
    
    % Discretization Bikes kai Temperature 
    % ginetai sto (MutualInformationXY.m)
    % - k/bins  : the number of bins to split the domain of each variable 
    n = length(x);
    bins = fix(sqrt(n/5)); 

    %DIEYKRINISI: theoro oti to log sto filladio einai to log10(k) kai oxi 
    %             to log(k) tou MATLAB poy oysiastika einai to ln.
    MIC(myHour) = MutualInformationXY(x,y,bins)/log10(bins);

    sigma = r*std(x)*std(y);
    mvn = mvnrnd([mean(x) mean(y)], [std(x)^2 sigma;sigma std(y)^2], n);
    r_mvn = corr(mvn(:,1), mvn(:,2));
    GMIC(myHour) = -0.5*log10(1-r_mvn^2)/log10(bins);

% Scatter diagramms
    figure;
    scatter(x,y);
    hold on;

    t0_MIC = r*sqrt((n-2)/(1-r^2));
    t0_GMIC = r_mvn*sqrt((n-2)/(1-r_mvn^2));
    for j = 1:L
        m = randperm(n);
        xm = x(m);
        ym = y;
        rm = corr(xm,ym);

        %Random GMIC & MIC
        MIC_r(j,myHour) = MutualInformationXY(xm,ym,bins)/log10(bins);
        tMIC(j,myHour) = rm*sqrt((n-2)/(1-rm^2));

        sigma_r = rm*std(xm)*std(ym);
        mvn_r = mvnrnd([mean(xm) mean(ym)], [std(xm)^2 sigma_r;sigma_r std(ym)^2], n);
        r_mvn_r = corr(mvn_r(:,1), mvn_r(:,2));
            
        GMIC_r(j,myHour) = -0.5*log10(1- r_mvn_r^2)/log10(bins);
        tGMIC(j,myHour) = r_mvn_r *sqrt((n-2)/(1- r_mvn_r^2));      
    end 

    %page86
    tMIC = sort(tMIC);
    posMIC = 0;
    [~,posMIC] = min(abs(tMIC-t0_MIC));
    if (posMIC<L*alpha/2 | posMIC>L*(1-alpha/2))
        disp(['MIC is statistically significant for hour ' num2str(myHour-1)]);
        scatter(x,y,'filled','r');
    else
        disp(['MIC is NOT statistically significant for hour ' num2str(myHour-1)]);
    end    

    tGMIC = sort(tGMIC);
    posGMIC = 0;
    [~,posGMIC] = min(abs(tGMIC-t0_GMIC));    
    if (posGMIC<L*alpha/2 | posGMIC>L*(1-alpha/2))
        disp(['GMIC is statistically significant for hour ' num2str(myHour-1)]);
        scatter(x,y,'*','g');
    else
        disp(['GMIC is NOT statistically significant for hour ' num2str(myHour-1)]);
    end
    
    xlabel("Bikes");
    ylabel("Temperature (°C");
    legend("Diaspora","Statistically Important MIC","Statistically Important GMIC");
    title(["SEASON" num2str(mySeason) "Diagramma Diasporas bikes & temperature for hour " num2str(myHour-1)]);
    text(0.05, 0.8, ['r: ' num2str(r)], 'Units', 'normalized');
    text(0.05, 0.75, ['r_ mvn: ' num2str(r_mvn)], 'Units', 'normalized');
    text(0.05, 0.65, ['MIC: ' num2str(MIC(myHour))], 'Units', 'normalized');
    text(0.05, 0.60, ['GMIC: ' num2str(GMIC(myHour))], 'Units', 'normalized');

    hold off;
end
fprintf("\n\n");

end