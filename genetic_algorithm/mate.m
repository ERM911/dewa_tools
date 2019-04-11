function offspring = mate(p1,p2)

k2 = linear_combination(p1.k2,p2.k2);
mu2 = linear_combination(p1.mu2,p2.mu2);
s2 = linear_combination(p1.s2,p2.s2);
v2 = linear_combination(p1.v2,p2.v2);


function [x] = linear_combination(x0,x1)
alpha = rand(1);
x = alpha*x0 + (1-alpha)*x1;
