clear;clc;close all;
bm=1;
d1=2;d2=5;
wk=[0.25,0.5,1];
for ik=1:1:3
    ii=1;w=wk(ik);
for i=0:0.01:7
    if i<d1
        f(ik,ii)=bm;
    elseif i>=d1 && i<d2
        f(ik,ii)=(exp(d2/w)-exp(i/w))/(exp(d2/w)-exp(d1/w))*bm;
    else
        f(ik,ii)=0;
    end
    ii=ii+1;
end
end
t=0:0.01:7;
figure(1)
hold on
box on
grid off
plot(t,f(1,:),'k','LineWidth',1)
plot(t,f(2,:),'k','LineWidth',1)
plot(t,f(3,:),'k','LineWidth',1)
plot([2 5],[1 0],'k','LineWidth',1)
plot([2 2],[0 1],'--k')
plot([0 2],[1 1],'k','LineWidth',2)
plot([d2 7],[0 0],'k','LineWidth',2)
text(5.5,0.9,'$\omega=0.25$','interpreter','latex','FontSize', 16);%正确上划线
text(5.5,0.7,'$\omega=0.50$','interpreter','latex','FontSize', 16);
text(5.5,0.5,'$\omega=1.00$','interpreter','latex','FontSize', 16);
text(0.1,1.15,'fixed strategy','FontSize', 16);
text(2,0.3,'linear strategy','FontSize', 16);
text(1.7,-0.08,'$\cal{D}_{\rm{min}}$','interpreter','latex','FontSize', 16);
text(4.7,-0.08,'$\cal{D}_{\rm{max}}$','interpreter','latex','FontSize', 16);
% z1=plot(x1,y1,'LineWidth',2,'Color',[0.60,0.60,0.60]);z2=plot(xx2,yy2,'LineWidth',2,'Color',[0.00,0.45,0.70]);z3=plot(xx3,yy3,'LineWidth',2,'Color',[0.34,0.71,0.91]);
% z4=plot(xx4,yy4,'LineWidth',2,'Color',[0.00,0.62,0.45]);z5=plot(x5,y5,'LineWidth',2,'Color',[0.90,0.62,0.00]);z6=plot(xx6,yy6,'LineWidth',2,'Color',[0.84,0.37,0.00]);
h=xlabel({'$\cal W$'});
set(h,'interpreter','latex','fontsize',16)
ylabel({'PoS'})
ylim([0 1.2])
% set(gca,'xticklabel',[])
% set(gca,'yticklabel',[])
xticks(0:1:7)
% xticklabels({[],[],'\it{D}_{\rm{min}}',[],[],'\it{D}_{\rm{max}}',[],[]})
xticklabels({0,[],[],[],[],[],[],[]})
% set(h,'interpreter','latex','fontsize',14)
yticks(0:0.2:1.2)
yticklabels({[],[],[],[],[],'\vartheta_{{\rm{bm}}}',[]})
% legend('\omega=0.25','\omega=0.5','\omega=1')