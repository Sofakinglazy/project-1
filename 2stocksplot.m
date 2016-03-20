
% a = linspace(-0.5, 0.5, 50);
% b = linspace(-0.5, 0.5, 50);
a = 0:0.05:1;
b = 1:-0.05:0;
for i = 1:21
        risk(i) = 0.023 * a(i)^2 + 0.004* a(i) * b(i) + 0.005 *b(i)^ 2;
end

ret = (0.15 - 0.1)*a+0.1;

figure, clf, 
plot(risk, a, 'LineWidth', 2);
grid on,
title('The Relationship between Risk and Weights');
xlabel('Portfolio Risk');
ylabel('Weight for One of Two Stocks');


figure, clf, 
plot(risk, ret, 'LineWidth', 2);
grid on,
title('The First Two Stock Efficient Frontier');
xlabel('Portfolio Risk');
ylabel('Portfolio Return');

