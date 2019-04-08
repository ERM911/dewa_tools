clear
close all

load design_scores

figure('Position',[214.6000  281.8000  977.6000  341.6000])
h1=histogram(scoreA,5,'FaceColor',[1 0 1]);
hold on
histogram(scoreB,5,'FaceColor',[0 1 1]);
set(gca,'YLim',[0 10])

% estimate the mean of each distribution
meanA = mean(scoreA);
meanB = mean(scoreB);

% put it on the plot
line([meanA meanA],[0 10],'LineWidth',2,'LineStyle','--','Color','r')
line([meanB meanB],[0 10],'LineWidth',2,'LineStyle','--','Color','b')
legend('design A','design B','avg A','avg B')
grid

% histogram of score differences
figure('Position',[214  281  977  341])
histogram(scoreA-scoreB,5);
set(gca,'YLim',[0 10])
m = mean(scoreA-scoreB);
line([m m],[0 10],'LineWidth',2,'LineStyle','--')

% t-test
[H,P,CI,STATS] = ttest(scoreB-scoreA)
