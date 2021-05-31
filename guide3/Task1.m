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
lambda = 1800; %packet rate
C = 10; %conection capacity
f = 1000000; %queue size

% 16% for 64 bytes, 25% for 110 bytes, 20% for 1518 bytes,
% 39& for the rest

aux= [65:109 111:1517];

% B = sum(prob * S)
AveragePacketSize = ((0.16 * 64) + (0.25 * 110) + (0.2 * 1518) + ...
    ((sum(aux)*0.39)/length(aux)))*8;

% mu = C / B
u = (C * 1000000)/AveragePacketSize ;   % Mbps

% packet delay = 1/mu - lambda
PacketDelay = 1 / (u - lambda) * 1000;

%Throughput = 10-6 * TRANSMITTEDBYTES * 8
Throughput = 1e-6 * (lambda*AveragePacketSize);

% Packet Loss is 0 since queue is basically infinite
fprintf('\n1c\n');
fprintf('PacketLoss (%%) = %.5f \n', 0);
fprintf('Av. Packet Delay (ms) = %.5f \n', PacketDelay);
fprintf('Throughput (Mbps): %.5f \n', Throughput);

%% 1d)

% Parameters
lambda = 1800; %packet rate
C = 10; %conection capacity
f = 1000000; %queue size

% 16% for 64 bytes, 25% for 110 bytes, 20% for 1518 bytes,
% 39& for the rest

aux= [65:109 111:1517];

S = C * 1000000;

ES = ((0.16 * 64) + (0.25 * 110) + (0.2 * 1518) + ... 
    (0.39/length(aux)) *sum(aux)) * 8 / S;
ES2 = ((0.16 * (64*8/S)^2) + (0.25 * (110*8/S)^2) + (0.2 * (1518*8/S)^2) ...
    + (0.39/length(aux))*(sum((aux*8/S).^2)));

% W = lambda*E[S^2]/2(1-lambdaE[s]) + E[s]
PacketDelay = ((lambda * ES2)/(2 * (1 - (lambda * ES)))+ES)*1000;

%Throughput = 10-6 * TRANSMITTEDBYTES * 8
Throughput = 1e-6 * (lambda*AveragePacketSize);

% Packet Loss is 0 since queue is basically infinite
fprintf('\n1d\n');
fprintf('PacketLoss (%%) = %.5f \n', 0);
fprintf('Av. Packet Delay (ms) = %.5f \n', PacketDelay);
fprintf('Throughput (Mbps): %.5f \n', Throughput);

%% 1 e)

% Parameters
lambda = 1800; %packet rate
C = 10 * 1000000; %conection capacity
f = 10000*8; %queue size

% 16% for 64 bytes, 25% for 110 bytes, 20% for 1518 bytes,
% 39& for the rest

aux= [65:109 111:1517];

% B = sum(prob * S)
AveragePacketSize = ((0.16 * 64) + (0.25 * 110) + (0.2 * 1518) + ...
    ((sum(aux)*0.39)/length(aux)))*8;

m = round((f/AveragePacketSize))+1;

% mu = C / B
u = C/AveragePacketSize;   % Mbps
% (lamda/mu)^m/sum((lamda/mu)^j)
den = 0;
for j = 0:m
    den = den + (lambda/u)^j;
end
PacketLoss = (((lambda/u)^(m))/den)*100;

num_aux = 0;

for i = 0:m
    num_aux = num_aux + (i * ((lambda/u)^i));
end

L = num_aux/den;

PacketDelay = L/(lambda*(1 - (PacketLoss/100)))*1000;

%Throughput = 10-6 * TRANSMITTEDBYTES * 8
Throughput = (1e-6 * ((lambda*AveragePacketSize)-(lambda*AveragePacketSize*(PacketLoss/100))));

fprintf('\n1e\n');
fprintf('PacketLoss (%%) = %.5f \n', PacketLoss);
fprintf('Av. Packet Delay (ms) = %.5f \n', PacketDelay);
fprintf('Throughput (Mbps): %.5f \n', Throughput);



