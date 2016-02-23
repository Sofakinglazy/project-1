
% a = linspace(-0.5, 0.5, 50);
% b = linspace(-0.5, 0.5, 50);
a = 0:0.05:1;
b = 1:-0.05:0;
for i = 1:21
        risk(i) = 5 * a(i)^2 - 20 * a(i) * b(i) + 40 *b(i) .^ 2;
end

figure,
plot(a, risk);

