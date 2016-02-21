T = 150;
N = 50;
R = randn(T, N); % each col follows normal distribution
rho = 0.02; % expected return
tau = 10; % regularization para
mu = randn(N, 1);

cvx_begin quiet
variable w(N)
    minimize( norm(rho * ones(T, 1) - R * w)^2 + tau * norm(w, 1))
     subject to 
         w' * ones(N, 1) == 1;
          w' * mu == rho;
          w > 0;
cvx_end

figure(1), clf, 
bar(w); 
grid on;

