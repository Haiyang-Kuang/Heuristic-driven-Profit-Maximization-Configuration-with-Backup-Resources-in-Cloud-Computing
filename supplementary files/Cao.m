clc;clear;
load Cao_data.mat
load('lambda_data.mat')
lambda=[20:5:60]';
m=bestX_cao(:,1)-N;
mu=bestX_cao(:,2);
r=1;D_min=0.5;D_max=5;var=15;
beta_1=1.5;siga=0.1;Pst=2;theta=3;zeta=9.4192;

rho=lambda.*r./(m.*mu);
if rho<1
    Im=(1-rho)./(sqrt(2.*pi.*m).*(1-rho).*(exp(rho)./(exp(1).*rho)).^m+1);
    A=D_max./(D_max-D_min);
    B=1./(D_max-D_min);
    E1=1-Im./(1-rho).*exp(-(1-rho).*m.*mu.*D_min);
    E2=A.*Im./(1-rho).*(exp(-(1-rho).*m.*mu.*D_min)-exp(-(1-rho).*m.*mu.*D_max));
    E3=Im.*B./(1-rho).*(D_max.*exp(-(1-rho).*m.*mu.*D_max)-D_min.*exp(-(1-rho).*m.*mu.*D_min))+...
     Im.*B./((1-rho).^2.*m.*mu).* (exp(-(1-rho).*m.*mu.*D_max)-exp(-(1-rho).*m.*mu.*D_min));
    %     E3=B.*m.*mu.*Im./(-(1-rho).*m.*mu+1/w).*(exp(-((1-rho).*m.*mu+1/w).*D_min)-exp(-((1-rho).*m.*mu+1/w).*D_max));
    E=(E1+E2+E3).*var.*r.*lambda;
    C_rent=(m).*beta_1;
    C_ele=siga.*((m).*Pst+lambda.*r.*zeta.*mu.^(theta-1));
    C=C_rent+C_ele;
else
    E=NaN;
    C=NaN;
end
G1=E-C;

%%
r=1;D_min=1;
lambda=[20.1:5:60.1;20.1:5:60.1];
lambda=lambda';
m=[bestX_cao(:,1),bestX(:,1)];
mu=[bestX_cao(:,2),bestX(:,2)];
rho=lambda.*r./(m.*mu);
Im=(1-rho)./(sqrt(2.*pi.*m).*(1-rho).*(exp(rho)./(exp(1).*rho)).^m+1);
V_sla=Im./(1-rho).*exp(-(1-rho).*m.*mu.*D_min);


    
