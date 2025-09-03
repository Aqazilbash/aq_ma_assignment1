clear all
%Definition of the test function and its derivative
test_func01 = @(x) (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
test_derivative01 = @(x) 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;
A_t = 10^(-14);
B_t = 10^(-14);
ans_bisection = Bisection_method(-10, 20, B_t, test_func01)

ans_secant = Secant_method(-10, 20, A_t, B_t, test_func01)