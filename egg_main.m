%specify the position and orientation of the egg
x0 = 5; y0 = 5; theta = pi/6;
    
%set the oval hyper-parameters
egg_params = struct();
egg_params.a = 3; egg_params.b = 2; egg_params.c = .15;

% threshold values
A_t = 10^(-14);
B_t = 10^(-14);

f  = @(x) egg_func(x);        % full call, but returns [V, G]
f  = @(x) egg_func(x);        % will still return two outputs if asked

% split them into dedicated single-output handles:
Vx_handle   = @(s_in) egg_func(s_in);             % by default, only first output
Gx_handle = @(s_in) select_Gx(s_in, x0,y0,theta,egg_params);

Vy_handle = @(s_in) egg_func(s_in);
Gy_handle = @(s_in) select_Gy(s_in, x0,y0,theta,egg_params);

func_handles_x = {Gx_handle, Vx_handle};

func_handles_y = {Gy_handle, Vy_handle};

% Gx_vals = [];
% for i = linspace(0,1,100)
%     [Vx, Gx] = x_wrapper(i,x0,y0,theta,egg_params);
%     Gx_vals(end+1) = Gx;
% end

% [x0,y0,theta] = egg_trajectory01(2.85);
% [V_list, ~] = egg_func(linspace(0,1,100),x0,y0,theta,egg_params);
% plot(V_list(1,:), V_list(2,:))
        % Compute position of egg center through time

x0_t = 5; y0_t = 5; theta_t = 0;
bounding_box(x0_t, y0_t, A_t, B_t, theta_t, egg_params, Gx_handle, Gy_handle);
time = 0;
y_ground = 0;
x_wall = 30;
%[tground, twall] = collision_func(@egg_trajectory01, time, egg_params, y_ground, x_wall, func_handles_x, func_handles_y, A_t, B_t)
%egg_animation();

% helper wrapper that extracts 2nd output
function Gx = select_Gx(s, x0,y0,theta,egg_params)
    [~, Gx] = x_wrapper(s,x0,y0,theta,egg_params);
end

% helper wrapper that extracts 2nd output
function Gy = select_Gy(s, x0,y0,theta,egg_params)
    [~, Gy] = y_wrapper(s,x0,y0,theta,egg_params);
end