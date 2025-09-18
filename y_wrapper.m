function [Vy, Gy] = y_wrapper(s,x0,y0,theta,egg_params)
    [V, G] = egg_func(s,x0,y0,theta,egg_params);
    Vy = V(2);
    Gy = G(2);
end