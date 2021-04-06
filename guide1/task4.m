%Task4

%4a
%π0 = 1/(1 + ∑(λ0/υ0))
%πn = π0/(1 + ∑(λ0/υ0))
% Interference >=10^-3 
% Normal < 10^-3

transitions = [8/600,5/200,2/50,1/5];

% calculo da probabilidade limite de processos de nascimento e morte

 tmp = transitions(1);
for i = 2:4
    sum = transitions(i);
    for j = 1:(i-1)
        sum = sum * transitions(j);
    end
    tmp = tmp + sum;
end

res_1 = 1/(1+ tmp);
res_2 = res_1*transitions(1);
res_3 = res_2*transitions(2);
res_4 = res_3*transitions(3);
res_5 = res_4*transitions(4);

X = [res_1 res_2 res_3 res_4 res_5];

prob_normal = X(1) + X(2) + X(3);
prob_interference = X(4) + X(5);

disp(' ');
disp("Ex4.a.");
disp("Probability of the link being in normal state = " + prob_normal);
disp("Probability of the link being in interference state = " + prob_interference);

%4b
disp(' ');
disp("Ex4.b.");
average_normal = ((X(1) * 10^-6) + (X(2) * 10^-5) + (X(3) * 10^-4))/prob_normal; 
average_interference = ((X(4)*10^-3) + (X(5)*10^-2))/prob_interference;
disp("Average ber of the link in normal state = " + average_normal);
disp("Average ber of the link in interference state = " + average_interference);

%4c
disp(' ');
disp("Ex4.c.");
% Packet size from 64 bytes to 200 bytes
n = linspace(64, 200);

%With Errors
i = 0;
p_normal = [(10^-6), (10^-5), (10^-4)];

f1 = (1 - (p_normal(1)^i * (1 - p_normal(1)).^(n))) * 100;
f2 = (1 - (p_normal(2)^i * (1 - p_normal(2)).^(n))) * 100;
f3 = (1 - (p_normal(3)^i * (1 - p_normal(3)).^(n))) * 100;

figure(1);
semilogy(n, f1, 'b-', n, f2, 'b--', n, f3, 'b:');
grid on
title("Probabilidade de receber o pacote com erros(%)")
xlabel('Packet Size (Bytes)')
legend('ber=1e-6', 'ber=1e-5', 'ber=1e-4', 'location', 'southwest')




