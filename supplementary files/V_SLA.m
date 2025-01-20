%% SLA_violation rate
clear;clc;close all;
lambda=30.0001;r=1;
m=31;
mu=1;
D_min=0:0.01:10;
rho=lambda.*r./(m.*mu);
% Im=(1-rho)./(sqrt(2.*pi.*m).*(1-rho).*(exp(rho)./(exp(1).*rho)).^m+1);
for k=0:m-1
    ik(k+1)=(m.*rho).^k./factorial(k);
end
Ik=sum(ik);
Im=(m.*rho).^m./factorial(m).*(Ik+(m.*rho).^m./factorial(m)./(1-rho))^(-1);
V_sla=Im./(1-rho).*exp(-(1-rho).*m.*mu.*D_min);
D_min=0.5;
mk=1;
for m=31:1:40
rho=lambda.*r./(m.*mu);
% Im=(1-rho)./(sqrt(2.*pi.*m).*(1-rho).*(exp(rho)./(exp(1).*rho)).^m+1);
for k=0:m-1
    ik(k+1)=(m.*rho).^k./factorial(k);
end
Ik=sum(ik);
Im=(m.*rho).^m./factorial(m).*(Ik+(m.*rho).^m./factorial(m)./(1-rho))^(-1);
V_sla2(mk)=Im./(1-rho).*exp(-(1-rho).*m.*mu.*D_min);
mk=mk+1;
end
m=31:1:40;D_min=0:0.01:10;
%%

N = 1; 
M = 2; 
subplot_length = 4;
subplot_width = 5;
top_margin = 0.3; 
bottom_margin = 0.9; 
left_margin = 0.8; 
right_margin = 0.2; 
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
figure('Units', 'inches','Position', [2, 5, figure_width, figure_length]);

kkk=1;
subplot('Position', subplot_position(kkk, :));
hold on
box on
plot(m,V_sla2,'.-k','LineWidth',1,'MarkerSize',20)
h1=xlabel({'$m$';'(a)'});
h2= ylabel('$\cal{V}_{\rm{SLA}}$');
set([h1,h2],'interpreter','latex','fontsize',16)
h=legend('$\cal{D}_{\rm{min}}$=0.5');
set(h,'interpreter','latex','fontsize',16)

kkk=2;
subplot('Position', subplot_position(kkk, :));
hold on
box on
plot(D_min,V_sla,'-k','LineWidth',1,'MarkerSize',20)
h1=xlabel({'$\cal{D}_{\rm{min}}$';'(b)'});
h2= ylabel('$\cal{V}_{\rm{SLA}}$');
set([h1,h2],'interpreter','latex','fontsize',16)
h=legend('$m$=31');
set(h,'interpreter','latex','fontsize',16)

%% SLA_violation rate
clear;clc;close all;
load lambda_data.mat
r=1;
lambda=20.1:5:60.1;
lambda=lambda';
m=bestX(:,1);
mu=bestX(:,2);
D_min=2;
rho=lambda.*r./(m.*mu);
Im=(1-rho)./(sqrt(2.*pi.*m).*(1-rho).*(exp(rho)./(exp(1).*rho)).^m+1);
V_sla=Im./(1-rho).*exp(-(1-rho).*m.*mu.*D_min);