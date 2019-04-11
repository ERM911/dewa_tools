function [dy] = backward2diff(y,dx)
yi = y;
yim1 = [y(end) y(1:end-1)];
yim2 = [y(end-1) yim1(1:end-1)];
dy = (3*yi - 4*yim1 + yim2)/2/dx;