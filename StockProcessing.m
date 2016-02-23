%% Process Stock Data 
% Open the folder 
% Count the numbder of .csv files
% Load all the files 
% Calculate return rate for each stock
% Merge them into a matrix 

function StockProcessing()
stockDir = dir('stockPrice');
num = length(stockDir) - 2;
names = {stockDir(3:length(stockDir)).name};


table = cell(num, 1);
for i = 1:num
    table{i} = csvread(fullfile('stockPrice', names{i}));
end

end

