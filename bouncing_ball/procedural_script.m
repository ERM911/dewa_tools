

% clean slate
clear
close all

% define the time array
dt = 0.01; % [s]
time = linspace(0,1,1000)*dt;

% parameters
g = 9.8; % [m/s/s]
gamma = 0.8;

% allocate position and velocity variables
x = nan(1,numel(time));   % [m]
y = nan(1,numel(time));   % [m]
vx = nan(1,numel(time));   % [m/s]
vy = nan(1,numel(time));   % [m/s]

% initialize position and velocity
x(1) = 0;
y(1) = 10; 
vx(1) = 1;
vy(1) = 0;

for k = 1:numel(time)-1
    
    % equations of motion
    vx(k+1) = vx(k);
    vy(k+1) = vy(k) - g*dt;
    
    x(k+1) = x(k) + mean(vx(k:k+1))*dt;
    y(k+1) = y(k) + mean(vy(k:k+1))*dt;
    
    % bouncing
    if y(k+1)<0
        y(k+1) = 0;
        vy(k+1) = -gamma*vy(k+1);
    end
    
end

% plot
figure
clf
plot(x,y)