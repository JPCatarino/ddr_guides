%% 4a)

% Parameters
n_runs = 10;
P = 100000; %stoping criterion
alpha = 0.10; %confidence intervals
lambda = 1800; %packet rate
C = 10; %conection capacity
f = 1000000; %queue size
b = 0; %bit error rate

[medias_PL, temp_PL , medias_APD, temp_APD , medias_MDP, temp_MDP , medias_TT, temp_TT] = ...
    runSimulator3(n_runs, alpha, lambda, C, f, P,b);

fprintf('\n4a\n');

fprintf('PacketLoss (%%) = %.2e +- %.2e\n', medias_PL, temp_PL);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n', medias_APD, temp_APD);
fprintf('Max. Packet Delay (ms) = %.2e +- %.2e\n', medias_MDP, temp_MDP);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n', medias_TT, temp_TT);

%% 4b)
% Parameters
n_runs = 10;
P = 100000; %stoping criterion
alpha = 0.10; %confidence intervals
lambda = 1800; %packet rate
C = 10; %conection capacity
f = 10000; %queue size
b = 1e-5; %bit error rate

[medias_PL, temp_PL , medias_APD, temp_APD , medias_MDP, temp_MDP , medias_TT, temp_TT] = ...
    runSimulator3(n_runs, alpha, lambda, C, f, P,b);

fprintf('\n4b\n');

fprintf('PacketLoss (%%) = %.2e +- %.2e\n', medias_PL, temp_PL);
fprintf('Av. Packet Delay (ms) = %.2e +- %.2e\n', medias_APD, temp_APD);
fprintf('Max. Packet Delay (ms) = %.2e +- %.2e\n', medias_MDP, temp_MDP);
fprintf('Throughput (Mbps) = %.2e +- %.2e\n', medias_TT, temp_TT);

%% 4c)
% Parameters
n_runs = 10;
P = 100000; %stoping criterion
alpha = 0.10; %confidence intervals
lambda_values = [1500, 1600, 1700, 1800, 1900, 2000]; %packet rate
C = 10; %conection capacity
f = 1e7; %queue size
b = 0; %bit error rate

sz = length(lambda_values);

% Results arrays Sim2
medias_PL_S2 = zeros(1, sz);
temp_PL_S2 = zeros(1, sz);
medias_APD_S2 = zeros(1, sz);
temp_APD_S2 = zeros(1, sz);
medias_MDP_S2 = zeros(1, sz);
temp_MDP_S2 = zeros(1, sz);
medias_TT_S2 = zeros(1, sz);
temp_TT_S2 = zeros(1, sz);

% Results arrays Sim3
medias_PL_S3 = zeros(1, sz);
temp_PL_S3 = zeros(1, sz);
medias_APD_S3 = zeros(1, sz);
temp_APD_S3 = zeros(1, sz);
medias_MDP_S3 = zeros(1, sz);
temp_MDP_S3 = zeros(1, sz);
medias_TT_S3 = zeros(1, sz);
temp_TT_S3 = zeros(1, sz);

% Run simulator n times for each value of lambda
for i = 1:sz
    [medias_PL_S2(i), temp_PL_S2(i) , medias_APD_S2(i), temp_APD_S2(i), ...
     medias_MDP_S2(i), temp_MDP_S2(i) , medias_TT_S2(i), temp_TT_S2(i)] = ...
    runSimulator2(n_runs, alpha, lambda_values(i), C, f, P,b);
    
    [medias_PL_S3(i), temp_PL_S3(i) , medias_APD_S3(i), temp_APD_S3(i), ...
     medias_MDP_S3(i), temp_MDP_S3(i) , medias_TT_S3(i), temp_TT_S3(i)] = ...
    runSimulator3(n_runs, alpha, lambda_values(i), C, f, P,b);
end

figure(1);

tiledlayout(2,2)

% Packet Loss
nexttile;
bar(lambda_values, [medias_PL_S2(:) medias_PL_S3(:)]) 
legend("Simulation 2", "Simulation 3", "Location" ,"northwest")
title("Packet Loss (%)")
xlabel('queue size (Bytes)')
grid on

