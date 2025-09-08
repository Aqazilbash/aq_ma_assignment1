clear all
% Definition of the test function and its derivative
test_func01 = @(x) (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
test_derivative01 = @(x) 3*(x.^2)/100 - 2*x/8 + 2 +(6/2)*cos(x/2+6) - exp(x/6)/6;
fun = {test_func01, test_derivative01};

% Set early termination conditions through threshold values
A_t = 10^(-14);
B_t = 10^(-14);

% Queries solver functions to find the root
ans_bisection = Bisection_method(-10, 20, B_t, fun);
ans_secant = Secant_method(-10, 20, A_t, B_t, fun);
ans_newtons = Newtons_method(5, A_t, B_t, fun);

% Plotting
x = linspace(-15, 40, 100);
test_func02 = (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);

figure;
plot(x, test_func02); % plot function
hold on;
yline(0, '--r'); 

% Plot roots from different methods (uncomment one at a time to see each)
plot(ans_bisection, 0, 'ko', 'MarkerSize', 8, 'DisplayName', 'Bisection Root');
%plot(ans_newtons, 0, 'go', 'MarkerSize', 8, 'DisplayName', 'Newton Root');
%plot(ans_secant, 0, 'mo', 'MarkerSize', 8, 'DisplayName', 'Secant Root');

legend('Location', 'best');
xlabel('x');
ylabel('f(x)');
grid on;
hold off;