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
lambda = 1800; %packet rate
C = 10; %conection capacity
f = 1000000; %queue size
b = 10^-6; %bit error rate

% sum(pi * (1 - Pi))
Pi_64 = (1 - b)^(8*64);
Pi_110 = (1 - b)^(8*110);
Pi_1518 = (1 - b)^(8*1518);
PacketLoss = (0.16*(1 - Pi_64)) + (0.25 * (1 - Pi_110)) ...
    + (0.20 * (1 - Pi_1518)); 

aux= [65:109 111:1517];
PacketLoss_aux = 0;
for i=1:length(aux)
    Pi_aux = (1 - b)^(8*aux(i));
    PacketLoss_aux = PacketLoss_aux + (0.39*(1 - Pi_aux));
end

PacketLoss_aux = PacketLoss_aux / length(aux);

PacketLoss = PacketLoss + PacketLoss_aux;

fprintf('\n2c\n');
fprintf('PacketLoss (%%) = %.5f \n', PacketLoss*100);






%% 2d)