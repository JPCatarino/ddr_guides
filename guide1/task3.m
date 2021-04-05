%Task3

%3a

%balance equations
%state (10^-6): (1)π0 - (180)π1
%state (10^-5): (180+20)π1 - (1)π0 - (40)π2
%state (10^-4): (40+10)π2 - (20)π1 - (20)π3
%state (10^-3): (20+5)π3 - (10)π2 - (2)π4
%state (10^-2): (2)π4 - (5)π3

A = [1      -180     0      0       0
    -1    180+20  -40     0       0
    0       -20     40+10   -20     0
    0       0       -10     20+5    -2
    0       0       0       -5      2
    1       1       1       1       1];

B = [0
     0
     0
     0
     0
     1];
 
X = A\B;
 
disp(' ');
disp("Ex3.a.");
disp("probability of (10^-6) = " + X(1));
disp("probability of (10^-5) = " + X(2));
disp("probability of (10^-4) = " + X(3));
disp("probability of (10^-3) = " + X(4));
disp("probability of (10^-2) = " + X(5));


%3b

%π0 = 1/(1 + ∑(λ0/υ0))
%πn = π0/(1 + ∑(λ0/υ0))

transitions = [1/180,20/40,10/20,5/2];

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

disp(' ');
disp("Ex3.b.");
disp("probability of (10^-6) = " + res_1);
disp("probability of (10^-5) = " + res_2);
disp("probability of (10^-4) = " + res_3);
disp("probability of (10^-3) = " + res_4);
disp("probability of (10^-2) = " + res_5);


%3c
%average ber of the link

average = (10^-6)*X(1) + (10^-5)*X(2) + (10^-4)*X(3) + (10^-3)*X(4) + (10^-2)*X(5);

disp(' ')
disp("Ex3.c.")
disp("Average ber of the link = " + average);

%3d 
% tempo medio = 1 / qi: qi = ∑qij

res_1 = (1 / 1) * 60  ;
res_2 = (1 / (20 + 180)) * 60  ;
res_3 = (1 / (10 + 40)) * 60 ;
res_4 = (1 / (5 + 20)) * 60;
res_5 = (1 / 2) * 60 ;

disp(' ');
disp("Ex3.d.");
disp("average time duration of (10^-6) = " + res_1);
disp("average time duration of (10^-5) = " + res_2);
disp("average time duration of (10^-4) = " + res_3);
disp("average time duration of (10^-3) = " + res_4);
disp("average time duration of (10^-2) = " + res_5);

%3e
% Interference >=10^-3 

prob = X(4) + X(5);

disp(' ')
disp("Ex3.e.")
disp("Probability of the link being in interference state = " + prob);

%3f

disp(' ')
disp("Ex3.f.")
average_interference = ((X(4)*10^-3) + (X(5)*10^-2))/prob;
disp("Average ber of the link in interference state = " + average_interference);
