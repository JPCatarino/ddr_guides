%Task2
% General Values
lambda_values = [100, 120, 140, 160, 180, 200];
fname = "movies.txt";

% Configuration 1
c1_n = 10;
c1_S = 100;

% Configuration 2
c2_n = 4;
c2_S = 250;

% Configuration 3
c3_n = 1;
c3_S = 1000;

%%
%2a

N_times = 10;
alfa = 0.1;
W = 0;
p = 0.2;
R = 10000;

[medias_b_4k_c1, terms_b_4k_c1, medias_b_hd_c1, terms_b_hd_c1] = ...
    runSimulator2(N_times, alfa, lambda_values, p, c1_n, c1_S, W, R, fname);

% 4k Blocking Probability
figure(1)
tiledlayout(1,2)

nexttile;
bar(lambda_values,medias_b_4k_c1) 
title("Blocking Probability 4K (%) - W = 0")
xlabel('\lambda (request/hour)')
ylim([0 100])
grid on

hold on

er = errorbar(lambda_values, medias_b_4k_c1, terms_b_4k_c1);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

% HD Blocking Probability
nexttile;
bar(lambda_values,medias_b_hd_c1)    
title("Blocking Probability HD (%) - W = 0")
xlabel('\lambda (request/hour)')
ylim([0 100])
grid on

hold on

er = errorbar(lambda_values, medias_b_hd_c1, terms_b_hd_c1);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

%%
%2b

N_times = 10;
alfa = 0.1;
W = 0;
p = 0.2;
R = 10000;

[medias_b_4k_c2, terms_b_4k_c2, medias_b_hd_c2, terms_b_hd_c2] = ...
    runSimulator2(N_times, alfa, lambda_values, p, c2_n, c2_S, W, R, fname);

[medias_b_4k_c3, terms_b_4k_c3, medias_b_hd_c3, terms_b_hd_c3] = ...
    runSimulator2(N_times, alfa, lambda_values, p, c3_n, c3_S, W, R, fname);

figure(2);

tiledlayout(1,2)

nexttile;
bar(lambda_values, [medias_b_4k_c1(:) medias_b_4k_c2(:) medias_b_4k_c3(:)]) 
legend("Configuration 1", "Configuration 2", "Configuration 3", "Location" ,"northwest")
title("Blocking Probability 4K (%) - W = 0")
xlabel('\lambda (request/hour)')
ylim([0 100])
grid on

nexttile;
bar(lambda_values, [medias_b_hd_c1(:) medias_b_hd_c2(:) medias_b_hd_c3(:)]) 
legend("Configuration 1", "Configuration 2", "Configuration 3", "Location" ,"northwest")
title("Blocking Probability HD (%) - W = 0")
xlabel('\lambda (request/hour)')
ylim([0 100])
grid on

%%
%2c

N_times = 10;
alfa = 0.1;
W = 400;
p = 0.2;
R = 10000;

[medias_b_4k_c1, terms_b_4k_c1, medias_b_hd_c1, terms_b_hd_c1] = ...
    runSimulator2(N_times, alfa, lambda_values, p, c1_n, c1_S, W, R, fname);

[medias_b_4k_c2, terms_b_4k_c2, medias_b_hd_c2, terms_b_hd_c2] = ...
    runSimulator2(N_times, alfa, lambda_values, p, c2_n, c2_S, W, R, fname);

[medias_b_4k_c3, terms_b_4k_c3, medias_b_hd_c3, terms_b_hd_c3] = ...
    runSimulator2(N_times, alfa, lambda_values, p, c3_n, c3_S, W, R, fname);

figure(3);

tiledlayout(1,2)

nexttile;
bar(lambda_values, [medias_b_4k_c1(:) medias_b_4k_c2(:) medias_b_4k_c3(:)]) 
legend("Configuration 1", "Configuration 2", "Configuration 3", "Location" ,"northwest")
title("Blocking Probability 4K (%)- W = 400")
xlabel('\lambda (request/hour)')
ylim([0 100])
grid on

