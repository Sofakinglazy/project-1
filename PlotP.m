function [W1] = PlotP(m, C, h, mode)

if (nargin < 4)
    mode = '';
end

[V1, M1, W1] = NaiveMV(m, C, 25);

% Plot the figure
figure(h); 
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
if (strcmp(mode,'scatter'))
    figure(h);
    plot(pRisk, pRet, 'rx');
    legend('Frontior', 'Random Portfolio');
end

end