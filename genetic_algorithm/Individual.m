classdef Individual < handle
    
    properties
        k2
        mu2
        s2
        v2
        unfitness
    end
    
    methods
        
        function obj = Individual(params,p1,p2)
            
            if nargin==0
                return
            end
            
            % create an individual from nothing
            if nargin==1
                obj.k2 = rand_in_range(params.k2range);
                obj.mu2 = rand_in_range(params.mu2range); 
                obj.s2 = rand_in_range(params.s2range);
                obj.v2 = rand_in_range(params.v2range);
            end
            
            % create an individual from two parents
            if nargin==3
                obj.k2 = Individual.linear_combination(p1.k2,p2.k2);
                obj.mu2 = Individual.linear_combination(p1.mu2,p2.mu2);
                obj.s2 = Individual.linear_combination(p1.s2,p2.s2);
                obj.v2 = Individual.linear_combination(p1.v2,p2.v2);
            end
            
            calculate_unfitness(obj,params);

        end
        
      
        function calculate_unfitness(obj,params)
            
            HS = Individual.calclulate_Hashin_Shtrikman(obj,params);
            
            EP = Individual.calculate_effective_properties(params,HS);
            
            SC = Individual.calculate_stress_concentration(obj,params,EP);
            
            % evaluate_weights
            w4hat = params.w4.*((abs(SC.Ck2-1) > params.TOLk));
            w5hat = params.w5.*((abs(SC.Cu2-1) > params.TOLu));
            w6hat = params.w6.*((abs(SC.Ck1-1) > params.TOLk));
            w7hat = params.w7.*((abs(SC.Cu1-1) > params.TOLu));
            
            p = params.p;
            q = params.q;
            obj.unfitness = params.w1 * (abs((EP.kstar./params.kstarD) -1)^p) + ...
                params.w2 *(abs((EP.ustar./params.ustarD) -1)^p) + ...
                params.w3 *(abs((EP.sstar./params.sstarD) -1)^p) + ...
                w4hat *((abs(SC.Ck2-1)-params.TOLk)^q) + ...
                w5hat *((abs(SC.Cu2-1)-params.TOLu)^q) + ...
                w6hat *((abs(SC.Ck1-1)-params.TOLk)^q) + ...
                w7hat *((abs(SC.Cu1-1)-params.TOLu)^q); 
        end
        
    end
    
    methods(Static)
        
        function HS = calclulate_Hashin_Shtrikman(obj,params)

            k1 = params.k1;
            mu1 = params.mu1;
            s1 = params.s1;
            
            HS.k2sM = k1 + (obj.v2./((1)./(obj.k2-k1) + ((3*(1-obj.v2))./(3*k1+4*mu1))));
            HS.k2sP = obj.k2 + ((1-obj.v2)./((1)./(k1-obj.k2) + ((3*obj.v2)./(3*obj.k2+4*obj.mu2))));

            HS.u2sM = mu1 + ((obj.v2)./((1)./(obj.mu2-mu1) + ((6*(1-obj.v2).*(k1+2*mu1))./...
                (5*mu1*(3*k1+4*mu1)))));
            HS.u2sP = obj.mu2 + ((1-obj.v2)./((1)./(mu1-obj.mu2) + ((6*obj.v2.*(obj.k2+2*obj.mu2))./...
                (5*obj.mu2.*(3*obj.k2+4*obj.mu2)))));

            HS.s2sM = s1 + ((obj.v2)./((1)./(obj.s2-s1) + (((1-obj.v2))./(3*s1))));
            HS.s2sP = obj.s2 + ((1-obj.v2)./((1)./(s1-obj.s2) + (((obj.v2))./(3*obj.s2))));
        end
        
        function EP = calculate_effective_properties(params,HS)
            theta = params.theta;
            EP.kstar = theta*HS.k2sP + (1-theta)*HS.k2sM;
            EP.ustar = theta*HS.u2sP + (1-theta)*HS.u2sM;
            EP.sstar = theta*HS.s2sM + (1-theta)*HS.s2sP;
        end
        
        function SC = calculate_stress_concentration(obj,params,EP)
            
            k1 = params.k1;
            mu1 = params.mu1;
            
            SC.Ck2 = (1./obj.v2)*(obj.k2./EP.kstar)*((EP.kstar-k1)./(obj.k2-k1));
            SC.Ck1 = (1./(1-obj.v2))*(1-obj.v2*SC.Ck2);
            
            SC.Cu2 = (1./obj.v2)*(obj.mu2./EP.ustar)*((EP.ustar-mu1)./(obj.mu2-mu1));
            SC.Cu1 = (1./(1-obj.v2))*(1-obj.v2*SC.Cu2);
        end

        
        function [x] = linear_combination(x0,x1)
            alpha = rand(1);
            x = alpha*x0 + (1-alpha)*x1;
        end
        
    end
    
end

