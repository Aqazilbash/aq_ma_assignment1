function [xmin, xmax, ymin, ymax] = bounding_box(x0, y0, A_t, B_t, theta, egg_params, func_handles_x, func_handles_y)
    % Iterate through Secant method with guesses ranging from 0 to 1 to extract
    % s values at each of the 4 tangent points that help draw the boundary box
    
    guesses = 0:0.2:1;
    x_list = [];
    y_list = [];
    for i = 1:length(guesses)
        current_guess = guesses(i);
        [s_rootx, ~] = Secant_method(current_guess, current_guess + 0.001, A_t, B_t, func_handles_x);
        [s_rooty, ~] = Secant_method(current_guess, current_guess + 0.001, A_t, B_t, func_handles_y);
        %sx = fzero(func_handles_x{1}, current_guess)
        %sy = fzero(func_handles_y{1}, current_guess)

        % finds points for guesses
        [V, ~] = egg_func(s_rootx, x0, y0, theta, egg_params);
        x_list(end+1) = V(1);
        [V, ~] = egg_func(s_rooty, x0, y0, theta, egg_params);
        y_list(end+1) = V(2);
    end
    xmax = max(x_list);
    xmin = min(x_list);
    ymax = max(y_list);
    ymin = min(y_list);

    %s_left = min(x_list);
    %s_right = max(x_list);
    %s_bottom = min(y_list);
    %s_top = max(y_list);

    eggplot(0, x0, y0, theta, egg_params); hold on
    %eggplot(s_right, x0, y0, theta, egg_params); hold on
    %eggplot(s_bottom, x0, y0, theta, egg_params); hold on
    %eggplot(s_top, x0, y0, theta, egg_params); hold on

    % Get left and right x-coordinates for bounding box
    %[V_left, ~] = egg_func(s_left, x0,y0,theta,egg_params);
    %[V_right, ~] = egg_func(s_right, x0,y0,theta,egg_params);
    %disp(V_left)
    %disp(V_right)

    % Get bottom and top y-coordinates for bounding box
    %[V_bottom, ~] = egg_func(s_bottom, x0,y0,theta,egg_params);
    %[V_top, ~] = egg_func(s_top, x0,y0,theta,egg_params);

    % Plot bounding box
    %x_egg = [xmin,  xmax, xmax, xmin, xmin]; hold on
    %y_egg = [ymin, ymin, ymax, ymax, ymin];
    scatter(xmin, ymin); hold on
    scatter(xmax, ymax)
    %plot(x_egg, y_egg, '-')
    %axis equal

    %xmin = V_left(1);
    %xmax = V_right(1);
    %ymin = V_bottom(2);
    %ymax = V_top(2);
end