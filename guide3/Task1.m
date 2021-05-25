%% 1 a)

% Parameters
n_runs = 10;
P = 10000; %stoping criterion
alpha = 0.10; %confidence intervals
lambda = 1800; %packet rate
C = 10; %conection capacity
f = 1000000; %queue size

[medias_PL, temp_PL , medias_APD, temp_APD , medias_MDP, temp_MDP , medias_TT, temp_TT] = runSimulator(n_runs, alpha, lambda, C, f, P);

fprintf('1a\n')
fprintf('PacketLoss (%%) = %.2e +- %.2e\n', medias_PL, temp_PL);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n', medias_APD, temp_APD);
fprintf('Max. Packet Delay (ms) = %.2e +- %.2e\n', medias_MDP, temp_MDP);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n', medias_TT, temp_TT);

%% 1b)
% Parameters
n_runs = 10;
P = 10000; %stoping criterion
alpha = 0.10; %confidence intervals
lambda = 1800; %packet rate
C = 10; %conection capacity
f = 10000; %queue size

[medias_PL, temp_PL , medias_APD, temp_APD , medias_MDP, temp_MDP , medias_TT, temp_TT] = runSimulator(n_runs, alpha, lambda, C, f, P);

fprintf('\n1b\n');

fprintf('PacketLoss (%%) = %.2e +- %.2e\n', medias_PL, temp_PL);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n', medias_APD, temp_APD);
fprintf('Max. Packet Delay (ms) = %.2e +- %.2e\n', medias_MDP, temp_MDP);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n', medias_TT, temp_TT);

%% 1c)

% Parameters
n_runs = 10;
P = 10000; %stoping criterion
alpha = 0.10; %confidence intervals
lambda = 1800; %packet rate
C = 10; %conection capacity
f = 1000000; %queue size

lambda2 = lambda ; 
u = (C * 1000 / f); 

% 16% for 64 bytes, 25% for 110 bytes, 20% for 1518 bytes,
% 39& for the rest

AveragePacketSize = (0.16 * 1 + 0.25 * 2 + 0.2 * 3 + 0.39 * 4) / 5 ;
% packet delay
PacketDelay = 1 / (u - lambda2);
Sum = 0;

for i = 1:(P-1)
   Sum = Sum + (lambda2 / u) ^ i; 
end

PacketLoss = ((lambda2/u)^(P-1)) / Sum;

fprintf('\n1c\n');
fprintf('PacketLoss (%%) = %.5 \n', PacketLoss);
fprintf('Av. Packet Delay (ms) = %.5 \n', PacketDelay);

