function [dy] = backwarddiff(y,dx)
yi = y;
yim1 = [y(end) y(1:end-1)];
dy = (yi-yim1)/dx;