function [mm, CC] = DecomMatrix(m, C, indices)
 
[choices, ~] = size(nchoosek(m, 2));

if indices > choices
    error('indices excess maximum');
end

% construct a new index vector
series = 1:choices;
index = nchoosek(series, 2);
mAll = [m(index(1, 1)), m(index(1, 2))];
CAll = [C(index(1, 1), index(1, 1)), C(index(1, 1), index(1, 2));
        C(index(1, 2), index(1, 1)), C(index(1, 2), index(1, 2))];
for i = 2 : choices
        mAll = [mAll; m(index(i, 1)), m(index(i, 2))];
        CTemp = [C(index(i, 1), index(i, 1)), C(index(i, 1), index(i, 2));
                C(index(i, 2), index(i, 1)), C(index(i, 2), index(i, 2))];
        CAll = [CAll; CTemp];
end

mm = mAll(indices, :)';
rStart = 2 * indices - 1;
rEnd = rStart + 1;
CC = CAll(rStart: rEnd, :);
    
end



