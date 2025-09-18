function egg_animation()
    egg_params = struct();
    egg_params.a = 3; egg_params.b = 2; egg_params.c = .15;
    t = 0;
    wall = 30;
    ground = 0;
    twall = 3.375;
    tground = 3.575;

    % Set the position and orientation of the egg
    x0 = 5; y0 = 5; theta = pi/6;
    % Set up the plotting axis

    % Initialize plot of egg
  
    for t = 0: .001:twall
        clf;
         hold on; axis equal; axis square
        axis([0, 40, -5, 40])
         egg_plot = plot(0, 0, 'k');
        [V_list, ~] = egg_func(linspace(0,1,100),x0,y0,theta,egg_params);

        % Compute position of egg center through time
        [x0,y0,theta] = egg_trajectory01(t);
        % eggplot(x0, y0, theta, egg_params);
        yline(ground);
        xline(wall);
        % Update coordinates of egg plot
        set(egg_plot, 'xdata', V_list(1,:), 'ydata', V_list(2,:));
        % Update plotting window
        drawnow;
    end

end

% [V_list, G_list] = egg_func(linspace(0,1,100),x0,y0,theta,egg_params);
% %plot the perimeter of the egg
% plot(V_list(1,:),V_list(2,:),'k');