start_time = 0;                     % Start time, in seconds.
end_time = 120;                     % End time, in seconds.
dt = 1/30;                          % Time step, in seconds.
 
f = 1;                              % Pendulum base frequency, in Hz. 

frequency_offset = 1/60;            % Difference in frequency between each pendulum.

num_balls = 15;                     % Number of balls in the simulation.




T = 1/f;                            % Pendulum base period, in seconds.
                       
t = start_time:dt:end_time;         % Construct time vector.
x = zeros(num_balls,length(t));     % Create empty array for each ball.


for i=1:num_balls 
  x(i,:) = cos(2*pi*t/T);    % Generate waves
  f = f + frequency_offset;  % Increment frequency by the offset.
  T = 1/f;                   % Calculate new period.
end


% Color array (Meant to resemble the colors of the billiard balls in the source video).
RGB = [[131 3 0]; [0 255 0];  [249 129 42]; [137 41 133]; [255 0 0]; [0 0 255]; [220 220 0]; ...
        [0 0 0]; [200 0 0]; [0 220 0]; [253 106 2]; [107 1 125]; [255 0 0]; [0 0 220]; [200 200 0]]/255;
% Note: You need to add colors to this array if you want to add more than 15 "billiard balls".



% Create and scale figure
fig = figure;         % Create new figure.
set(fig,'position', [100,100, 1000,1000]);    % Scale figure (affects display only, not saved .png files).
hold on               % Hold Figure

for i = 1:length(t)   % Generate animation frames one at a time.
  time = t(i);        % Store current time.
  scatter(x(:,i), 15:-1:1, 300, RGB, 'filled');  % Use a scatter plot with very large point size (300) to represent the pendulum balls.
  xlim([-1.1 1.1]);   % Set x-axis extents.
  ylim([0,16]);       % Set y-axis extents.
  str = sprintf('Time = %.3f seconds', time);   % Display time with 3 decimal precision.
  % Apply labels to the x and y-axes and the figure title.
  set(gca,'fontsize', 20, 'xlabel','X-axis Position [Arbitrary Units]','ylabel', 'Ball Number', 'ytick', 1:15, 'title', str);
  file = sprintf('frame%04d.png', (i-1)/5);   % Store to a .png file in the current working directory.
  print(fig, file);   % Save 
  clf                 % Clear Figure
end
