%% 3a)
% Parameters
n_runs = 10;
P = 10000; %stoping criterion
alpha = 0.10; %confidence intervals
lambda_values = [1500, 1600, 1700, 1800, 1900, 2000]; %packet rate
C = 10; %conection capacity
f = 10000000; %queue size
b = 0; %bit error rate

% Results arrays
sz = length(lambda_values);
medias_PL = zeros(1, sz);
temp_PL = zeros(1, sz);
medias_APD = zeros(1, sz);
temp_APD = zeros(1, sz);
medias_MDP = zeros(1, sz);
temp_MDP = zeros(1, sz);
medias_TT = zeros(1, sz);
temp_TT = zeros(1, sz);

% Run simulator n times for each value of lambda
for i = 1:sz
    [medias_PL(i), temp_PL(i) , medias_APD(i), temp_APD(i), ...
     medias_MDP(i), temp_MDP(i) , medias_TT(i), temp_TT(i)] = ...
    runSimulator2(n_runs, alpha, lambda_values(i), C, f, P,b);
end

figure(1)
tiledlayout(2,2)
% Packet Loss
nexttile;
bar(lambda_values,medias_PL) 
title("Packet Loss (%)")
xlabel('\lambda (packets/second)')
ylim([0 100])
grid on

hold on

er = errorbar(lambda_values, medias_PL, temp_PL);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

% Average Packet Delay
nexttile;
bar(lambda_values,medias_APD)    
title("Average Packet Delay (ms)")
xlabel('\lambda (packets/second)')
grid on

hold on

er = errorbar(lambda_values, medias_APD, temp_APD);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

% Max Packet Delay
nexttile;
bar(lambda_values,medias_MDP)    
title("Max Packet Delay (ms)")
xlabel('\lambda (packets/second)')
grid on

hold on

er = errorbar(lambda_values, medias_MDP, temp_MDP);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

% Throughput
nexttile;
bar(lambda_values,medias_TT)    
title("Throughput (Mbps)")
xlabel('\lambda (packets/second)')
grid on

hold on

er = errorbar(lambda_values, medias_TT, temp_TT);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

%% 3b)
% Parameters
n_runs = 40;
P = 10000; %stoping criterion
alpha = 0.10; %confidence intervals
lambda_values = [1500, 1600, 1700, 1800, 1900, 2000]; %packet rate
C = 10; %conection capacity
f = 10000000; %queue size
b = 0; %bit error rate

% Results arrays
sz = length(lambda_values);
medias_PL = zeros(1, sz);
temp_PL = zeros(1, sz);
medias_APD = zeros(1, sz);
temp_APD = zeros(1, sz);
medias_MDP = zeros(1, sz);
temp_MDP = zeros(1, sz);
medias_TT = zeros(1, sz);
temp_TT = zeros(1, sz);

% Run simulator n times for each value of lambda
for i = 1:sz
    [medias_PL(i), temp_PL(i) , medias_APD(i), temp_APD(i), ...
     medias_MDP(i), temp_MDP(i) , medias_TT(i), temp_TT(i)] = ...
    runSimulator2(n_runs, alpha, lambda_values(i), C, f, P,b);
end

figure(2)
tiledlayout(2,2)
% Packet Loss
nexttile;
bar(lambda_values,medias_PL) 
title("Packet Loss (%)")
xlabel('\lambda (packets/second)')
ylim([0 100])
grid on

hold on

er = errorbar(lambda_values, medias_PL, temp_PL);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

% Average Packet Delay
nexttile;
bar(lambda_values,medias_APD)    
title("Average Packet Delay (ms)")
xlabel('\lambda (packets/second)')
grid on

hold on

er = errorbar(lambda_values, medias_APD, temp_APD);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

% Max Packet Delay
nexttile;
bar(lambda_values,medias_MDP)    
title("Max Packet Delay (ms)")
xlabel('\lambda (packets/second)')
grid on

hold on

er = errorbar(lambda_values, medias_MDP, temp_MDP);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

