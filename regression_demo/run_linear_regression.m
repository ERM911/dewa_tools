function theta = run_linear_regression(X,Y,orders,doplot)

x = linspace(min(X),max(X))';

% data plot
if doplot
    figure
    plot(X,Y,'.','MarkerSize',8,'DisplayName','data')
    hold on
    grid
    xlabel('X')
    ylabel('Y')
end

theta = cell(1,numel(orders));
for i = 1:numel(orders)
    order = orders(i);
    theta{i} = solve_poly_regression(X,Y,order);
    if doplot
        plot(x,eval_poly(x,theta{i}),'LineWidth',3,'DisplayName',sprintf('order %d',order));
    end
end

if doplot
    legend()
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function theta = solve_poly_regression(X,Y,ell)
phi = @(x,z) x.^z;
num_samp = numel(X);
Phi = ones(num_samp,1) ;
for i=1:ell
    Phi = [Phi phi(X,i)];
end

% Matlab's "\" is the pseudo-inverse operator!
theta = Phi\Y;
