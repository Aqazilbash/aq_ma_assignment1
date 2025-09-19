% function egg_animation()
%     egg_params = struct();
%     egg_params.a = 3; egg_params.b = 2; egg_params.c = .15;
%     t = 0;
%     wall = 30;
%     ground = 0;
%     twall = 3.375;
%     tground = 3.575;
% 
%     % Set the position and orientation of the egg
%     x0 = 5; y0 = 5; theta = pi/6;
%     % Set up the plotting axis
% 
%     % Initialize plot of egg
% 
%     for t = 0: .001:twall
%         clf;
%          hold on; axis equal; axis square
%         axis([0, 40, -5, 40])
%          egg_plot = plot(0, 0, 'k');
%         [V_list, ~] = egg_func(linspace(0,1,100),x0,y0,theta,egg_params);
% 
%         % Compute position of egg center through time
%         [x0,y0,theta] = egg_trajectory01(t);
%         % eggplot(x0, y0, theta, egg_params);
%         yline(ground);
%         xline(wall);
%         % Update coordinates of egg plot
%         set(egg_plot, 'xdata', V_list(1,:), 'ydata', V_list(2,:));
%         % Update plotting window
%         drawnow;
%     end
% 
% end


% MATLAB animation of an egg tumbling through the air until it hits the wall. 
% The animation is stored in a video.

function egg_animation()
%define location and filename where video will be stored
%written a bit weird to make it fit when viewed in assignment
    egg_params = struct();
    egg_params.a = 3; egg_params.b = 2; egg_params.c = .15;
    t = 0;
    wall = 30;
    ground = 0;
    %twall = 3.375;
    twall = 3;
    %tground = 3.575;
    tground = 4;

    % Set the position and orientation of the egg
    x0 = 5; y0 = 5; theta = pi/6;
    % Set up the plotting axis

    % Initialize plot of egg
    %%%mypath1 = 'C:\Users\madelman\OneDrive - Olin College of Engineering\';
    %%%mypath2 = 'Third year\Applied Math\aq_ma_assignment1';
    %%%fname='egg_animation.avi';
    %%%input_fname = [mypath1,mypath2,fname];
    %create a videowriter, which will write frames to the animation file
    %%%writerObj = VideoWriter(input_fname);
    %must call open before writing any frames
    %%%open(writerObj);

    %initialize the current figure and save as object
    %%%fig1 = figure(1);
    %set up the plotting axis

    runtime = min(tground, twall);

    for t = 0: .005:runtime
        clf;
         hold on; axis equal; axis square
        axis([0, 40, -5, 40])
        egg_plot = plot(0, 0, 'k');
        
        [V_list, ~] = egg_func(linspace(0,1,100),x0,y0,theta,egg_params);
        % Compute position of egg center through time
        [x0,y0,theta] = egg_trajectory01(t);
        A_t = 10^(-14); B_t = 10^(-14);
        yline(ground);
        xline(wall);
        % Update coordinates of egg plot
        set(egg_plot, 'xdata', V_list(1,:), 'ydata', V_list(2,:));
   
        % Update plotting window
        drawnow;
        %capture a frame (what is currently plotted)
        %%%current_frame = getframe(fig1);
        %write the frame to the video
        %%%writeVideo(writerObj,current_frame);
    end

    %must call close after all frames are written
    %%%close(writerObj);
    end