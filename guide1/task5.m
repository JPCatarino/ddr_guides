%Task5

% loading saved values from the last task - Run last task once to create
% the file
load("task4variables.mat");

%5a and b
% Each event is independent, so the probability of having errors for n
% frames can be given by (prob_no_errors_in_x)^n_frame
% Frame size is 64

prob_false_positive_n = zeros(1, 4);
prob_false_negative_n = zeros(1, 4);
for n_frame = 2:5
    % Using variables from last exercise, p_errors_in_normal(1) corresponds
    % to the probability of the packet having errors in normal state for a
    % packet size of 64
    prob_errors_in_normal_n = prob_errors_in_normal(1) ^ n_frame;
    prob_errors_in_interf_n = prob_errors_in_interf(1) ^ n_frame;
    
    prob_no_errors_in_interf_n = 1 - prob_errors_in_interf_n; 
    
    % prob_falsep = P(Normal)P(Errors|Normal)/P(Normal)P(Errors|Normal) +
    % P(Interf)P(Errors|Interf)
    
    % prob_falsen =
    % P(Interf)P(No_Errors|Interf)/P(Normal)P(No_Errors|Normal) + 
    % P(Interf)P(No_Errors|Interf)
    
    c_index = n_frame-1;
    
    prob_false_positive_n(c_index) = (prob_normal * prob_errors_in_normal_n)/...
                                    ((prob_normal * prob_errors_in_normal_n) +...
                                     (prob_interf * prob_errors_in_interf_n));
    
    prob_false_negative_n(c_index) = (prob_no_errors_in_interf_n) * prob_interf/...
                                     (1 - ((prob_normal * prob_errors_in_normal_n) +...
                                     (prob_interf * prob_errors_in_interf_n)));   
    
    disp("n = " + n_frame + "; Probability of False Positive = " + ...
         prob_false_positive_n(c_index));
end

disp("Ex5.a.");
disp("Check figure 1.");
figure(1);
stem([2,3,4,5], prob_false_positive_n);
set(gca,'yscal','log');
title("Probability of False Positives (%)");
xlabel('n');
ylabel('p(%)');
xlim([1.5, 5.5]);

disp("Ex5.b.");
disp("Check figure 2.");
figure(2);
stem([2,3,4,5], prob_false_negative_n);
set(gca, 'yscal', 'log');
title("Probability of False Negatives (%)");
xlabel('n');
ylabel('p(%)');
xlim([1.5, 5.5]);