nexttile;
bar(lambda_values, [medias_APD_S2(:) medias_APD_S3(:)]) 
legend("Simulation 2", "Simulation 3", "Location" ,"northwest")
title("Average Packet Delay (ms)")
xlabel('\lambda (packets/second)')
grid on

% Max Packet Delay
nexttile;
bar(lambda_values, [medias_MDP_S2(:) medias_MDP_S3(:)]) 
legend("Simulation 2", "Simulation 3", "Location" ,"northwest")   
title("Max Packet Delay (ms)")
xlabel('queue size (Bytes)')
grid on

nexttile;
bar(lambda_values, [medias_TT_S2(:) medias_TT_S3(:)]) 
legend("Simulation 2", "Simulation 3", "Location" ,"northwest")
title("Throughput (Mbps)")
xlabel('\lambda (packets/second)')
grid on

%% 4d)
% Parameters
n_runs = 10;
P = 100000; %stoping criterion
alpha = 0.10; %confidence intervals
lambda = 1800; %packet rate
C = 10; %conection capacity
f_values = [2500, 5000, 7500, 10000, 12500, 15000, 17500, 20000]; %queue size
b = 0; %bit error rate

sz = length(f_values);

% Results arrays Sim2
medias_PL_S2 = zeros(1, sz);
temp_PL_S2 = zeros(1, sz);
medias_APD_S2 = zeros(1, sz);
temp_APD_S2 = zeros(1, sz);
medias_MDP_S2 = zeros(1, sz);
temp_MDP_S2 = zeros(1, sz);
medias_TT_S2 = zeros(1, sz);
temp_TT_S2 = zeros(1, sz);

% Results arrays Sim3
medias_PL_S3 = zeros(1, sz);
temp_PL_S3 = zeros(1, sz);
medias_APD_S3 = zeros(1, sz);
temp_APD_S3 = zeros(1, sz);
medias_MDP_S3 = zeros(1, sz);
temp_MDP_S3 = zeros(1, sz);
medias_TT_S3 = zeros(1, sz);
temp_TT_S3 = zeros(1, sz);

% Run simulator n times for each value of lambda
for i = 1:sz
    [medias_PL_S2(i), temp_PL_S2(i) , medias_APD_S2(i), temp_APD_S2(i), ...
     medias_MDP_S2(i), temp_MDP_S2(i) , medias_TT_S2(i), temp_TT_S2(i)] = ...
    runSimulator2(n_runs, alpha, lambda, C, f_values(i), P,b);
    
    [medias_PL_S3(i), temp_PL_S3(i) , medias_APD_S3(i), temp_APD_S3(i), ...
     medias_MDP_S3(i), temp_MDP_S3(i) , medias_TT_S3(i), temp_TT_S3(i)] = ...
    runSimulator3(n_runs, alpha, lambda, C, f_values(i), P,b);
end

figure(2);

tiledlayout(2,2)

% Packet Loss
nexttile;
bar(f_values, [medias_PL_S2(:) medias_PL_S3(:)]) 
legend("Simulation 2", "Simulation 3", "Location" ,"northwest")
title("Packet Loss (%)")
xlabel('queue size (Bytes)')
grid on

nexttile;
bar(f_values, [medias_APD_S2(:) medias_APD_S3(:)]) 
legend("Simulation 2", "Simulation 3", "Location" ,"northwest")
title("Average Packet Delay (ms)")
xlabel('\lambda (packets/second)')
grid on

% Max Packet Delay
nexttile;
bar(f_values, [medias_MDP_S2(:) medias_MDP_S3(:)]) 
legend("Simulation 2", "Simulation 3", "Location" ,"northwest")   
title("Max Packet Delay (ms)")
xlabel('queue size (Bytes)')
grid on

nexttile;
bar(f_values, [medias_TT_S2(:) medias_TT_S3(:)]) 
legend("Simulation 2", "Simulation 3", "Location" ,"northwest")
title("Throughput (Mbps)")
xlabel('\lambda (packets/second)')
grid on
