function [root] = Secant_method(guess1, guess2, A_thresh, B_thresh, test_func)
% finds root using secant method
x = [guess1 guess2];
n = 3;
root = NaN;
while true
x(n) = x(n-1) - test_func(x(n-1)) * ( (x(n-1) - x(n-2)) / (test_func(x(n-1)) - test_func(x(n-2))));

% safeguard: prevents massive jump in step size
if abs(x(n)-(x*n-1)) > 10.^14
    root = x(n-1);
    break
end
% terminates if/when solution is sufficiently correct
if (abs(x(n) - x(n-1)) < A_thresh) || (abs(test_func(x(n))) < B_thresh)
    root = x(n);
    break
end

n = n + 1;

% division safeguard: prevents dividing by zero
if ((test_func(x(n-1)) - test_func(x(n-2))) == 0)
    root = x(n-1);
    break
end
end