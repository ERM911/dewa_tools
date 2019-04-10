clear
close all

eq = '0';

% load the parameters
params = get_parameters();

% we will check observability near the upright position
[A,B] = get_linearization(eq,params);

% choose the closed loop poles and compute the controller gain
closed_loop_poles = [-3 -2 -1 -2.5];
K = design_controller(A,B,closed_loop_poles);

% run the closed loop system using 'lsim'
x0 = 0.5*[1 1 1 1]';
[time,x_traj] = ode45(@(t,x) f(x,params,K), [0 10], x0);

% plot
make_plots(time,x_traj)