% Throughput
nexttile;
bar(lambda_values,medias_TT)    
title("Throughput (Mbps)")
xlabel('\lambda (packets/second)')
grid on

hold on

er = errorbar(lambda_values, medias_TT, temp_TT);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

%% 3c)
% Parameters
lambda_values = [1500, 1600, 1700, 1800, 1900, 2000]; %packet rate
C = 10; %conection capacity
f = 10000000; %queue size
% Calculate Theorical values for M/M/1

% 16% for 64 bytes, 25% for 110 bytes, 20% for 1518 bytes,
% 39& for the rest

aux= [65:109 111:1517];

% B = sum(prob * S)
AveragePacketSize_MM1 = ((0.16 * 64) + (0.25 * 110) + (0.2 * 1518) + ...
    ((sum(aux)*0.39)/length(aux)))*8;

% mu = C / B
u = (C * 1000000)/AveragePacketSize_MM1 ;   % Mbps

PacketDelay_MM1 = zeros(1, sz);
Throughput_MM1 = zeros(1, sz);
for i=1:sz
    % packet delay = 1/mu - lambda
    PacketDelay_MM1(i) = 1 / (u - lambda_values(i)) * 1000;

    %Throughput = 10-6 * TRANSMITTEDBYTES * 8
    Throughput_MM1(i) = 1e-6 * (lambda_values(i)*AveragePacketSize_MM1);
end

% Calculate Theorical values for M/G/1

S = C * 1000000;

AveragePacketSize_MG1 = ((0.16 * 64) + (0.25 * 110) + (0.2 * 1518) + ...
    ((sum(aux)*0.39)/length(aux)))*8;

ES = ((0.16 * 64) + (0.25 * 110) + (0.2 * 1518) + ... 
    (0.39/length(aux)) *sum(aux)) * 8 / S;
ES2 = ((0.16 * (64*8/S)^2) + (0.25 * (110*8/S)^2) + (0.2 * (1518*8/S)^2) ...
    + (0.39/length(aux))*(sum((aux*8/S).^2)));

PacketDelay_MG1 = zeros(1, sz);
Throughput_MG1 = zeros(1, sz);
for i=1:sz
    % W = lambda*E[S^2]/2(1-lambdaE[s]) + E[s]
    PacketDelay_MG1(i) = ((lambda_values(i) * ES2)/(2 * (1 - (lambda_values(i) * ES)))+ES)*1000;

    %Throughput = 10-6 * TRANSMITTEDBYTES * 8
    Throughput_MG1(i) = 1e-6 * (lambda_values(i)*AveragePacketSize_MG1);
end

figure(3);

tiledlayout(1,2)

nexttile;
bar(lambda_values, [medias_APD(:) PacketDelay_MM1(:) PacketDelay_MG1(:)]) 
legend("Simulation", "M/M/1", "M/G/1", "Location" ,"northwest")
title("Average Packet Delay (ms)")
xlabel('\lambda (packets/second)')
grid on

nexttile;
bar(lambda_values, [medias_TT(:) Throughput_MM1(:) Throughput_MG1(:)]) 
legend("Simulation", "M/M/1", "M/G/1", "Location" ,"northwest")
title("Throughput (Mbps)")
xlabel('\lambda (packets/seconds)')
grid on

%% 3d)

% Parameters
n_runs = 40;
P = 10000; %stoping criterion
alpha = 0.10; %confidence intervals
lambda = 1800; %packet rate
C = 10; %conection capacity
f_values = [2500, 5000, 7500, 10000, 12500, 15000, 17500, 20000]; %queue size
b = 0; %bit error rate

% Results arrays
sz = length(f_values);
medias_PL = zeros(1, sz);
temp_PL = zeros(1, sz);
medias_APD = zeros(1, sz);
temp_APD = zeros(1, sz);
medias_MDP = zeros(1, sz);
temp_MDP = zeros(1, sz);
medias_TT = zeros(1, sz);
temp_TT = zeros(1, sz);