nexttile;
bar(lambda_values, [medias_b_hd_c1(:) medias_b_hd_c2(:) medias_b_hd_c3(:)]) 
legend("Configuration 1", "Configuration 2", "Configuration 3", "Location" ,"northwest")
title("Blocking Probability HD (%) - W = 400")
xlabel('\lambda (request/hour)')
ylim([0 100])
grid on

%%
%2d

N_times = 10;
alfa = 0.1;
W = 600;
p = 0.2;
R = 10000;

[medias_b_4k_c1, terms_b_4k_c1, medias_b_hd_c1, terms_b_hd_c1] = ...
    runSimulator2(N_times, alfa, lambda_values, p, c1_n, c1_S, W, R, fname);

[medias_b_4k_c2, terms_b_4k_c2, medias_b_hd_c2, terms_b_hd_c2] = ...
    runSimulator2(N_times, alfa, lambda_values, p, c2_n, c2_S, W, R, fname);

[medias_b_4k_c3, terms_b_4k_c3, medias_b_hd_c3, terms_b_hd_c3] = ...
    runSimulator2(N_times, alfa, lambda_values, p, c3_n, c3_S, W, R, fname);

figure(4);

tiledlayout(1,2)

nexttile;
bar(lambda_values, [medias_b_4k_c1(:) medias_b_4k_c2(:) medias_b_4k_c3(:)]) 
legend("Configuration 1", "Configuration 2", "Configuration 3", "Location" ,"northwest")
title("Blocking Probability 4K (%) - W = 600")
xlabel('\lambda (request/hour)')
ylim([0 100])
grid on

nexttile;
bar(lambda_values, [medias_b_hd_c1(:) medias_b_hd_c2(:) medias_b_hd_c3(:)]) 
legend("Configuration 1", "Configuration 2", "Configuration 3", "Location" ,"northwest")
title("Blocking Probability HD (%) - W = 600")
xlabel('\lambda (request/hour)')
ylim([0 100])
grid on

%%
%2e

% Configuration E
e_n = 2;
e_S = 10000;

N_times = 10;
alfa = 0.1;
W = 5000;
p = 0.24;
R = 100000;

[medias_b_4k_e, terms_b_4k_e, medias_b_hd_e, terms_b_hd_e] = ...
    runSimulator2(N_times, alfa, lambda_values, p, e_n, e_S, W, R, fname);

[medias_b_4k_e_fail, terms_b_4k_e_fail, medias_b_hd_e_fail, terms_b_hd_e_fail] = ...
    runSimulator2(N_times, alfa, lambda_values, p, e_n-1, e_S, W, R, fname);

for i = 1:6
    fprintf('Blocking probability 4K (%%) = %.2e +- %.2e\n', medias_b_4k_e(i), terms_b_4k_e(i));
    fprintf('Blocking probability 4K Failed Server (%%) = %.2e +- %.2e\n', medias_b_4k_e_fail(i), terms_b_4k_e_fail(i));
    fprintf('Blocking probability HD (%%) = %.2e +- %.2e\n', medias_b_hd_e(i), terms_b_hd_e(i));
    fprintf('Blocking probability HD Failed Server (%%) = %.2e +- %.2e\n', medias_b_hd_e_fail(i), terms_b_hd_e_fail(i));
end

figure(5);

tiledlayout(1,2)

nexttile;
bar(lambda_values, [medias_b_4k_e(:) medias_b_4k_e_fail(:)]) 
legend("Working", "Failed Server", "Location" ,"northwest")
title("Blocking Probability 4K (%)")
xlabel('\lambda (request/hour)')
ylim([0 100])
grid on

nexttile;
bar(lambda_values, [medias_b_hd_e(:) medias_b_hd_e_fail(:)]) 
legend("Working", "Failed Server", "Location" ,"northwest")
title("Blocking Probability HD (%)")
xlabel('\lambda (request/hour)')
ylim([0 100])
grid on


