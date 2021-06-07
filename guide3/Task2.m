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

% Delay
S = C * 1000000;

ES = ((0.16 * 64) + (0.25 * 110) + (0.2 * 1518) + ... 
    (0.39/length(aux)) *sum(aux)) * 8 / S;
ES2 = ((0.16 * (64*8/S)^2) + (0.25 * (110*8/S)^2) + (0.2 * (1518*8/S)^2) ...
    + (0.39/length(aux))*(sum((aux*8/S).^2)));

% WQ = lambda*E[S^2]/2(1-lambdaE[s]) + E[s]
WQ = ((lambda * ES2)/(2 * (1 - (lambda * ES))))*1000;

Wi_64 = WQ + ((8*64)/S)*1000;
Wi_110 = WQ + ((8*110)/S)*1000;
Wi_1518 = WQ + ((8*1518)/S)*1000;

APD_num = (0.16 * Pi_64 * Wi_64) + (0.25 * Pi_110 * Wi_110) ...
    + (0.2 * Pi_1518 * Wi_1518);

APD_den = (0.16 * Pi_64) + (0.25 * Pi_110) + (0.2 * Pi_1518);

APD_num_aux = 0;
APD_den_aux = 0;
for i=1:length(aux)
    Pi_aux = (1 - b)^(8*aux(i));
    Wi_aux = WQ + ((8*aux(i))/S)*1000;
    APD_num_aux = APD_num_aux + ((0.39/length(aux)) * Pi_aux * Wi_aux);
    APD_den_aux = APD_den_aux + ((0.39/length(aux)) * Pi_aux);
end

PacketDelay = (APD_num + APD_num_aux)/(APD_den + APD_den_aux);

% Throughput

Throughput = (0.16 * Pi_64 * lambda * (8 * 64)) ...
    + (0.25 * Pi_110 * lambda * (8 * 110)) ...
    + (0.2 * Pi_1518 * lambda * (8 * 1518));

Throughput_aux = 0;

for i=1:length(aux)
    Pi_aux = (1 - b)^(8*aux(i));
    Throughput_aux = Throughput_aux + ...
        ((0.39/length(aux)) * Pi_aux * lambda * (8 * aux(i)));
end

Throughput = (Throughput + Throughput_aux) * 1e-6;

fprintf('\n2c\n');
fprintf('PacketLoss (%%) = %.4f \n', PacketLoss*100);
fprintf('Av. Packet Delay (ms) = %.4f \n', PacketDelay);
fprintf('Throughput (Mbps): %.4f \n', Throughput);

%% 2d)

% Parameters
lambda = 1800; %packet rate
C = 10; %conection capacity
f = 1000000; %queue size
b = 10^-5; %bit error rate

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

% Delay
S = C * 1000000;

ES = ((0.16 * 64) + (0.25 * 110) + (0.2 * 1518) + ... 
    (0.39/length(aux)) *sum(aux)) * 8 / S;
ES2 = ((0.16 * (64*8/S)^2) + (0.25 * (110*8/S)^2) + (0.2 * (1518*8/S)^2) ...
    + (0.39/length(aux))*(sum((aux*8/S).^2)));

% WQ = lambda*E[S^2]/2(1-lambdaE[s]) + E[s]
WQ = ((lambda * ES2)/(2 * (1 - (lambda * ES))))*1000;

Wi_64 = WQ + ((8*64)/S)*1000;
Wi_110 = WQ + ((8*110)/S)*1000;
Wi_1518 = WQ + ((8*1518)/S)*1000;

APD_num = (0.16 * Pi_64 * Wi_64) + (0.25 * Pi_110 * Wi_110) ...
    + (0.2 * Pi_1518 * Wi_1518);

APD_den = (0.16 * Pi_64) + (0.25 * Pi_110) + (0.2 * Pi_1518);

APD_num_aux = 0;
APD_den_aux = 0;
for i=1:length(aux)
    Pi_aux = (1 - b)^(8*aux(i));
    Wi_aux = WQ + ((8*aux(i))/S)*1000;
    APD_num_aux = APD_num_aux + ((0.39/length(aux)) * Pi_aux * Wi_aux);
    APD_den_aux = APD_den_aux + ((0.39/length(aux)) * Pi_aux);
end

PacketDelay = (APD_num + APD_num_aux)/(APD_den + APD_den_aux);

% Throughput

Throughput = (0.16 * Pi_64 * lambda * (8 * 64)) ...
    + (0.25 * Pi_110 * lambda * (8 * 110)) ...
    + (0.2 * Pi_1518 * lambda * (8 * 1518));

Throughput_aux = 0;

for i=1:length(aux)
    Pi_aux = (1 - b)^(8*aux(i));
    Throughput_aux = Throughput_aux + ...
        ((0.39/length(aux)) * Pi_aux * lambda * (8 * aux(i)));
end

Throughput = (Throughput + Throughput_aux) * 1e-6;

fprintf('\n2d\n');
fprintf('PacketLoss (%%) = %.4f \n', PacketLoss*100);
fprintf('Av. Packet Delay (ms) = %.4f \n', PacketDelay);
fprintf('Throughput (Mbps): %.4f \n', Throughput);