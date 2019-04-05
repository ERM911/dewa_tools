
classdef Ball < handle
    
    properties
        x
        y
        vx
        vy
    end
    
    methods
        
        function [this] = Ball(x,y,vx,vy)
            this.x = x;
            this.y = y;
            this.vx = vx;
            this.vy = vy;
        end
        
        function [this] = move(this,g,dt,gamma)
            new_vx = this.vx(end);
            new_vy = this.vy(end) - g*dt;
            new_x = this.x(end) + mean([this.vx(end) new_vx])*dt;
            new_y = this.y(end) + mean([this.vy(end) new_vy])*dt;
            
            if new_y<0
                new_y = 0;
                new_vy = -gamma*new_vy;
            end
            
            this.vx(end+1) = new_vx;
            this.vy(end+1) = new_vy;
            this.x(end+1) = new_x;
            this.y(end+1) = new_y;
            
        end
        
        function []=plot_trajectory(this,fig)
            figure(fig)
            hold on
            plot(this.x,this.y)
        end
    end
    
end

