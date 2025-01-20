clear;clc;

load('PSO20.mat')
load('HMGWO20.mat')
load('DBO20.mat')
load('En_PSO.mat')
x1 = X2;
x2 = X4;
x3 = X3;
x4 = X1;
C7=[255,163,25;135,146,73;30,93,134;155,103,225]./255;
colorList=C7;

group1 = [repmat('PSO ', size(x1,1), 1); repmat('GWO ', size(x2,1), 1); repmat('DBO ', size(x3,1), 1); repmat('DMSO', size(x4,1), 1)];
group2 = [repmat('GWO ', size(x2,1), 1); repmat('DBO ', size(x3,1), 1); repmat('DMSO', size(x4,1), 1)];
group3 = [repmat('DBO ', size(x3,1), 1); repmat('DMSO', size(x4,1), 1)];
figure(1)
set(gcf,'position', [0 0 1000 600]);
subplot(2,3,[1 2])
set(gca,'position', [0.08 0.56 0.625 0.44]);
boxplot([x1' x2' x3' x4'],group1)
ylabel('Optimal Solution')

lineObj=findobj(gca,'Type','Line');
for i=1:length(lineObj)
    lineObj(i).LineWidth=1;
    lineObj(i).MarkerFaceColor=[1,1,1].*.3;
    lineObj(i).MarkerEdgeColor=[1,1,1].*.3;
end

boxObj=findobj(gca,'Tag','Box');
for i=1:length(boxObj)
    patch(boxObj(i).XData,boxObj(i).YData,colorList(length(boxObj)+1-i,:),'FaceAlpha',0.5,...
        'LineWidth',2);
end

subplot(2,2,3)
set(gca,'position', [0.07 0.05 0.445 0.44]);
boxplot([x2' x3' x4'],group2)
ylabel('Optimal Solution')

lineObj=findobj(gca,'Type','Line');
for i=1:length(lineObj)
    lineObj(i).LineWidth=1;
    lineObj(i).MarkerFaceColor=[1,1,1].*.3;
    lineObj(i).MarkerEdgeColor=[1,1,1].*.3;
end

boxObj=findobj(gca,'Tag','Box');
for i=1:length(boxObj)
    patch(boxObj(i).XData,boxObj(i).YData,colorList(length(boxObj)+1-i,:),'FaceAlpha',0.5,...
        'LineWidth',2);
end


subplot(2,2,4)
boxplot([x3' x4'],group3)
set(gca,'position', [0.68 0.05 0.317 0.44]);

lineObj=findobj(gca,'Type','Line');
for i=1:length(lineObj)
    lineObj(i).LineWidth=1;
    lineObj(i).MarkerFaceColor=[1,1,1].*.3;
    lineObj(i).MarkerEdgeColor=[1,1,1].*.3;
end

boxObj=findobj(gca,'Tag','Box');
for i=1:length(boxObj)
    patch(boxObj(i).XData,boxObj(i).YData,colorList(length(boxObj)+1-i,:),'FaceAlpha',0.5,...
        'LineWidth',2);
end