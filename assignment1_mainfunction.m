clear all
% Definition of the test function and its derivative
test_func01 = @(x) (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
test_derivative01 = @(x) 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;
fun = {test_func01, test_derivative01};

% Set early termination conditions through threshold values
A_t = 10^(-14);
B_t = 10^(-14);

guess_list1 = [];
guess_list2 = [];
for i = 1:200
    a = -30; % Lower bound
    b = 30; % Upper bound
    randguess1 = a + (b - a) * rand();
    randguess2 = a + (b - a) * rand();
    guess_list1 = [guess_list1, randguess1];
    guess_list2 = [guess_list2, randguess2];
end

convergence_analysis(1, fun, 0.9, guess_list1, guess_list2, [], A_t, B_t)

