function [medias_PL, temp_PL , medias_APD, temp_APD , medias_MDP, temp_MDP , medias_TT, temp_TT] = runSimulator(n_times, alfa, lambda, C, f, P)

results_PL = zeros(0,n_times);
results_APD = zeros(0,n_times);
results_MDP = zeros(0,n_times);
results_TT = zeros(0,n_times);

for it = 1:n_times
     [results_PL(it),results_APD(it),results_MDP(it), results_TT(it)] =  Simulator1(lambda, C, f, P);
end

medias_PL = mean(results_PL);
medias_APD = mean(results_APD);
medias_MDP = mean(results_MDP);
medias_TT = mean(results_TT);

temp_PL = norminv(1-alfa/2)*sqrt(var(results_PL)/n_times);
temp_APD = norminv(1-alfa/2)*sqrt(var(results_APD)/n_times);
temp_MDP = norminv(1-alfa/2)*sqrt(var(results_MDP)/n_times);
temp_TT = norminv(1-alfa/2)*sqrt(var(results_TT)/n_times);


