function y = eval_poly(x,theta)
phi = @(x,z) x.^z;
ell = numel(theta)-1;
y = theta(1)*ones(numel(x),1);
for i=1:ell
    y = y + theta(i+1)*phi(x,i);
end
