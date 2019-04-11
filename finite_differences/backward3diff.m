function [dy] = backward3diff(y,dx)
yip1 = [y(2:end) y(1)];
yi = y;
yim1 = [y(end) y(1:end-1)];
yim2 = [y(end-1) yim1(1:end-1)];
dy = (2*yip1 + 3*yi - 6*yim1 + yim2)/6/dx;