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

Gx_vals = [];
for i = linspace(0,1,100)
    [Vx, Gx] = x_wrapper(i,x0,y0,theta,egg_params);
    Gx_vals(end+1) = Gx;
end

% % Iterate through Secant method with guesses ranging from 0 to 1 to extract
% % s values at each of the 4 tangent points that help draw the boundary box
% s_x = [];
% s_y = [];
% guess1 = 0;
% guess2 = 0.25;
% for i = 1:50
%     [sx, ~] = Secant_method(guess1, guess2, A_t, B_t, func_handles_x);
%     guess1 = guess1 + 0.05;
%     guess2 = guess2 + 0.05;
%     s_x = [s_x, sx];
%     [sy, ~] = Secant_method(guess1, guess2, A_t, B_t, func_handles_y);
%     s_y = [s_y, sy];
%     [~, Gx] = egg_func(sx, x0, y0, theta, egg_params); hold on
%     [~, Gy] = egg_func(sy, x0, y0, theta, egg_params); hold on
% end
% 
% s_left = min(s_x);
% s_right = max(s_x);
% s_bottom = min(s_y);
% s_top = max(s_y);
% 
% eggplot(s_left, x0, y0, theta, egg_params); hold on
% eggplot(s_right, x0, y0, theta, egg_params); hold on
% eggplot(s_bottom, x0, y0, theta, egg_params); hold on
% eggplot(s_top, x0, y0, theta, egg_params); hold on
% 
% % [V1, G1] = egg_func(s, x0, y0, theta, egg_params); hold on
% % [V2, G2] = egg_func(s2, x0, y0, theta, egg_params); hold on
% % [V3, G3] = egg_func(s3, x0, y0, theta, egg_params); hold on
% % [V4, G4] = egg_func(s4, x0, y0, theta, egg_params); hold on
% 
% % Get left and right x-coordinates for bounding box
% [V_left, ~] = egg_func(s_left, x0,y0,theta,egg_params);
% [V_right, ~] = egg_func(s_right, x0,y0,theta,egg_params);
% 
% % Get bottom and top y-coordinates for bounding box
% [V_bottom, ~] = egg_func(s_bottom, x0,y0,theta,egg_params);
% [V_top, ~] = egg_func(s_top, x0,y0,theta,egg_params);
% 
% % Plot bounding box
% x_egg = [V_left(1),  V_right(1), V_right(1), V_left(1), V_left(1)];
% y_egg = [V_bottom(2),V_bottom(2),V_top(2), V_top(2), V_bottom(2)];
% plot(x_egg, y_egg, '-')
% axis equal

y_ground = 1;
x_wall = 2;
time = 5;
[tground, twall] = collision_func(@egg_trajectory01, time, egg_params, y_ground, x_wall);

% helper wrapper that extracts 2nd output
function Gx = select_Gx(s, x0,y0,theta,egg_params)
    [~, Gx] = x_wrapper(s,x0,y0,theta,egg_params);
end

% helper wrapper that extracts 2nd output
function Gy = select_Gy(s, x0,y0,theta,egg_params)
    [~, Gy] = y_wrapper(s,x0,y0,theta,egg_params);
end