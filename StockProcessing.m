%% Process Stock Data 
% Open the folder 
% Count the numbder of .csv files
% Load all the files 
% Calculate return rate for each stock
% Merge them into a matrix 

function ret = StockProcessing(col)
stockDir = dir('stock');
num = length(stockDir) - 2;
names = {stockDir(3:length(stockDir)).name};

% stock data into a cell
table = cell(num, 1);
for i = 1:num
    table{i} = csvread(fullfile('stock', names{i}));
end

% calculate the min length
min = Inf;
for i = 1:num
    [rows, ~] = size(table{i});
    if rows < min
        min = rows;
    end
end

% get all the close price
close = zeros(min, num);
for i = 1:num
    close(:, i) = table{i}(:, col);
end

% calculate the return rate
ret = zeros(min-1, num);
for i = 1:min-1
    ret(i, :) = (close(i, :) - close(i+1, :))./ close(i+1, :);
end
% adjuct the order 
ret = flip(ret);

end