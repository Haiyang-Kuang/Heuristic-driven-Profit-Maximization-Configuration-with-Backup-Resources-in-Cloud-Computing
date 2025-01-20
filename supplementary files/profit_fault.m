clear;clc;close all;
%% s
r=1;
D_min=0.5;
D_max=5;
var=15;
w=0.5;
mu_max=4;
mu_min=0.5;
delta=0.01;
alpha_0=10^(-5);
eta=2;
beta_1=1.5;
beta_2=6;
siga=0.1;
Pst=2;
theta=2;
zeta=9.4192;
% n=0:0.01:3;
n=2;
m=20;
zl=1;
for lambda=10.01:10:50.01
    zz=1;
for mu=mu_min:0.01:mu_max
rho=lambda.*r./(m.*mu);
if rho<1
Im=(1-rho)./(sqrt(2.*pi.*m).*(1-rho).*(exp(rho)./(exp(1).*rho)).^m+1);
% for k=0:m-1
%     ik(k+1)=(m.*rho).^k./factorial(k);
% end
% Ik=sum(ik);
% Im=(m.*rho).^m./factorial(m).*(Ik+(m.*rho).^m./factorial(m)./(1-rho))^(-1);
A=exp(D_max./w)./(exp(D_max/w)-exp(D_min/w));
B=1./(exp(D_max/w)-exp(D_min/w));
E1=1-Im./(1-rho).*exp(-(1-rho).*m.*mu.*D_min);
E2=A.*Im./(1-rho).*(exp(-(1-rho).*m.*mu.*D_min)-exp(-(1-rho).*m.*mu.*D_max));
E3=B.*m.*mu.*Im./(-(1-rho).*m.*mu+1/w).*(exp(-((1-rho).*m.*mu+1/w).*D_min)-exp(-((1-rho).*m.*mu+1/w).*D_max));
E(zz)=(E1+E2+E3).*var.*r.*lambda;
alpha=alpha_0.*10^(eta.*(mu_max-mu)./(mu_max-mu_min));
gamma=m.*alpha;
for j=0:n
j0(j+1)=1./factorial(j).*(gamma./delta).^j;
end
J0=sum(j0)^(-1);
H=J0.*(gamma./delta).^n./factorial(n);
% Gamma=gamma./(n.*delta);
% H=exp(n.*(1-Gamma)).*Gamma.^n./sqrt(2.*pi.*n);
barN=gamma.*H;
C_rent=(m+n).*beta_1+barN.*beta_2./delta;
C_ele=siga.*((m+n+barN./delta).*Pst+lambda.*r.*zeta.*mu.^(theta-1));
C(zz)=C_rent+C_ele;
else
E(zz)=NaN;
C(zz)=NaN;
end
zz=zz+1;
end
G1(zl,:)=E-C;
zl=zl+1;
end
% figure(1)
% hold on
% box on
% grid on
% plot(mu(1:200),G1(1,1:200),'-k','LineWidth',1)
% plot(mu(1:250),G1(2,1:250),'-k','LineWidth',1)
% plot(mu(1:300),G1(3,1:300),'-k','LineWidth',1)
% plot(mu,G1(4,:),'-k','LineWidth',1)
% plot(mu,G1(5,:),'-k','LineWidth',1)

%% m
mu=1;
zl=1;
for lambda=10.01:10:50.01
    zz=1;
