function [root, guesses] = Bisection_method(x_l, x_r, thresh, fun)

    % defines function
    test_func = fun{1};
    guesses = [];
    
    % flip x_l and x_r if in wrong order
    if (x_l >= x_r)
        temp = x_l;
        x_l = x_r;
        x_r = temp;
    end
    
    %disp(test_func(x_l))
    % bisection safeguard: terminates if initial guesses don't contain crossing
    if (test_func(x_l) < 0 && test_func(x_r) < 0) || (test_func(x_l) > 0 && test_func(x_r) > 0)
        root = NaN;
        return
    end
    
    while true
        x_mid = (x_l + x_r) / 2;
        
        % checks if within thresholds
        if abs(test_func(x_l)) < thresh
            root = x_l;
            % guesses = [guesses, root];
            break
        end
        if abs(test_func(x_r)) < thresh
            root = x_r;
            % guesses = [guesses, root];
            break
        end 
        if abs(test_func(x_mid)) < thresh
            root = x_mid;
            % guesses = [guesses, root];
            %disp(guesses)
            break
        end
        
        
        
        if (test_func(x_l) > 0 && test_func(x_mid) < 0) || (test_func(x_l) < 0 && test_func(x_mid) > 0)
            guesses = [guesses, x_r];
            x_r = x_mid;
        elseif (test_func(x_mid) > 0 && test_func(x_r) < 0) || (test_func(x_mid) < 0 && test_func(x_r) > 0)
            guesses = [guesses, x_l];
            x_l = x_mid;
        end
        
        % guesses = [guesses, x_mid];
    end
    x_mid = (x_l + x_r) / 2;
    guesses = [guesses, x_mid];
end

