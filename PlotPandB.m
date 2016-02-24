function PlotPandB(m, C)

[V1, M1, ~] = NaiveMV(m, C, 25);

% Plot the figure
h = figure; 
plot(V1, M1, 'b', 'LineWidth', 2);
grid on, hold on,
title('Mean Variance Portfolio', 'FontSize', 13);
xlabel('Portfolio Risk', 'FontSize', 12);
ylabel('Portfolio Return', 'FontSize', 12);

% Generate 100 random portfolios 
nAssets = length(m);
nPortfolios = 1000;
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
figure(h);
plot(pRisk, pRet, 'rx');

%% Efficint Frontier with Portfolio Object
h1 = figure(2);
plotPortfolio(m, C, h1);


%% Two-asset Pair Up
for i = 1 : size(nchoosek(m,2),1)
    [mm, CC] = DecomMatrix(m, C, i);
    plotPortfolio(mm, CC, h1);
end

end