function x=draw_random_indviduals(n,params)
x = repmat(Individual(),1,n);
for i=1:n
    x(i) = Individual(params);
end