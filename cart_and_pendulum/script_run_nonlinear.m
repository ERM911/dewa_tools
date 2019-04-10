clear
close all

% load the parameters
params = get_parameters();

% initial condition and time span
x0 = [0 -1 0 1];
tspan = [0 20];

% integrate the model
[time,x_traj] = ode45(@(t,x) f(x,params), tspan, x0);

% plot
make_plots(time,x_traj)