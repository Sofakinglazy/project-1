%% Efficient Frontier
m = [0.1 0.2 0.15]';
C = [  0.005 , -0.010, 0.004;
        -0.010, 0.040, -0.002;
        0.004, -0.002, 0.023];
    
[V1, M1, PWts1] = NaiveMV(m, C, 25);

% Plot the figure
figure(1), clf,
plot(V1, M1, 'b', 'LineWidth', 2);
grid on, hold on,
title('Mean Variance Portfolio', 'FontSize', 13);
xlabel('Portfolio Risk', 'FontSize', 12);
ylabel('Portfolio Return', 'FontSize', 12);

% Generate 100 random portfolios 
nAssets = length(m);
nPortfolios = 100;
weights = zeros(nAssets, nPortfolios);
for i = 1: nPortfolios
    weights(:, i) = rand(1, nAssets);
    weights(:, i) = weights(:, i)/sum(weights(:, i));
end

% Calculate return for random portfolios
pRet = zeros(nPortfolios, 1);
pRisk = zeros(nPortfolios, 1);
for i = 1: nPortfolios
    pRet(i) = dot(weights(:, i), m);
    pRisk(i) = sqrt(weights(:, i)' * C * weights(:, i));
end

% Plot the scatter
figure(1),
plot(pRisk, pRet, 'rx');

%% Efficint Frontier with Portfolio Object
m = [0.1 0.2 0.15]';
C = [  0.005, -0.010, 0.004;
        -0.010, 0.040, -0.002;
        0.004, -0.002, 0.023];
plotPortfolio(m, C);

%% Two-asset Pair Up
mm = [0.1, 0.2]';
CC = [  0.005, -0.010;
        -0.010, 0.040];
plotPortfolio(mm, CC);

mm = [0.2, 0.15]';
CC = [  0.040, -0.002;
        -0.002, 0.023]; 
plotPortfolio(mm, CC);

mm = [0.10, 0.15]';
CC = [  0.005, 0.004;
        0.004, 0.023]; 
plotPortfolio(mm, CC);
