function PlotB(m, C, h, mode)

if (nargin < 4)
    mode = '';
end

%% Efficint Frontier with Portfolio Object
figure(h);
plotPortfolio(m, C, h, mode);


%% Two-asset Pair Up
for i = 1 : size(nchoosek(m,2),1)
    [mm, CC] = DecomMatrix(m, C, i);
    plotPortfolio(mm, CC, h, mode);
end

end