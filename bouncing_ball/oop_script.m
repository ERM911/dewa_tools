
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
ball1 = Ball(0,10,1,0);
ball2 = Ball(3,12,2,1);

% loop through time steps
for k = 1:numel(time)-1
    ball1.move(g,dt,gamma);
    ball2.move(g,dt,gamma);
end

% plot
fig = figure;
ball1.plot_trajectory(fig)
ball2.plot_trajectory(fig)

