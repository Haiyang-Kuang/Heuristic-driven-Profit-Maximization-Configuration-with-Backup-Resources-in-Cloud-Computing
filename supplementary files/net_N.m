clear;clc;
load('act_sol.mat')
load('net.mat')
r=1;mu_max=4;mu_min=0.5;delta=0.01;alpha_0=10^(-5);eta=2;
for i=1:9
m=Best_x(i,1);
mu=Best_x(i,2);
n=Best_x(i,3);
alpha=alpha_0.*10^(eta.*(mu_max-mu)./(mu_max-mu_min));
gamma=m.*alpha;
HH(i)=net([m;mu;n]);
NN(i)=gamma.*HH(i);
end
plot(NN)
T=1./NN;
%%
% m=bestX(1,1);
% mu=bestX(1,2);
% n=bestX(1,3);
% alpha=alpha_0.*10^(eta.*(mu_max-mu)./(mu_max-mu_min));
% gamma=m.*alpha;
% Gamma=gamma./(n.*delta);
% H=exp(n.*(1-Gamma)).*Gamma.^n./sqrt(2.*pi.*n);
% N=gamma.*H;
% save NN.mat NN
%%
r=1;mu_max=4;mu_min=0.5;delta=0.01;alpha_0=10^(-5);eta=2;
m=bestX_cao(:,1);
mu=bestX_cao(:,2);
alpha=alpha_0.*10.^(eta.*(mu_max-mu)./(mu_max-mu_min));
rho=alpha./delta;
N=m.*rho./(1+rho);
% save Cao_data.mat bestX_cao fMin_cao N