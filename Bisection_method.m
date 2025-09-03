function [root] = Bisection_method(x_l, x_r, test_func)
%Definition of the test function and its derivative
while true
x_mid = (x_l + x_r) / 2;
if test_func(x_l) == 0
    root = x_l;
    break
end
if test_func(x_r) == 0
    root = x_r;
    break
end 
if test_func(x_mid) == 0
    root = x_mid;
    break
end
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
