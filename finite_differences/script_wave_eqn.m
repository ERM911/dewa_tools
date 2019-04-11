clear
close all;

figure('Position',[289 81 1056 680])

%% Setup
Nx = 500;
x = linspace(0,10,Nx+1);
dx = 10/Nx;
a = 1;
tfinal = 5.5;
dt = 0.001;

%% Initial condition
Ureal = @(x,t) 0.75*exp(-((x-t-0.5)/0.1).^2);
U = Ureal(x,0);

%% Loop 
T = 0:dt:tfinal;
error = nan(1,numel(T));
for k=1:numel(T)
    
    t = T(k);
    
    % choose the solver
%     U = nan*Ureal(x,t);     % no solver, only real wave
%     U = U - dt*a*backwarddiff(U,dx);
%     U = U - dt*a*forwarddiff(U,dx);
%     U = U - dt*a*centraldiff(U,dx);
%     U = U - dt*a*backward2diff(U,dx);
    U = U - dt*a*backward3diff(U,dx);

    % compute error
    ureal = Ureal(x,t);
    error(k) = 100*sum((U-ureal).^2);
    
    % plot solution
    if mod(t,0.02)==0
        clf
        plot(x,ureal,'b','LineWidth',2);
        hold on;
        plot(x,U,'mo-','MarkerSize',4,'LineWidth',2);
        title(sprintf('t = %.2f,    error = %.2f',t,error(k)),'FontSize',16);
        axis([a*t-0.5, a*t+1.5, -0.6, 1]);
        grid on;
        drawnow;
    end
end
