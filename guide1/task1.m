% Task 1 

%1a
% P(E) = P(E|F1)P(F1) + P(E|F2)P(F2)
p = 0.6;
n = 4;
res = p + ((1-p)/n);

%1b
% P(F1|E) = P(E|F1)P(F1)/P(E)
p = 0.7;
n = 5;
res = p*n/(1 + (n-1)*p)

%1c
p = linspace(0,1);
n1 = p + ((1-p)/3);
n2 = p + ((1-p)/4);
n3 = p + ((1-p)/5);

figure(1)
plot(p*100, n1*100, 'b-', p*100, n2*100, 'b--', p*100, n3*100, 'b:')
grid on
title("Probabilidade de resposta certa(%)")
xlabel('p(%)')
legend('n=3', 'n=4', 'n=5', 'location', 'northwest')
axis([0 100 0 100])

%1d
p = linspace(0,1);
n1 = p*3./(1 + (3-1)*p);
n2 = p*4./(1 + (4-1)*p);
n3 = p*5./(1 + (5-1)*p);

figure(2)
plot(p*100, n1*100, 'b-', p*100, n2*100, 'b--', p*100, n3*100, 'b:')
grid on
title("Probabilidade de saber a resposta (%)")
xlabel('p(%)')
legend('n=3', 'n=4', 'n=5', 'location', 'northwest')
axis([0 100 0 100])


