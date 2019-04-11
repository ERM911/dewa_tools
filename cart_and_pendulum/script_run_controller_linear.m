clear
close all

eq = '0';

% load the parameters
params = get_parameters();

% we will check observability near the upright position
[A,B] = get_linearization(eq,params);

% choose the closed loop poles and compute the controller gain
closed_loop_poles = 10*[-3 -2 -1 -2.5];
K = design_controller(A,B,closed_loop_poles);

% create a state space object for the closed loop system using 'ss'
sys_cl = ss(A-B*K,B,eye(4),0);

% run the closed loop system using 'lsim'
x0 = [1 1 1 1]';
time = linspace(0,10);
x_traj = lsim(sys_cl,0*time,time,x0);

% plot
make_plots(time,x_traj)
