clear
close all

% read the data from a csv file
data = readtable('C:\Users\gomes\Downloads\abalone.txt');

% predict column 1 from the rest
X = table2array(data(:,2:end));
Y = categorical(data.(1));

% % correlation plots
% figure
% plotmatrix(X)

% normalize X
for i=1:size(X,2)
    Xa = X(:,i);
    X(:,i) = (Xa-mean(Xa))./std(Xa);
end

% notice that this does not alter the correlation plots
% plotmatrix(X)

% test set
test_percentage = 0.1;

% size of test and training sets
num_data_points = numel(Y);
num_test = round(test_percentage*num_data_points);
num_train = num_data_points - num_test;

% separate data into training and test sets
data_ind = randperm(num_data_points);
test_ind = data_ind(1:num_test);
train_ind = data_ind(num_test+1:end);

X_test = X(test_ind,:);
Y_test = Y(test_ind,:);

X_train = X(train_ind,:);
Y_train = Y(train_ind,:);

% display some information

disp('Training data')
tabulate(Y_train)

disp('Test data')
tabulate(Y_test)

% fit linear discriminant model
da = fitcdiscr(X_train,Y_train);

% use the model on the test data
[Y_da, Y_score] = predict(da,X_test);
Y_score = Y_score(:,2);

% compute the confusion matrix
C_da = get_confusion_matrix(Y_test,Y_da);

% fit k-nearest neighbors
knn = fitcknn(X_train,Y_train);
Y_knn = predict(knn,X_test);
C_knn = get_confusion_matrix(Y_test,Y_knn);

% binary classifiers

% fit svm


% svm = fitcsvm(X_train,Y_train);


svm = fitcecoc(X_train,Y_train);
Y_svm = predict(svm,X_test);
C_svm = get_confusion_matrix(Y_test,Y_svm);



