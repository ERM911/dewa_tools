function [dy] = centraldiff(y,dx)
yim1 = [y(end) y(1:end-1)];
yip1 = [y(2:end) y(1)];
dy = (yip1 - yim1)/2/dx;