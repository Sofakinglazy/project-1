function plotPortfolio(m, C, h, mode)

if (nargin < 4)
    mode = '';
end

p = Portfolio;
p = Portfolio(p, 'AssetMean', m, 'AssetCovar', C);
p = Portfolio(p, 'lowerbound', zeros(size(m)));
p = Portfolio(p, 'aEquality', ones(size(m))','bEquality', 1);

figure(h),
plotFrontier(p);
% axis([0.02, 0.2, 0.12, 0.2]);
hold on, grid on,

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
     figure(h),
     plot(pRisk', pRet, 'x');
end

end