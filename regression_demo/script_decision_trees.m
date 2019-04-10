clear
close all

load('datafile','Data')

model = fitctree(Data(:,1:7),Data.org);
view(model)




