clear
close all

% load the data from the data file
load('datafile','Data')

% define X and Y
X = Data.wt;
Y = Data.MPG;

% normalize the data
X = (X-mean(X))/std(X);
Y = (Y-mean(Y))/std(Y);

% run regression with nonlinear basis functions
orders = 1:10;
theta = run_linear_regression(X,Y,orders,false);

% plot first order (ie straight line approximation)
figure, grid, hold on
plot(X,Y,'.','MarkerSize',8)
x = linspace(min(X),max(X))';
yhat = theta{1}(1) + theta{1}(2)*x;
plot(x,yhat,'LineWidth',3)

% compute training errors for the models
training_errors = compute_errors(theta,X,Y);

% plot the training error versus the order of the polynomial
figure
plot(orders,training_errors,'LineWidth',2)
grid

% split into training and test sets

p = 0.8;    % percentage of training data
num_training = round( numel(X) * p );
num_testing = numel(X) - num_training;

num_reps = 100;
orders = 1:10;

training_errors = nan(num_reps,numel(orders));
testing_errors = nan(num_reps,numel(orders));
theta = cell(num_reps,1);

for i=1:num_reps
    
    train_indices = randperm(numel(X),num_training);
    X_train = X(train_indices);
    Y_train = Y(train_indices);
    
    test_indices = setdiff(1:numel(X),train_indices);
    X_test = X(test_indices);
    Y_test = Y(test_indices);
    
    theta{i} = run_linear_regression(X_train,Y_train,orders,false);
    
    % compute training eand testing errors for the models
    training_errors(i,:) = compute_errors(theta{i},X_train,Y_train);
    testing_errors(i,:) = compute_errors(theta{i},X_test,Y_test);
    
    % normalize the errors
    training_errors(i,:) = normalize_errors(training_errors(i,:));
    testing_errors(i,:)  = normalize_errors(testing_errors(i,:));
    
end

% plot
figure
plot(orders,[mean(training_errors);mean(testing_errors)],'LineWidth',2)
grid
legend('training errors','testing errors')


figure ('Position',[488 123 560 638])
subplot(211)
boxplot(training_errors)
hold on
plot(orders,mean(training_errors),'LineWidth',2)
grid
subplot(212)
boxplot(testing_errors)
hold on
plot(orders,mean(testing_errors),'LineWidth',2,'Color',[0.85,0.33,0.10])
grid

% extract the parameters for the parabolas
z = cellfun(@(x) x{2} , theta,'UniformOutput' , false);
theta_2 = [z{:}];

figure
subplot(131)
boxplot(theta_2(1,:))
subplot(132)
boxplot(theta_2(2,:))
subplot(133)
boxplot(theta_2(3,:))

best_theta = mean(theta_2,2);
x = linspace(min(X),max(X))';
yhat = best_theta(1) + best_theta(2)*x + best_theta(3)*x.^2;

figure
plot(X,Y,'.','MarkerSize',8,'DisplayName','data')
hold on
plot(x,yhat,'LineWidth',2,'DisplayName','best approximation')
legend
grid
xlabel('Weight')
ylabel('MPG')