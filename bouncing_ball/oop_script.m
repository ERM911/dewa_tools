
% clean slate
clear
close all

% define the time array
dt = 0.01; % [s]
time = linspace(0,1,1000)*dt;

% parameters
g = 9.8; % [m/s/s]
gamma = 0.8;

% create two ball objects
for i=1:10
    ball(i) = Ball(10*rand()-5,rand(),10*rand()-5,10*rand()-5);
end

% loop through time steps
for k = 1:numel(time)-1
    for i=1:10
        ball(i).move(g,dt,gamma);
    end
end

% plot
fig = figure;
for i=1:10
    ball(i).plot_trajectory(fig)
end
