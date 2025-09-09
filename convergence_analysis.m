%Example template for analysis function
%INPUTS:
%solver_flag: an integer from 1-4 indicating which solver to use
% 1->Bisection 2-> Newton 3->Secant 4->fzero
%fun: the mathematical function that we are using the
% solver to compute the root of
%x_guess0: the initial guess used to compute x_root
%guess_list1: a list of initial guesses for each trial
%guess_list2: a second list of initial guesses for each trial
% if guess_list2 is not needed, then set to zero in input
%filter_list: a list of constants used to filter the collected data
function convergence_analysis(solver_flag, fun, x_guess0, guess_list1, guess_list2, filter_list, A_t, B_t)

    trials_xn = [];
    trials_xnplus1 = [];
    trials_n = [];
    true_root = fzero(fun{1}, x_guess0);


    for i = 1:length(guess_list1)

        if solver_flag == 1
            [~, guesses] = Bisection_method(guess_list1(i), guess_list2(i), B_t, fun);
        elseif solver_flag == 2
            [~, guesses] = Newtons_method(guess_list1(i), A_t, B_t, fun);
        elseif solver_flag == 3
            [~, guesses] = Secant_method(guess_list1(i), guess_list2(i), A_t, B_t, fun);
        elseif solver_flag == 4
        
        end

        trials_xn = [trials_xn, guesses(1:length(guesses)-1)];
        trials_xnplus1 = [trials_xnplus1, guesses(2:length(guesses))];
        trials_n = [trials_n, 1:(length(guesses)-1)];
        % for j = 1:length(secant_guesses)
        %     trials_n = [trials_n, i];
        % end

    end

    % Calculate errors
    error = [trials_xn] - true_root;
    errorplus1 = [trials_xnplus1] - true_root;

    % Filter the error data
    %data points to be used in the regression
    x_regression = []; % e_n
    y_regression = []; % e_{n+1}

    % Iterate through the collected data
    for n=1:length(error)
        %if the error is not too big or too small
        %and it was enough iterations into the trial...
        if error(n)>1e-15 && error(n)<1e-2 && errorplus1(n)>1e-14 && errorplus1(n)<1e-2 && trials_n(n)>2
            %then add it to the set of points for regression
            x_regression(end+1) = error(n);
            y_regression(end+1) = errorplus1(n);
        end
    end

    % Generate log-log plot of error data
    loglog(error,errorplus1,'ro','markerfacecolor','r','markersize',1);
    hold on;
    loglog(x_regression,y_regression,'bo','markerfacecolor','r','markersize',1);

    [p,k] = generate_error_fit(x_regression, y_regression);

    % Plot fit line
    % Generate x data on a logarithmic range
    fit_line_x = 10.^[-16:.01:1];
    % Compute the corresponding y values
    fit_line_y = k*fit_line_x.^p;
    % Plot on a loglog plot.
    loglog(fit_line_x,fit_line_y,'k-','linewidth',2)

    % Call function to approximate derivative (function at the end of the script)
    [p,k] = approximate_derivative(fun{1}, true_root);


end

% Compute the fit line
% Data points to be used in the regression
% x_regression -> e_n
% y_regression -> e_{n+1}
% p and k are the output coefficients
function [p,k] = generate_error_fit(x_regression,y_regression)
%generate Y, X1, and X2
%note that I use the transpose operator (')
%to convert the result from a row vector to a column
%If you are copy-pasting, the ' character may not work correctly
Y = log(y_regression)';
X1 = log(x_regression)';
X2 = ones(length(X1),1);
%run the regression
coeff_vec = regress(Y,[X1,X2]);
%pull out the coefficients from the fit
p = coeff_vec(1);
k = exp(coeff_vec(2));
end

% Implement finite difference approximation for the first and second derivative of a function
% INPUTS:
% fun: the mathetmatical function we want to differentiate
% x: the input value of fun that we want to compute the derivative at
% OUTPUTS:
% dfdx: approximation of fun'(x)
% d2fdx2: approximation of fun''(x)
function [dfdx,d2fdx2] = approximate_derivative(test_func01,x)
% Set the step size to be tiny
delta_x = 1e-6;

% Compute the function at different points near x
f_left = test_func01(x-delta_x);
f_0 = test_func01(x);
f_right = test_func01(x+delta_x);

% Approximate the first derivative
dfdx = (f_right-f_left)/(2*delta_x);
% Approximate the second derivative
d2fdx2 = (f_right-2*f_0+f_left)/(delta_x^2);
fprintf('dfdx = %.6e\n', dfdx);
fprintf('d2fdx2 = %.6e\n', d2fdx2);
end
