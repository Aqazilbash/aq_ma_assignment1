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
Vx_handle   = @(x) egg_func(x);             % by default, only first output
Gx_handle = @(x) select_Gx(x, x0,y0,theta,egg_params);

func_handles = {Gx_handle, Vx_handle};




Gx_vals = [];
for i = linspace(0,1,100)
    [Vx, Gx] = x_wrapper(i,x0,y0,theta,egg_params);
    Gx_vals(end+1) = Gx;
end
[s_left, ~] = Bisection_method(0, 0.5, B_t, func_handles);
[s_right, ~] = Bisection_method(0.5, 1, B_t, func_handles);

eggplot(s_right, x0, y0, theta, egg_params); hold on


% helper wrapper that extracts 2nd output
function Gx = select_Gx(x, x0,y0,theta,egg_params)
    [~, Gx] = x_wrapper(x,x0,y0,theta,egg_params);
end