function [root, guesses] = track_fzero(fun, x0)
    guesses = []; % store guesses here
    test_func = fun{01}
    % wrapper that logs each x value
    function y = wrapped_fun(x)
        guesses(end+1) = x;
        y = test_func(x);
    end

    % run fzero with the wrapped function
    root = fzero(@wrapped_fun, x0);
end