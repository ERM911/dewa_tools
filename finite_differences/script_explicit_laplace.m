% explicit Laplace

clear
close all

X = 10;
Y = 10;
Nx = 100;
Ny = 100;

x = linspace(0,X,Nx);
y = linspace(0,Y,Ny);
dx = X/(Nx-1);
dy = Y/(Ny-1);

ry = dy^2 / (dx^2 + dy^2);
rx = 1-ry;

Lambda = 0:0.1:0.9;

for l = 1:numel(Lambda)
    l

    u = zeros(numel(x),numel(y));
    u(1,:) = 20;
    u(end,:) = 20;
    u(:,end) = 20; %linspace(0,20,Nx);
    u(:,1) = 20;
    error = nan(1,100);
    
    [yy,xx] = meshgrid(y,x);
    clf
    s=surf(xx,yy,u,'EdgeAlpha',0.5,'FaceAlpha',0.8);
    
    for k = 1:1000
        
        uold = u;
        for i = 2:numel(x)-1
            for j=2:numel(y)-1
                unew = ry * mean([u(i-1,j) u(i+1,j)]) + rx*mean([u(i,j-1) u(i,j+1)]);
                u(i,j) = unew + Lambda(l)*(unew - u(i,j));                
            end
        end
        
        error(k) = norm(uold-u);

        set(s,'ZData',u)
        axis([0    10     0    10     0    20])
        drawnow()
        
        if error(k)<1e-2
            numit(l) = k;
            break
        end
        
    end

end

[yy,xx] = meshgrid(y,x);
figure
surf(xx,yy,u,'EdgeAlpha',1,'FaceAlpha',0.8)

figure
contour(xx,yy,u)

figure
plot(error)
