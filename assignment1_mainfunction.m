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

%convergence_analysis(2, fun, 0.9, guess_list1, guess_list2, [], A_t, B_t)


a = linspace(0, 50, 100);
f_vals = zeros(size(a));
derivative = zeros(size(a));

f  = @(x) test_function03(x);        % full call, but returns [f_val, dfdx]
f  = @(x) test_function03(x);        % will still return two outputs if asked

% split them into dedicated single-output handles:
f_handle   = @(x) test_function03(x);             % by default, only first output
dfdx_handle = @(x) select_dfdx(x);

func_handles = {f_handle,dfdx_handle};

success_guesses = [];
failure_guesses = [];
for i = 1:length(a)
    [root_maybe, guesses] = Newtons_method(a(i), A_t, B_t, func_handles);
    if isnan(root_maybe)
        failure_guesses(end+1) = a(i);
    else 
        success_guesses(end+1) = a(i);
    end
end


% helper wrapper that extracts 2nd output
function d = select_dfdx(x)
    [~, d] = test_function03(x);
end

for i = 1:length(a)
     [f_vals(i), derivative(i)] = test_function03(a(i));
end
 figure;
 plot(a, f_vals, 'b-', 'LineWidth', 2);
 hold on;
 success_fvals = []
 for i = 1:length(success_guesses)
    success_fvals(end+1) = f_handle(success_guesses(i));
 end
 plot(success_guesses, success_fvals, "r-", "LineWidth", 2)
% yline(0);
% hold on;

%for i = length(a):

