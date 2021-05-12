%Task3
% General Values
G= [ 1  2
     1  3
     1  4
     1  5
     1  6
     1 14
     1 15
     2  3
     2  4
     2  5
     2  7
     2  8
     3  4
     3  5
     3  8
     3  9
     3 10
     4  5
     4 10
     4 11
     4 12
     4 13
     5 12
     5 13
     5 14
     6  7
     6 16
     6 17
     6 18
     6 19
     7 19
     7 20
     8  9
     8 21
     8 22
     9 10
     9 22
     9 23
     9 24
     9 25
     10 11
     10 26
     10 27
     11 27
     11 28
     11 29
     11 30
     12 30
     12 31
     12 32
     13 14
     13 33
     13 34
     13 35
     14 36
     14 37
     14 38
     15 16
     15 39
     15 40
     20 21];
 
G_graph = graph(G(:, 1), G(:,2));

plot(G_graph);

%% 
% 3a

c = [12, 8];
n_nodes = numnodes(G_graph);
fid= fopen('res3a.lp','wt');

% Minimize (1)
fprintf(fid, 'Minimize\n');
for i=6:n_nodes
    c_aux = c(1);
    if i >= 16
        c_aux = c(2);
    end
    fprintf(fid, ' + %f x%d', c_aux, i);
end
fprintf(fid, '\nSubject To \n');
% Constraint 1 (2)
for j=6:n_nodes
    I_j_aux = [];
    for i=6:n_nodes
        sp_aux = shortestpath(G_graph, j, i);
        sp_aux = sp_aux(2:end-1);
        if length(sp_aux) <= 1
            I_j_aux = [I_j_aux; i];
        end
    end
    for z=1:length(I_j_aux)
        fprintf(fid, ' + x%d', I_j_aux(z));
    end
    fprintf(fid, ' >= 1\n');
end
% Binary (3)
fprintf(fid, 'Binary\n');
for i=6:n_nodes
    fprintf(fid, ' x%d\n', i);
end
fprintf(fid, 'End\n');
fclose(fid);
%%
%3b

% Configuration B
b_n = 13;
b_S = 1000;

N_times = 10;
alfa = 0.1;
W = 8750;
p = 0.30;
R = 30000;
lambda = R/24;
fname = "movies.txt";

[medias_b_4k_b, terms_b_4k_b, medias_b_hd_b, terms_b_hd_b] = ...
    runSimulator2(N_times, alfa, lambda, p, b_n, b_S, W, R, fname);

fprintf('Blocking probability 4K (%%) = %.2e +- %.2e\n', medias_b_4k_b, terms_b_4k_b);
fprintf('Blocking probability HD (%%) = %.2e +- %.2e\n', medias_b_hd_b, terms_b_hd_b);

figure(1);
tiledlayout(1,2)

nexttile;
bar(lambda, medias_b_4k_b(:)) 
legend("Working", "Location" ,"northwest")
title("Blocking Probability 4K (%)")
xlabel('\lambda (request/hour)')
grid on

hold on

er = errorbar(lambda, medias_b_4k_b, terms_b_4k_b);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

nexttile;
bar(lambda, medias_b_hd_b(:)) 
legend("Working", "Location" ,"northwest")
title("Blocking Probability HD (%)")
xlabel('\lambda (request/hour)')
grid on

hold on

er = errorbar(lambda, medias_b_hd_b, terms_b_hd_b);    
er.Color = [0 0 0];                            
er.LineStyle = 'none';  

hold off

