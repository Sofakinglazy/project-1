function [PRisk, PRoR, PWts] = NaiveMV(ERet, ECov, NPts)
ERet = ERet(:);
NAssets = length(ERet);
Value0 = zeros(NAssets, 1); 
Value1 = ones(1, NAssets);

cvx_begin quiet
variable MaxReturnWeights(NAssets)
    minimize(-ERet' * MaxReturnWeights)
    subject to 
        MaxReturnWeights' * ones(NAssets, 1) == 1;
        MaxReturnWeights >= 0;
cvx_end
% MaxReturnWeights = linprog(-ERet, [], [], Value1, 1, Value0);
MaxReturn = MaxReturnWeights' * ERet;

options = optimset('LargeScale', 'off');
cvx_begin quiet
variable MinVarWeights(NAssets)
    minimize(MinVarWeights' * ECov * MinVarWeights )
    subject to 
        MinVarWeights' * ones(NAssets, 1) == 1;
        MinVarWeights >= 0;
cvx_end


% MinVarWeights = quadprog(ECov, Value0, [], [], Value1, 1, Value0, [], [], options);
MinVarReturn = MinVarWeights' * ERet;
MinVarStd = sqrt(MinVarWeights' * ECov * MinVarWeights);

if MaxReturn > MinVarReturn 
    RTarget = linspace(MinVarReturn, MaxReturn, NPts);
    NumFrontPoints = NPts;
else 
    RTarget = MaxReturn;
    NumFrontPoints = 1;
end 

PRoR = zeros(NumFrontPoints, 1);
PRisk = zeros(NumFrontPoints, 1);
PWts = zeros(NumFrontPoints, NAssets);

PRoR(1) = MinVarReturn;
PRisk(1) = MinVarStd;
PWts(1, :) = MinVarWeights(:)';

A = [Value1; ERet'];
B = [1; 0];

for point = 2:NumFrontPoints
B(2) = RTarget(point); % set the expected return 
Weights = quadprog(ECov, Value0, [], [], A, B, Value0, [], [], options); % under expected return, the minimum risk 
PRoR(point) = dot(Weights, ERet); % dot product to yield the return of portfolio 
PRisk(point) = sqrt(Weights' * ECov * Weights); 
PWts(point, :) = Weights(:)';
end

