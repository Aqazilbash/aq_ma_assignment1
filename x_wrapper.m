function [Vx, Gx] = x_wrapper(s, x0,y0,theta,egg_params)
    [V, G] = egg_func(s,x0,y0,theta,egg_params);
    Vx = V(1);
    Gx = G(1);
end