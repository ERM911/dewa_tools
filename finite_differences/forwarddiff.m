function [dy] = forwarddiff(y,dx)
yi = y;
yip1 = [y(2:end) y(1)];
dy = (yip1-yi)/dx;
