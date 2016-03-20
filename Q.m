%% Efficient Frontier
m = [0.1 0.2 0.15]';
C = [  0.005 , -0.010, 0.004;
        -0.010, 0.040, -0.002;
        0.004, -0.002, 0.023];
    
h = figure(1);
clf,
PlotP(m, C, h);
legend('Efficient Frontier', 'Random Portfolio');
h = figure(2);
clf,
PlotB(m, C, h, 'scatter');
legend('Three Stocks Frontier', 'Random Portfolio of Three Stocks',...
    'Pair-Up Stocks Frontier', 'Random Portfolio of Pair-Up Stocks', ...
    'Pair-Up Stocks Frontier', 'Random Portfolio of Pair-Up Stocks', ...
    'Pair-Up Stocks Frontier', 'Random Portfolio of Pair-Up Stocks');

%% Get Stock Data

assets = 3; 
seed = rng;
% rng(seed);

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

% Plot Frontior
h = figure(3);clf,
[Bweights] = PlotP(mtr, Ctr, h);

h = figure(4);clf,
PlotB(mtr, Ctr, h);
legend('Three Stocks Frontier', 'Pair-Up Stocks Frontier',...
    'Pair-Up Stocks Frontier', 'Pair-Up Stocks Frontier');

% 1/N Portfolio 

assets = 3; 
weights = ones(1, assets)/assets;

ret = dot(weights, mtr);
risk = sqrt(weights * Ctr * weights');

figure(3), 
plot(risk, ret, 'g*');
legend('Efficient Frontier', '1/N Portfolio');

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

figure(5), clf
scatter(riskBest, retBest, 'b');
hold on, grid on, 
scatter(risk1N, ret1N, 'g*');
title('Frontior on Test Data');
xlabel('Mean Risk');
ylabel('Predicted Return');
legend('Efficient Frontier', '1/N Portfolio');

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

[diff, Index] = sort(diff, 'ascend');
nSimilar = 6; 
Index = Index(1:nSimilar);



%% Sparse Index Tracking Portfolio 

nStep = 100;
tau = linspace(0.01, 0.7, nStep);
w = zeros(cols, nStep);
iNzero = zeros(nStep, 1);
for i=1:nStep
    cvx_begin quiet 
        variable w22( cols );
        minimize( norm(indexData-data * w22) + tau(i)*norm(w22,1) );
        subject to
%             w22 * ones(size(w22))' == 1; 
    cvx_end
    
    w(:, i) = w22;
    
    % Relevant variables 
     iNzero(i, 1) = length(find(abs(w22) > 1e-5));
end 

figure(6), clf,
plot(tau, iNzero, 'k', 'LineWidth', 2);
title('Relation between Number of Non-zeros Weights and Tau');
grid on, grid minor,
xlabel('Tau');
ylabel('Number of Non-zeros Weights');











