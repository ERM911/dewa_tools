clear
close all

load('datafile','Data')

% regression example
order = 5;
theta = run_linear_regression(Data.wt,Data.MPG,order,true);

disp(theta{1})
