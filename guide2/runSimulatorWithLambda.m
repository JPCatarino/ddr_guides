function [medias_b, terms_b, medias_o, terms_o] = runSimulatorWithLambda(N, lambda_values, C, M ,R, fname)  
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
end