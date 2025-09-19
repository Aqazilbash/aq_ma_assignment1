%Function that computes the collision time for a thrown egg
%INPUTS:
%traj_fun: a function that describes the [x,y,theta] trajectory
% of the egg (takes time t as input)
%egg_params: a struct describing the hyperparameters of the oval
%y_ground: height of the ground
%x_wall: position of the wall
%OUTPUTS:
%t_ground: time that the egg would hit the ground
%t_wall: time that the egg would hit the wall
function [t_ground,t_wall] = collision_func(traj_func, t, egg_params, y_ground, x_wall, func_handles_x, func_handles_y, A_t, B_t)
%Pseudocode:
% Create function that maps time to xegg, yegg, and thetaegg I.e. xegg(t), yegg(t), thetaegg(t)
% Solve for new s positions based on these and the points used to draw the
% bounding box
% Pass xegg(t), yegg(t), thetaegg(t) and the 4 new s positions to eggfunc,
% which should return xmin, xmax, ymin, and ymax. Find root of ymin(t) to
% find the ground time and root of xmax(t) to find the wall time

t_ground = 0;
    t_wall = 0;
    step_size = 0.1;
[y_min] = egg_wrapper_max_y(t_ground, traj_func, egg_params, func_handles_x, func_handles_y, A_t, B_t);
[x_max] = egg_wrapper_max_x(t_wall, traj_func, egg_params, func_handles_x, func_handles_y, A_t, B_t);

    while x_max < x_wall
        t_wall = t_wall + step_size;
        disp(x_max)
        disp(t_wall)
        [x_max] = egg_wrapper_max_x(t_wall, traj_func, egg_params, func_handles_x, func_handles_y, A_t, B_t);
    end

    while y_min > y_ground
        %disp(y_min)
        t_ground = t_ground + step_size;
        [y_min] = egg_wrapper_max_y(t_ground, traj_func, egg_params, func_handles_x, func_handles_y, A_t, B_t);
    end


end


    function [x_max] = egg_wrapper_max_x(t, traj_func, egg_params, func_handles_x, func_handles_y, A_t, B_t)
        [x0_t,y0_t,theta_t] = traj_func(t);
        [~, x_max, ~, ~] = bounding_box(x0_t, y0_t, A_t, B_t, theta_t, egg_params, func_handles_x, func_handles_y);
        %(x_max - x_min) * (y_max - y_min)
    end

    function [y_min] = egg_wrapper_max_y(t, traj_func, egg_params, func_handles_x, func_handles_y, A_t, B_t)
        [x0_t,y0_t,theta_t] = traj_func(t);
        [~, ~, y_min, ~] = bounding_box(x0_t, y0_t, A_t, B_t, theta_t, egg_params, func_handles_x, func_handles_y);
        %disp(y_min)
    end
