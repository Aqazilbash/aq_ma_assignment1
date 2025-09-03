function [root] = Newtons_method(xn, A_thresh, B_thresh, fun)

% Defines function and its derivative
test_func = fun{1};
test_derivative = fun{2};

while true

  % Division safeguard
        if abs(test_func(xn)) < 1e-14
            root = xn;
            return
        end

        % Newton update
        xn1 = xn - test_func(xn) / test_derivative(xn);

        % Early termination
        if abs(xn1 - xn) < A_thresh || abs(test_func(xn)) < B_thresh
            root = xn1;
            return
        end

        % Update current guess
        xn = xn1;
end

end