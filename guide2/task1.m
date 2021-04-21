%Task1

%1a
% Adapted from Module 3 Slide 22

N = 10;
results_b = zeros(1, N);
results_o = zeros(1, N);

lambda = 20;
C = 100;
M = 4;
R = 500;
fname = 'movies.txt';

for it = 1:N
    [results_b(it), results_o(it)] = simulator1(lambda, C, M, R, fname);
end

% 90% confidence interval
alfa = 0.1;
media_b = mean(results_b);
media_o = mean(results_o);

term_b = norminv(1-alfa/2)*sqrt(var(results_b)/N);
term_o = norminv(1-alfa/2)*sqrt(var(results_o)/N);

fprintf('Blocking probability (%%) = %.2e +- %.2e\n', media_b, term_b);
fprintf('Average occupation (Mbps) = %.2e +- %.2e\n', media_o, term_o);

%1b
lambda_values = [10, 15, 20, 25, 30, 35, 40];

sz = length(lambda_values);
medias_b = zeros(1, sz);
medias_o = zeros(1, sz);
terms_b = zeros(1, sz);
terms_o = zeros(1, sz);

for z = 1:sz
    [results_b, results_o] = runSimulator(N, lambda_values(z), C, M ,R, fname);
    
    % 90% confidence interval
    alfa = 0.1;
    medias_b(z) = mean(results_b);
    medias_o(z) = mean(results_o);

    terms_b(z) = norminv(1-alfa/2)*sqrt(var(results_b)/N);
    terms_o(z) = norminv(1-alfa/2)*sqrt(var(results_o)/N);
end

% Blocking Probability
figure(1)
tiledlayout(1,2)

nexttile;
bar(lambda_values,medias_b) 
title("Blocking Probability (%)")
xlabel('\lambda (request/hour)')

hold on

er = errorbar(lambda_values, medias_b, terms_b);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

% Average server occupation
nexttile;
bar(lambda_values,medias_o)    
title("Average Server Occupation(mbps)")
xlabel('\lambda (request/hour)')

hold on

er = errorbar(lambda_values, medias_o, terms_o);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

%1c
R = 5000;

[medias_b, terms_b, medias_o, terms_o] = ...
    runSimulatorWithLambda(N, lambda_values, C, M ,R, fname);

% Blocking Probability
figure(2)
tiledlayout(1,2)

nexttile;
bar(lambda_values,medias_b) 
title("Blocking Probability (%)")
xlabel('\lambda (request/hour)')

hold on

er = errorbar(lambda_values, medias_b, terms_b);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

% Average server occupation
nexttile;
bar(lambda_values,medias_o)    
title("Average Server Occupation(mbps)")
xlabel('\lambda (request/hour)')

hold on

er = errorbar(lambda_values, medias_o, terms_o);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

%1d
lambda_values = [100, 150, 200, 250, 300, 350, 400];
C = 1000;
M = 4;
R = 5000;

[medias_b, terms_b, medias_o, terms_o] = ...
    runSimulatorWithLambda(N, lambda_values, C, M ,R, fname);

% Blocking Probability
figure(3)
tiledlayout(1,2)

nexttile;
bar(lambda_values,medias_b) 
title("Blocking Probability (%)")
xlabel('\lambda (request/hour)')

hold on

er = errorbar(lambda_values, medias_b, terms_b);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

% Average server occupation
nexttile;
bar(lambda_values,medias_o)    
title("Average Server Occupation(mbps)")
xlabel('\lambda (request/hour)')

hold on

er = errorbar(lambda_values, medias_o, terms_o);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

%1e
lambda_values = [10, 15, 20, 25, 30, 35, 40];
C = 100;
M = 4;
R = 5000;

sz = length(lambda_values);
b_teoricos = zeros(1, sz);
o_teoricos = zeros(1, sz);
inverse_mu = 1.438;

for z = 1:sz
   ro = lambda_values(z)*inverse_mu;
   
   b_teoricos(z) = theoricalBlockingProbability(ro, lambda_values(z));
   o_teoricos(z) = theoricalAverageSystemOccupation(ro, lambda_values(z));
end

% Average server occupation
figure(4);

tiledlayout(1,2)

nexttile;
bar(lambda_values,b_teoricos) 
title("Blocking Probability (%)")
xlabel('\lambda (request/hour)')

nexttile;
bar(lambda_values,o_teoricos)    
title("Average Server Occupation(mbps)")
xlabel('\lambda (request/hour)')
 