for m=10:0.1:70
rho=lambda.*r./(m.*mu);
if rho<1
Im=(1-rho)./(sqrt(2.*pi.*m).*(1-rho).*(exp(rho)./(exp(1).*rho)).^m+1);
% for k=0:m-1
%     ik(k+1)=(m.*rho).^k./factorial(k);
% end
% Ik=sum(ik);
% Im=(m.*rho).^m./factorial(m).*(Ik+(m.*rho).^m./factorial(m)./(1-rho))^(-1);
A=exp(D_max./w)./(exp(D_max/w)-exp(D_min/w));
B=1./(exp(D_max/w)-exp(D_min/w));
E1=1-Im./(1-rho).*exp(-(1-rho).*m.*mu.*D_min);
E2=A.*Im./(1-rho).*(exp(-(1-rho).*m.*mu.*D_min)-exp(-(1-rho).*m.*mu.*D_max));
E3=B.*m.*mu.*Im./(-(1-rho).*m.*mu+1/w).*(exp(-((1-rho).*m.*mu+1/w).*D_min)-exp(-((1-rho).*m.*mu+1/w).*D_max));
E(zz)=(E1+E2+E3).*var.*r.*lambda;
alpha=alpha_0.*10^(eta.*(mu_max-mu)./(mu_max-mu_min));
gamma=m.*alpha;
for j=0:n
j0(j+1)=1./factorial(j).*(gamma./delta).^j;
end
J0=sum(j0)^(-1);
H=J0.*(gamma./delta).^n./factorial(n);
% Gamma=gamma./(n.*delta);
% H=exp(n.*(1-Gamma)).*Gamma.^n./sqrt(2.*pi.*n);
barN=gamma.*H;
C_rent=(m+n).*beta_1+barN.*beta_2./delta;
C_ele=siga.*((m+n+barN./delta).*Pst+lambda.*r.*zeta.*mu.^(theta-1));
C(zz)=C_rent+C_ele;
else
E(zz)=NaN;
C(zz)=NaN;
end
zz=zz+1;
end
G2(zl,:)=E-C;
zl=zl+1;
end
% m=10:0.1:70;
% figure(2)
% hold on
% box on
% grid on
% plot(m,G2(1,:),'-k','LineWidth',1)
% plot(m,G2(2,:),'-k','LineWidth',1)
% plot(m,G2(3,:),'-k','LineWidth',1)
% plot(m,G2(4,:),'-k','LineWidth',1)
% plot(m,G2(5,:),'-k','LineWidth',1)
%%
r=1;D_min=0.5;D_max=5;var=15;w=0.5;mu_max=4;mu_min=0.5;
delta=0.01;alpha_0=10^(-5);eta=2;beta_1=1.5;beta_2=6;siga=0.1;Pst=2;theta=2;zeta=9.4192;
% n=0:0.01:3;
n=2;lambda=30.01;
m=linspace(10,70,301);
mu=linspace(0.5,4,176);
[X,Y]=meshgrid(m,mu);
zl=1;
for m=10:0.2:70
zz=1;
for mu=0.5:0.02:4
rho=lambda.*r./(m.*mu);
if rho<0.99
Im=(1-rho)./(sqrt(2.*pi.*m).*(1-rho).*(exp(rho)./(exp(1).*rho)).^m+1);
% for k=0:m-1
%     ik(k+1)=(m.*rho).^k./factorial(k);
% end
% Ik=sum(ik);
% Im=(m.*rho).^m./factorial(m).*(Ik+(m.*rho).^m./factorial(m)./(1-rho))^(-1);
A=exp(D_max./w)./(exp(D_max/w)-exp(D_min/w));
B=1./(exp(D_max/w)-exp(D_min/w));
E1=1-Im./(1-rho).*exp(-(1-rho).*m.*mu.*D_min);
E2=A.*Im./(1-rho).*(exp(-(1-rho).*m.*mu.*D_min)-exp(-(1-rho).*m.*mu.*D_max));
E3=B.*m.*mu.*Im./(-(1-rho).*m.*mu+1/w).*(exp(-((1-rho).*m.*mu+1/w).*D_min)-exp(-((1-rho).*m.*mu+1/w).*D_max));
E=(E1+E2+E3).*var.*r.*lambda;
alpha=alpha_0.*10^(eta.*(mu_max-mu)./(mu_max-mu_min));
gamma=m.*alpha;
for j=0:n
j0(j+1)=1./factorial(j).*(gamma./delta).^j;
end
J0=sum(j0)^(-1);
H=J0.*(gamma./delta).^n./factorial(n);
% Gamma=gamma./(n.*delta);
% H=exp(n.*(1-Gamma)).*Gamma.^n./sqrt(2.*pi.*n);
barN=gamma.*H;
C_rent=(m+n).*beta_1+barN.*beta_2./delta;
C_ele=siga.*((m+n+barN./delta).*Pst+lambda.*r.*zeta.*mu.^(theta-1));
C=C_rent+C_ele;
G3(zl,zz)=E-C;
else
G3(zl,zz)=NaN;
end
zz=zz+1;
end
zl=zl+1;
end
% figure(3)
% hold on
% box on
% grid on
% mesh(X,Y,G3')
% zlim([300 370])
%%
r=1;D_min=0.5;D_max=5;var=15;w=0.5;mu_max=4;mu_min=0.5;
delta=0.01;alpha_0=10^(-5);eta=2;beta_1=1.5;beta_2=6;siga=0.1;Pst=2;theta=2;zeta=9.4192;
% n=0:0.01:3;
n=2;lambda=30.01;
m=linspace(10,70,61);
mu=linspace(0.5,4,36);
[XX,YY]=meshgrid(m,mu);
zl=1;
for m=10:1:70
zz=1;
for mu=0.5:0.1:4
rho=lambda.*r./(m.*mu);
if rho<1
Im=(1-rho)./(sqrt(2.*pi.*m).*(1-rho).*(exp(rho)./(exp(1).*rho)).^m+1);
% for k=0:m-1
%     ik(k+1)=(m.*rho).^k./factorial(k);
% end
% Ik=sum(ik);
% Im=(m.*rho).^m./factorial(m).*(Ik+(m.*rho).^m./factorial(m)./(1-rho))^(-1);
A=exp(D_max./w)./(exp(D_max/w)-exp(D_min/w));
B=1./(exp(D_max/w)-exp(D_min/w));
E1=1-Im./(1-rho).*exp(-(1-rho).*m.*mu.*D_min);
E2=A.*Im./(1-rho).*(exp(-(1-rho).*m.*mu.*D_min)-exp(-(1-rho).*m.*mu.*D_max));
E3=B.*m.*mu.*Im./(-(1-rho).*m.*mu+1/w).*(exp(-((1-rho).*m.*mu+1/w).*D_min)-exp(-((1-rho).*m.*mu+1/w).*D_max));
E=(E1+E2+E3).*var.*r.*lambda;
alpha=alpha_0.*10^(eta.*(mu_max-mu)./(mu_max-mu_min));
gamma=m.*alpha;
for j=0:n
j0(j+1)=1./factorial(j).*(gamma./delta).^j;
end
J0=sum(j0)^(-1);
H=J0.*(gamma./delta).^n./factorial(n);
% Gamma=gamma./(n.*delta);
% H=exp(n.*(1-Gamma)).*Gamma.^n./sqrt(2.*pi.*n);
barN=gamma.*H;
C_rent=(m+n).*beta_1+barN.*beta_2./delta;
C_ele=siga.*((m+n+barN./delta).*Pst+lambda.*r.*zeta.*mu.^(theta-1));
C=C_rent+C_ele;
G4(zl,zz)=E-C;
else
G4(zl,zz)=NaN;
end
zz=zz+1;
end
zl=zl+1;
end
% figure(4)
% hold on
% box on
% grid on
% plot3(XX,YY,G4','.k','MarkerSize',10)
% zlim([300 370])
%% 
N = 2; 
M = 2; 
subplot_length = 4;
subplot_width = 5;
top_margin = 0.3; 
bottom_margin = 0.8; 
left_margin = 0.8; 
right_margin = 0.15; 
gap = 1; 
figure_width = M * subplot_width + (M -1) * gap+left_margin+right_margin;
figure_length = N * subplot_length + (N -1) * gap + top_margin + bottom_margin;
subplot_position = zeros(N * M, 4); 
for i = 1:N
    for j = 1:M
        x_left =( (j - 1) * (subplot_width+gap) + left_margin )/ figure_width;
        y_bottom = 1-(i*subplot_length+top_margin+(i-1)*gap)/ figure_length ;
        subplot_position((i - 1) * M + j, :) = [x_left, y_bottom, subplot_width / figure_width, subplot_length / figure_length];
    end
end

close all
figure('Units', 'inches','Position', [1, -1, figure_width, figure_length]);

kkk=1;
m=10:0.1:70;
subplot('Position', subplot_position(kkk, :));
hold on
box on
plot(m,G2(1,:),'-k','LineWidth',1)
plot(m,G2(2,:),'-k','LineWidth',1)
plot(m,G2(3,:),'-k','LineWidth',1)
plot(m,G2(4,:),'-k','LineWidth',1)
plot(m,G2(5,:),'-k','LineWidth',1)
text(46,75,'$\lambda=10$','interpreter','latex','FontSize', 16);
text(51,200,'$\lambda=20$','interpreter','latex','FontSize', 16);
text(54,340,'$\lambda=30$','interpreter','latex','FontSize', 16);
text(58,470,'$\lambda=40$','interpreter','latex','FontSize', 16);
text(62,600,'$\lambda=50$','interpreter','latex','FontSize', 16);
h1=xlabel({'$m$';'(a)'});
h2=ylabel('$\cal P$');
set([h1,h2],'interpreter','latex','fontsize',16)

kkk=2;
mu=mu_min:0.01:mu_max;
subplot('Position', subplot_position(kkk, :));
hold on
box on
plot(mu,G1(1,:),'-k','LineWidth',1)
plot(mu,G1(2,:),'-k','LineWidth',1)
plot(mu,G1(3,:),'-k','LineWidth',1)
plot(mu,G1(4,:),'-k','LineWidth',1)
plot(mu,G1(5,:),'-k','LineWidth',1)
text(2.5,100,'$\lambda=10$','interpreter','latex','FontSize', 16);
text(2.75,225,'$\lambda=20$','interpreter','latex','FontSize', 16);
text(3,340,'$\lambda=30$','interpreter','latex','FontSize', 16);
text(3.25,455,'$\lambda=40$','interpreter','latex','FontSize', 16);
text(3.5,560,'$\lambda=50$','interpreter','latex','FontSize', 16);
h1=xlabel({'$s$','(b)'});
h2=ylabel('$\cal P$');
set([h1,h2],'interpreter','latex','fontsize',16)

kkk=3;
m=10:0.1:70;
subplot('Position', subplot_position(kkk, :));
hold on
box on
grid on
mesh(X,Y,G3')
zlim([300 370])
h1=xlabel('$m$');
h2=ylabel('$s$');
h3=zlabel('$\cal P$');
h4=legend('$\lambda=30$');
title('(c)','position',[-68,12])
set([h1,h2,h3,h4],'interpreter','latex','fontsize',16)

kkk=4;
subplot('Position', subplot_position(kkk, :));
hold on
box on
plot3(XX,YY,G4','.k','MarkerSize',10)
zlim([300 370])
h1=xlabel('$m$');
h2=ylabel('$s$');
h3=zlabel('$\cal P$');
h4=legend('$\lambda=30$');
title('(d)','position',[-68,12.6])
set([h1,h2,h3,h4],'interpreter','latex','fontsize',16)