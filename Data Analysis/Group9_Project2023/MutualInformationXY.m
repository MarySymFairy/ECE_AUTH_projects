function mutS = MutualInformationXY(xV,yV,bins)
% mut = MutualInformationXY(xV,yV,bins)
% This function computes the mutual information between two variables
% given as input column vectors 'xV' and 'yV'. The probabilities are 
% evaluated partitioning the domain and the number of bins in 
% one dimension is given by 'bins'.
% The output is the mutual information value.
% If 'bins' is not specified is is set to fix(sqrt(n/5)), where
% 'n' is the sample size. 
% INPUT:
% - xV      : sample vector of the one variable
% - yV      : sample vector of the other variable
% - bins    : the number of bins to split the domain of each variable
% OUTPUT:
% - mutS    : the mutual information
xV = xV(:);
yV = yV(:);
n = length(xV);
if n~=length(yV) 
    error('The two input vectors must have the same length.');
end
xM = [xV yV];
m = 2;
if nargin==2
    bins =  fix(sqrt(n/5));
end
% Normalise each of the two variables 
xminV = min(xM);
[xmaxV,imaxV] = max(xM);
for j=1:m
    xM(imaxV(j),j) = xmaxV(j) + (xmaxV(j)-xminV(j))*10^(-10); % To avoid multiple exact maxima
end
yM = (xM-ones(n,1)*xminV)./(ones(n,1)*(xmaxV-xminV));
arrayM = floor(yM*bins)+1; % Array of bins: 1,...,bins
for j=1:m
    arrayM(imaxV(j),j) = bins; % Set the maximum in the last partition
end

h1V = zeros(bins,1);  % for p(x)
h2V = zeros(bins,1);  % for p(y)
h12M = zeros(bins,bins);  % for p(x,y)
mutS = 0;
for i=1:bins
    for j=1:bins
        h12M(i,j) = length(find(arrayM(:,1)==i & arrayM(:,2)==j));
    end
end
for i=1:bins
    h1V(i) = sum(h12M(i,:));
    h2V(i) = sum(h12M(:,i));
end
for i=1:bins
    for j=1:bins
        if h12M(i,j) > 0
            mutS=mutS+(h12M(i,j)/n)*log(h12M(i,j)*n/(h1V(i)*h2V(j)));
        end
    end
end