clear
close all

% solve minimization problem
options = optimoptions(@fmincon,'Display','iter','Algorithm','interior-point');
[x_star,fval] = fmincon(@rosenbrock,[0 0],[],[],[],[],[],[],@unitdisk,options);

% plot ............
num_x = 500;
num_y = 500;
h = 1.5;
[x_grid,y_grid] = meshgrid(linspace(-h,h,num_x),linspace(-h,h,num_y));
J = nan(num_x,num_y);
for i=1:size(x_grid,1)
    for j=1:size(x_grid,2)
        if x_grid(i,j)^2 + y_grid(i,j)^2 <2
            p = [x_grid(i,j),y_grid(i,j)];
            J(i,j) = rosenbrock(p);
        end
    end 
end

figure
h = surf(x_grid,y_grid,J);
h.FaceAlpha = 0.9;
h.EdgeAlpha = 0;

hold on 
t = linspace(0,2*pi);
plot3(sin(t),cos(t),0*t,'k','LineWidth',1);

for i=1:numel(t)
    r(i) = rosenbrock([sin(t(i)),cos(t(i))]);
end
plot3(sin(t),cos(t),r,'r','LineWidth',2);

% plot solution
plot3(x_star(1),x_star(2),fval,'g.','LineWidth',2,'MarkerSize',16)

