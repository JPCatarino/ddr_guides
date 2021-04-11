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
prob_interf = X(4) + X(5);

disp(' ');
disp("Ex4.a.");
disp("Probability of the link being in normal state = " + prob_normal);
disp("Probability of the link being in interference state = " + prob_interf);

%4b
disp(' ');
disp("Ex4.b.");
average_normal = ((X(1) * 10^-6) + (X(2) * 10^-5) + (X(3) * 10^-4))/prob_normal; 
average_interf = ((X(4)*10^-3) + (X(5)*10^-2))/prob_interf;
disp("Average ber of the link in normal state = " + average_normal);
disp("Average ber of the link in interference state = " + average_interf);

%4c
% Ver slides 1-7

disp(' ');
disp("Ex4.c.");
disp("Check figure 1.");
% Packet size from 64 bytes to 200 bytes
n = linspace(64, 200) * 8;

%With Errors
prob_errors_in_normal = (1 - ((1 - average_normal).^(n)));
prob_errors_in_interf = (1 - ((1 - average_interf).^(n)));

% P(Errors) = P(Errors|N)P(N) + P(Errors|I)P(I)
prob_errors = (prob_errors_in_normal .* prob_normal) + ... 
              (prob_errors_in_interf .* prob_interf);

% P(CondN|Errors) = P(Errors|N)P(N)/P(Errors)
prob_normal_with_errors = (prob_errors_in_normal .* prob_normal)./prob_errors; 

figure(1);
semilogy(n, prob_normal_with_errors, 'b-');
grid on;
title("Probabilidade de link estar em estado normal se o pacote for recebido com erros(%)");
xlabel('Packet Size (Bytes)');
legend('%', 'location', 'southwest');

%4d
disp(' ');
disp("Ex4.d.");
disp("Check figure 2.");
% Packet size from 64 bytes to 200 bytes
n = linspace(64, 200) * 8;

% Without Errors
i = 0;
prob_no_errors_in_interference = ((1 - average_interf).^(n - i));

% P(NO_E) = 1 - P(E) ?
prob_no_errors = 1 - prob_errors;

% P(CondI|No_Errors) = P(No_Errors|I)P(I)/P(No_Errors)
prob_interf_no_errors = (prob_no_errors_in_interference .* prob_interf)./prob_no_errors;

figure(2);
semilogy(n, prob_interf_no_errors, 'b-');
grid on;
title("Probabilidade de link estar em estado interferencia se o pacote for recebido sem erros(%)");
xlabel('Packet Size (Bytes)');
legend('%', 'location', 'southwest');

save("task4variables.mat");