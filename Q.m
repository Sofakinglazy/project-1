%% Efficient Frontier
m = [0.1 0.2 0.15]';
C = [  0.005 , -0.010, 0.004;
        -0.010, 0.040, -0.002;
        0.004, -0.002, 0.023];
    
PlotPandB(m, C);

%% Analyse Stock Data

colClosePrice = 4;
data = StockProcessing(colClosePrice);

[~, cols] = size(data); 
index = randperm(cols, 3);
m = mean(data(:, index))';
C = cov(data(:, index));

PlotPandB(m, C);
