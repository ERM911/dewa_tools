clear
close all

% define number of warehouses and destinations
n = 20;
m = 40;

% define unit transportation costs, supply, and demand
c = rand(n,m);
s = rand(n,1);
d = rand(m,1);

% create an index map
counter = 1;
index = nan(n,m);
for i = 1:n
    for j=1:m
        index(i,j) = counter;
        counter = counter + 1;
    end
end

% allocate A and B
A = zeros(2*(n+m),n*m);
B = zeros(2*(n+m),1);
row_count = 1;

% supply constraint
for i=1:n
    A(row_count,index(i,:)) = 1;
    B(row_count) = s(i);
    row_count = row_count + 1;
end

% demand constraint
for j=1:m
    A(row_count,index(:,j)) = -1;
    B(row_count) = -d(i);
    row_count = row_count + 1;
end

% positivity
for i=1:n
    for j=1:m
        A(row_count,index(i,j)) = -1;
        B(row_count) = 0;
        row_count = row_count + 1;
    end
end

% cost function
f = ones(n*m,1);

% solve
y = linprog(f,A,B);

% put in matrix form
Y = y(index);
