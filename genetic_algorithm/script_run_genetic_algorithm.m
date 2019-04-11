clear
close all

% physical parameters
params.k1 = 80E9;          % bulk modulus (Pa)
params.mu1 = 30E9;         % shear modulus (Pa)
params.s1 = 1E7;           % Electrical Conductivity (S/m)
params.kstarD = 111E9;     % Desired bulk modulus (Pa)
params.ustarD = 47E9;      % Desired Shear Modlus (Pa)
params.sstarD = 2E7;       % Desired electrical conductivity (S/m)
params.TOLk = 0.5;         % Bulk modulus tolerance
params.TOLu = 0.5;         % Shear modulus tolerance

params.k2range = [params.k1 10*params.k1];
params.mu2range = [params.mu1 10*params.mu1];
params.s2range = [params.s1 10*params.s1];
params.v2range = [0 2/3];

% Weights
params.w1 = 1; 
params.w2 = 1; 
params.w3 = 1; 
params.w4 = 0.5; 
params.w5 = 0.5; 
params.w6 = 0.5; 
params.w7 = 0.5; 
params.p = 2; 
params.q = 2;               % Cost function constants
params.theta = 0.5;         % Coefficient for effective property calculation
TOL = 1E-6;                 % Tolerance for cost function
max_generations = 100;

keepP = 1;                      % Choosing option to keep parents

% create the population
N = 100;                        % Number of individuals
num_parents = 10;               % Number of parents to keep
num_couples = num_parents / 2;

population = population_sort(draw_random_indviduals(N,params));
best_individual = population(1);

num_generations = 0;
while population(1).unfitness>TOL && num_generations<max_generations
    
    % pick the top individuals for mating, and shuffle them
    parents = population(randperm(num_parents));
    
    offspring = repmat(Individual,1,2*num_couples);
    c = 1;
    for i=1:num_couples
        p1 = parents(1+2*(i-1));
        p2 = parents(2*i);
        
        % create two offspring
        offspring(c)   = Individual(params,p1,p2);
        offspring(c+1) = Individual(params,p1,p2);
        c = c+2;
    end
    
    % Checking condition for keeping parents
    if keepP
        population = [population offspring];
        population = [population draw_random_indviduals(N-2*num_couples,params)];
    else
        population = offspring;
        population = [population draw_random_indviduals(N,params)];
    end
    clear offspring
    
    % generate M new random individuals
    
    % sort
    population = population_sort(population);

    % store the best
    best_individual = [best_individual population(1)];
    
    num_generations = num_generations + 1;
end

% toc
loglog([best_individual.unfitness],'linewidth',2)
xlabel('Generation')
ylabel('Unfitness')
set(gca,'FontSize',10)
grid