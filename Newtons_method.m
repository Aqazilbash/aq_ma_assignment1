function [root, guesses] = Newtons_method(xn, A_thresh, B_thresh, fun)

% Defines function and its derivative
test_func = fun{1};
test_derivative = fun{2};
guesses = [];

while true

  % Division safeguard
        if abs(test_func(xn)) < 1e-14
            root = xn;
            guesses = [guesses, xn];
            %disp(guesses)
            return
        end

        % Newton update
        xn1 = xn - test_func(xn) / test_derivative(xn);

        % Early termination
        if abs(xn1 - xn) < A_thresh || abs(test_func(xn)) < B_thresh
            root = xn1;
            guesses = [guesses, xn1];
            % disp(guesses);
            return
        end

        % Update current guess
        xn = xn1;
        guesses = [guesses, xn1];
end
 %disp(guesses);
end