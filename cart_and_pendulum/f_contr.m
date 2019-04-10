function xdot=f(x,params,K)

if nargin<3
    K = 0;
end

g = params.g;
M = params.M;
m = params.m;
c = params.c;
l = params.l;
sigma = params.sigma;

p = x(1);
pdot = x(2);
theta = x(3);
thetadot = x(4);

Z = M*l + m*l*(sin(theta))^2;

F = -K*x
xi1 = F - c*pdot - m*l*sin(theta)*thetadot^2;
xi2 = g*sin(theta) - sigma*thetadot/m/l;

pddot = ( l * xi1 + m*l* cos(theta)*xi2 ) / Z;
thetaddot = ( cos(theta)*xi1 + (M+m)*xi2 ) / Z;

xdot = [pdot pddot thetadot thetaddot]';