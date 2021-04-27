function [medias_b_4k, terms_b_4k, medias_b_hd, terms_b_hd] = runSimulator2(N_times, alfa, lambda_values, p, n, S, W, R, fname)  
    sz = length(lambda_values);
    medias_b_4k = zeros(1, sz);
    medias_b_hd = zeros(1, sz);
    terms_b_4k = zeros(1, sz);
    terms_b_hd = zeros(1, sz);

    for z = 1:sz
        results_b_4k = zeros(1, N_times);
        results_b_hd = zeros(1, N_times);
        
        for it = 1:N_times
            [results_b_4k(it), results_b_hd(it)] = simulator2(lambda_values(z), p, n, S, W, R, fname);
        end

        medias_b_4k(z) = mean(results_b_4k);
        medias_b_hd(z) = mean(results_b_hd);

        terms_b_4k(z) = norminv(1-alfa/2)*sqrt(var(results_b_4k)/N_times);
        terms_b_hd(z) = norminv(1-alfa/2)*sqrt(var(results_b_hd)/N_times);
    end
end