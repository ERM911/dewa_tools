clear
close all

load datafile

% you can sort the data, although it is not usually necessary
sData = sortrows(Data,{'MPG','hp'});
disp(sData(1:10,:))
clear sData

% scatter plot of Weight versus Horsepower
figure
plot(Data.hp,Data.wt,'.','MarkerSize',14)
grid
xlabel('Horsepower')
ylabel('Weight')

% Need a matrix of numbers (remove 'org' column)
aData = table2array(Data(:,1:7));

% number of samples and variables
num_samp = size(aData,1);
num_var = size(aData,2);

% matrix scatter plot
figure
[~,ax,~,~,~] = plotmatrix(aData);
for i=1:num_var
    for j=1:num_var
        set(AX(i,j).Children,'MarkerSize',8)
    end
end

for i=1:num_var
    var_name = Data.Properties.VariableNames{i};
    xlabel(ax(num_var,i),var_name,'FontWeight','bold')
    ylabel(ax(i,1),var_name,'FontWeight','bold')
end

% covariance matrix
S = cov(aData);
disp(S)

% correlation matrix
Rho = corrcoef(aData);
disp(Rho)
