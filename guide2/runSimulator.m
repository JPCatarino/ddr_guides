function [results_b, results_o] = runSimulator(N, lambda, C, M ,R, fname)
    results_b = zeros(1, N);
    results_o = zeros(1, N);
    for it = 1:N
        [results_b(it), results_o(it)] = simulator1(lambda, C, M, R, fname);
    end
end