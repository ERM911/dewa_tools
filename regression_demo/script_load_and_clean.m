clear
close all

% load the data
load carbig
whos

% put the data into a Matlab table
Data = table(Acceleration,Cylinders,Displacement,Horsepower,MPG,Model_Year,Weight,Origin);

% these are no longer needed
clear Acceleration Cylinders Displacement Horsepower MPG Mfg Model Model_Year Origin Weight cyl4 org when

% simplify variable names
Data.Properties.VariableNames{'Acceleration'} = 'acc';
Data.Properties.VariableNames{'Cylinders'} = 'cyl';
Data.Properties.VariableNames{'Displacement'} = 'disp';
Data.Properties.VariableNames{'Horsepower'} = 'hp';
Data.Properties.VariableNames{'Model_Year'} = 'year';
Data.Properties.VariableNames{'Weight'} = 'wt';
Data.Properties.VariableNames{'Origin'} = 'org';

% some useful information
Data(1:10,:)
summary(Data)
size(Data)

% notice that there is missing data
sum(ismissing(Data))

% clean the data
Data = rmmissing(Data);

% you can sort the data
sD = sortrows(Data,{'org','year'},'ascend');
disp(sD(1:10,{'org','year'}))

% save the data to a mat file
save('datafile','Data')