% Run simulator n times for each value of lambda
for i = 1:sz
    [medias_PL(i), temp_PL(i) , medias_APD(i), temp_APD(i), ...
     medias_MDP(i), temp_MDP(i) , medias_TT(i), temp_TT(i)] = ...
    runSimulator2(n_runs, alpha, lambda, C, f_values(i), P,b);
end

figure(4)
tiledlayout(2,2)
% Packet Loss
nexttile;
bar(f_values,medias_PL) 
title("Packet Loss (%)")
xlabel('queue size (Bytes)')
ylim([0 100])
grid on

hold on

er = errorbar(f_values, medias_PL, temp_PL);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

% Average Packet Delay
nexttile;
bar(f_values,medias_APD)    
title("Average Packet Delay (ms)")
xlabel('queue size (Bytes)')
grid on

hold on

er = errorbar(f_values, medias_APD, temp_APD);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

% Max Packet Delay
nexttile;
bar(f_values,medias_MDP)    
title("Max Packet Delay (ms)")
xlabel('queue size (Bytes)')
grid on

hold on

er = errorbar(f_values, medias_MDP, temp_MDP);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

% Throughput
nexttile;
bar(f_values,medias_TT)    
title("Throughput (Mbps)")
xlabel('queue size (Bytes)')
grid on

hold on

er = errorbar(f_values, medias_TT, temp_TT);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

%% 3e)

% Parameters
lambda = 1800; %packet rate
C = 10 * 1000000; %conection capacity
f_values = [2500, 5000, 7500, 10000, 12500, 15000, 17500, 20000]; %queue size

% Calculate Theorical Values for M/M/1/m
% 16% for 64 bytes, 25% for 110 bytes, 20% for 1518 bytes,
% 39& for the rest

aux= [65:109 111:1517];

% B = sum(prob * S)
AveragePacketSize = ((0.16 * 64) + (0.25 * 110) + (0.2 * 1518) + ...
    ((sum(aux)*0.39)/length(aux)))*8;

PacketLoss_MM1m = zeros(1, length(f_values));
PacketDelay_MM1m = zeros(1, length(f_values));
Throughput_MM1m = zeros(1, length(f_values));

for z=1:length(f_values)
    m = round((f_values(z)/AveragePacketSize))+1;

    % mu = C / B
    u = C/AveragePacketSize;   % Mbps
    % (lamda/mu)^m/sum((lamda/mu)^j)
    den = 0;
    for j = 0:m
        den = den + (lambda/u)^j;
    end
    PacketLoss_MM1m(z) = (((lambda/u)^(m))/den)*100;

    num_aux = 0;

    for i = 0:m
        num_aux = num_aux + (i * ((lambda/u)^i));
    end

    L = num_aux/den;

    PacketDelay_MM1m(z) = L/(lambda*(1 - (PacketLoss_MM1m(z)/100)))*1000;

    %Throughput = 10-6 * TRANSMITTEDBYTES * 8
    Throughput_MM1m(z) = (1e-6 * ((lambda*AveragePacketSize)-(lambda*AveragePacketSize*(PacketLoss_MM1m(z)/100))));
end

figure(5);

tiledlayout(1,3)

nexttile;
bar(f_values, [medias_APD(:) PacketDelay_MM1m(:)]) 
legend("Simulation", "M/M/1/m", "Location" ,"northwest")
title("Average Packet Delay (ms)")
xlabel('Queue Size (Bytes)')
grid on

nexttile;
bar(f_values, [medias_TT(:) Throughput_MM1m(:)]) 
legend("Simulation", "M/M/1/m", "Location" ,"northwest")
title("Throughput (Mbps)")
xlabel('Queue Size (Bytes)')
grid on

nexttile;
bar(f_values, [medias_PL(:) PacketLoss_MM1m(:)]) 
legend("Simulation", "M/M/1/m", "Location" ,"northeast")
title("Packet Loss (%%)")
xlabel('Queue Size (Bytes)')
grid on