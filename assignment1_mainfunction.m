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
    a = -20; % Lower bound
    b = 40; % Upper bound
    randguess1 = a + (b - a) * rand();
    randguess2 = a + (b - a) * rand();
    guess_list1 = [guess_list1, randguess1];
    guess_list2 = [guess_list2, randguess2];
end

convergence_analysis(2, fun, 0.9, guess_list1, guess_list2, [], A_t, B_t)
% Queries solver functions to find the root
% [ans_bisection, bisection_guesses] = Bisection_method(-10, 20, B_t, fun);
% [ans_secant, secant_guesses] = Secant_method(-10, 20, A_t, B_t, fun);
% [ans_newtons, newton_guesses] = Newtons_method(5, A_t, B_t, fun);

% Plot function
% x = linspace(-15, 40, 100);
% test_func02 = (x.^3)/100 - (x.^2)/8 + 2*x + 6*sin(x/2+6) -.7 - exp(x/6);
% 
% figure;
% plot(x, test_func02); % plot function
% hold on;
% yline(0, '--r'); 
% 
% % Plot roots from different methods (uncomment one at a time to see each)
% %plot(ans_bisection, 0, 'ko', 'MarkerSize', 8, 'DisplayName', 'Bisection Root');
% %plot(ans_newtons, 0, 'go', 'MarkerSize', 8, 'DisplayName', 'Newton Root');
% plot(ans_secant, 0, 'mo', 'MarkerSize', 8, 'DisplayName', 'Secant Root');
% 
% legend('Location', 'best');
% xlabel('x');
% ylabel('f(x)');
% grid on;
% hold off;

% Collect test data
% randguess1 = 0;
% randguess2 = 0;

% secant_xn = [];
% secant_xnplus1 = [];
% secant_n = [];
% 
% true_root = ans_newtons;
% for i = 1:200
%     a = -20; % Lower bound
%     b = 40; % Upper bound
%     randguess1 = a + (b - a) * rand();
%     randguess2 = a + (b - a) * rand();
%     [~, secant_guesses] = Secant_method(randguess1, randguess2, A_t, B_t, fun);
%     secant_xn = [secant_xn, secant_guesses(1:length(secant_guesses)-1)];
%     secant_xnplus1 = [secant_xnplus1, secant_guesses(2:length(secant_guesses))];
%     for j = 1:length(secant_guesses)
%         secant_n = [secant_n, i];
%     end
% end
% disp(secant_xn)
% disp(secant_xnplus1)
% disp(secant_n)



