%% Efficient Frontier
m = [0.1 0.2 0.15]';
C = [  0.005 , -0.010, 0.004;
        -0.010, 0.040, -0.002;
        0.004, -0.002, 0.023];
    
h = figure(1);
PlotP(m, C, h, 'scatter');
h = figure(2);
PlotB(m, C, h);

%% Get Stock Data

assets = 3; 
seed = rng;
%rng(seed);

colClosePrice = 4;
data = StockProcessing(colClosePrice);

[rows, cols] = size(data); 
index = randperm(cols, assets);
trData = data(1: rows/2, :);
teData = data(rows/2+1 : end, :);

mtr = mean(trData(:, index))';
Ctr = cov(trData(:, index));
mte = mean(teData(:, index))';
Cte = cov(teData(:, index));

%% Plot Frontior
h = figure(3);
[Bweights] = PlotP(mtr, Ctr, h);
h = figure(4);
PlotB(mtr, Ctr, h);

% 1/N Portfolio 

assets = 3; 
weights = ones(1, assets)/assets;

ret = dot(weights, mtr);
risk = sqrt(weights * Ctr * weights');

figure(3), 
plot(risk, ret, 'g*');

% Compare 1/N Portfolio with Best Portfolio

ret1N = dot(weights, mte);
risk1N = sqrt(weights * Cte * weights');

[nBWeights, ~] = size(Bweights);
retBest = zeros(nBWeights, 1);
riskBest = zeros(nBWeights, 1);
for i=1:nBWeights
    retBest(i) = dot(Bweights(i, :), mte); 
    riskBest(i) = sqrt(Bweights(i, :) * Cte * Bweights(i, :)');
end

figure(5),
scatter(riskBest, retBest, 'b');
hold on, grid on, 
scatter(risk1N, ret1N, 'g*');
title('Frontior on Test Data');
xlabel('Mean Risk');
ylabel('Predicted Return');

% Evaluate Performance of Above Portfolios


%% Index Tracking 

rawData = csvread('stock.csv');
rawData = rawData(:, 4);
rawData = flip(rawData);
[rows, ~] = size(rawData);
indexData = zeros(rows - 1, 1);
for i = 1: rows-1
   indexData(i, :) = (rawData(i+1, :)-rawData(i, :))/rawData(i, :);
end

diff = zeros(1, size(data, 2));
for i = 1: size(data, 2)
    diff(1, i) = norm(indexData - data(:, i));
end

min(diff)









