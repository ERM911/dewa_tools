clear
close all

load('datafile','Data')

% regression example
order = 1;
theta = run_linear_regression(Data.wt,Data.MPG,order,true);

disp(theta{1})
