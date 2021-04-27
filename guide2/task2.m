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

[medias_b_4k, terms_b_4k, medias_b_hd, terms_b_hd] = ...
    runSimulator2(N_times, alfa, lambda_values, p, c1_n, c1_S, W, R, fname);

% 4k Blocking Probability
figure(1)
tiledlayout(1,2)

nexttile;
bar(lambda_values,medias_b_4k) 
title("Blocking Probability 4K (%)")
xlabel('\lambda (request/hour)')

hold on

er = errorbar(lambda_values, medias_b_4k, terms_b_4k);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

% HD Blocking Probability
nexttile;
bar(lambda_values,medias_b_hd)    
title("Blocking Probability HD (%)")
xlabel('\lambda (request/hour)')

hold on

er = errorbar(lambda_values, medias_b_hd, terms_b_hd);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off