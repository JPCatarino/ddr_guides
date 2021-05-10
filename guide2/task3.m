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
%3a
I = [];
n_nodes = numnodes(G_graph);
for i = 6:n_nodes
    for j = 6:n_nodes
        if i ~= j
            sp_aux = shortestpath(G_graph, i, j);
            sp_aux = sp_aux(2:end-1);
            if length(sp_aux) <= 1 && ~ismember(i, I)
                I = [I; i];
            end
        end
    end
end