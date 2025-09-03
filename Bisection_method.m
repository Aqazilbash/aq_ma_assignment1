function [root] = Bisection_method(x_l, x_r, thresh, test_func)
while true
x_mid = (x_l + x_r) / 2;

% checks if within thresholds
if abs(test_func(x_l)) < thresh
    root = x_l;
    break
end
if abs(test_func(x_r)) < thresh
    root = x_r;
    break
end 
if abs(test_func(x_mid)) < thresh
    root = x_mid;
    break
end

% bisection safeguard: terminates if initial guesses don't contain crossing
if (test_func(x_l) < 0 && test_func(x_r) < 0) || (test_func(x_l) > 0 && test_func(x_r) > 0)
    root = NaN;
    break
end

if (test_func(x_l) > 0 && test_func(x_mid) < 0) || (test_func(x_l) < 0 && test_func(x_mid) > 0)
    x_r = x_mid;
else if (test_func(x_mid) > 0 && test_func(x_r) < 0) || (test_func(x_mid) < 0 && test_func(x_r) > 0)
        x_l = x_mid;
end 

end

end
