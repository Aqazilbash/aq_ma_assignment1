function [xmin, xmax, ymin, ymax] = bounding_box(x0, y0, A_t, B_t, theta, egg_params, func_handles_x, func_handles_y)
    % Iterate through Secant method with guesses ranging from 0 to 1 to extract
    % s values at each of the 4 tangent points that help draw the boundary box
    s_x = [];
    s_y = [];
    guess1 = 0;
    guess2 = 0.25;
    for i = 1:50
        [sx, ~] = Secant_method(guess1, guess2, A_t, B_t, func_handles_x);
        guess1 = guess1 + 0.05;
        guess2 = guess2 + 0.05;
        s_x = [s_x, sx];
        [sy, ~] = Secant_method(guess1, guess2, A_t, B_t, func_handles_y);
        s_y = [s_y, sy];
        [~, Gx] = egg_func(sx, x0, y0, theta, egg_params); hold on
        [~, Gy] = egg_func(sy, x0, y0, theta, egg_params); hold on
    end

    s_left = min(s_x);
    s_right = max(s_x);
    s_bottom = min(s_y);
    s_top = max(s_y);

    eggplot(s_left, x0, y0, theta, egg_params); hold on
    eggplot(s_right, x0, y0, theta, egg_params); hold on
    eggplot(s_bottom, x0, y0, theta, egg_params); hold on
    eggplot(s_top, x0, y0, theta, egg_params); hold on

    % Get left and right x-coordinates for bounding box
    [V_left, ~] = egg_func(s_left, x0,y0,theta,egg_params);
    [V_right, ~] = egg_func(s_right, x0,y0,theta,egg_params);

    % Get bottom and top y-coordinates for bounding box
    [V_bottom, ~] = egg_func(s_bottom, x0,y0,theta,egg_params);
    [V_top, ~] = egg_func(s_top, x0,y0,theta,egg_params);

    % Plot bounding box
    x_egg = [V_left(1),  V_right(1), V_right(1), V_left(1), V_left(1)];
    y_egg = [V_bottom(2),V_bottom(2),V_top(2), V_top(2), V_bottom(2)];
    plot(x_egg, y_egg, '-')
    axis equal

    xmin = V_left;
    xmax = V_right;
    ymin = V_bottom;
    ymax = V_top;
end