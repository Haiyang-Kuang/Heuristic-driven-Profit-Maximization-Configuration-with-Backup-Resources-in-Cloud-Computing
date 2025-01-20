clc;clear;close all;
load('lambda_data.mat')
load('net.mat')
load('NN.mat')

j=1;i=1;
for lambda=20.1:5:60.1
M=[ceil(bestX(i,1));floor(bestX(i,1))];
S=[ceil(10.*bestX(i,2))./10;floor(10.*bestX(i,2))./10];
N=[ceil(bestX(i,3));floor(bestX(i,3))];
for im=1:2
    for is=1:2
        for in=1:2
            m=M(im);
            s=S(is);
            n=N(in);
            x(j,:)=[m,s,n];
            F(j)=-f_profit(x(j,:),lambda);
            j=j+1;
        end
    end
end
[z1,z2]=max(F);
Fmax(i)=z1;
Best_x(i,:)=x(z2,:);
i=i+1;
end
lambda=20.1:5:60.1;

% save act_sol.mat Best_x Fmax

figure(1)
box on
grid on
hold on
plot(lambda,-fMin,'.-k','LineWidth',1,'MarkerSize',20)
plot(lambda,Fmax,'.-r','LineWidth',1,'MarkerSize',20)
h1=xlabel({'$\lambda$'});
h2=ylabel('$\cal P$');
set([h1,h2],'interpreter','latex','fontsize',16)
