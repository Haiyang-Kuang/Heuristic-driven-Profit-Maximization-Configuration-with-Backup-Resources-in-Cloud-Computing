clear;clc
load data.mat
a=DBO_curve(5,:);
b=-record(5,:);
a1=ones(1,200)*min(a);
b1=ones(1,200)*min(b);
a=[a,a1];
b=[b,b1];
c=1:1:250;
figure(1)
subplot(1,2,1)
plot(a,'Color',[0.47,0.67,0.19],'LineWidth',1)
grid on
box on
xlim([0 200])
% ylim([-66.7,-66.1])
xlabel({'the number of iteration';'(a)'})
ylabel('the best score obtained so far')
legend('theoretical solution')
subplot(1,2,2)
plot(b,'Color',[1.00,0.41,0.16],'LineWidth',1)
grid on
box on
xlim([0 200])
% ylim([-66.7,-66.1])
xlabel({'the number of iteration';'(b)'})
ylabel('the best score obtained so far')
legend('actual solution')
figure(2)
hold on
plot(c,a,'Color','r','LineWidth',1)
plot(c,b,'Color','b','LineWidth',1)
xlabel('the number of iteration')
ylabel('adaptation value')
grid on
box on
legend('theoretical solution','actual solution')