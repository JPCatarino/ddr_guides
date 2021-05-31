%% 2a)
% Parameters
n_runs = 20;
P = 10000; %stoping criterion
alpha = 0.10; %confidence intervals
lambda = 1800; %packet rate
C = 10; %conection capacity
f = 1000000; %queue size
b = 10^-6; %bit error rate

[medias_PL, temp_PL , medias_APD, temp_APD , medias_MDP, temp_MDP , medias_TT, temp_TT] = ...
    runSimulator2(n_runs, alpha, lambda, C, f, P,b);

fprintf('\n2a\n');

fprintf('PacketLoss (%%) = %.2e +- %.2e\n', medias_PL, temp_PL);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n', medias_APD, temp_APD);
fprintf('Max. Packet Delay (ms) = %.2e +- %.2e\n', medias_MDP, temp_MDP);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n', medias_TT, temp_TT);

%% 2b)
% Parameters
n_runs = 20;
P = 10000; %stoping criterion
alpha = 0.10; %confidence intervals
lambda = 1800; %packet rate
C = 10; %conection capacity
f = 1000000; %queue size
b = 10^-5; %bit error rate

[medias_PL, temp_PL , medias_APD, temp_APD , medias_MDP, temp_MDP , medias_TT, temp_TT] = ...
    runSimulator2(n_runs, alpha, lambda, C, f, P,b);

fprintf('\n2b\n');

fprintf('PacketLoss (%%) = %.2e +- %.2e\n', medias_PL, temp_PL);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n', medias_APD, temp_APD);
fprintf('Max. Packet Delay (ms) = %.2e +- %.2e\n', medias_MDP, temp_MDP);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n', medias_TT, temp_TT);

%% 2c)
% Parameters
P = 10000; %stoping criterion
alpha = 0.10; %confidence intervals
lambda = 1800; %packet rate
C = 10; %conection capacity
f = 1000000; %queue size
b = 10^-6; %bit error rate








%% 2d)