%% 
clear;clc;close all;
lambda=30.001;r=1;mu_max=4;mu_min=0.5;delta=0.01;alpha_0=10^(-5);eta=2;
m=31;
mu=1;
rho=lambda.*r./(m.*mu);
for n=0:1:10
alpha=alpha_0.*10^(eta.*(mu_max-mu)./(mu_max-mu_min));
gamma=m.*alpha;
for j=0:n
j0(j+1)=1./factorial(j).*(gamma./delta).^j;
end
J0=sum(j0)^(-1);
HH(n+1)=J0.*(gamma./delta).^n./factorial(n);
% Gamma=gamma./(n.*delta);
% if n==0
%     HH(n+1)=1;
% else
% HH(n+1)=exp(n.*(1-Gamma)).*Gamma.^n./sqrt(2.*pi.*n);
% end
% if HH(n+1)>1
%     HH(n+1)=1;
% end
NN(n+1)=gamma.*HH(n+1);
end
n=0:1:10;


N = 1; 
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
figure('Units', 'inches','Position', [2, 5, figure_width, figure_length]);

kkk=1;
subplot('Position', subplot_position(kkk, :));
hold on
box on
plot(n,HH,'.-k','LineWidth',1,'MarkerSize',20)
h1=xlabel({'$n$';'(a)'});
h2=ylabel('$\cal H$');
h3=legend('$m$=31');
set([h1,h2,h3],'interpreter','latex','fontsize',16)

kkk=2;
subplot('Position', subplot_position(kkk, :));
hold on
box on
plot(n,NN,'.-k','LineWidth',1,'MarkerSize',20)
h1=xlabel({'$n$';'(b)'});
h2=ylabel('$\bar N$');
h3=legend('$m$=31');
set([h1,h2,h3],'interpreter','latex','fontsize',16)

%%
clear;clc;close all;
r=1;mu_max=4;mu_min=0.5;delta=0.01;alpha_0=10^(-5);eta=2;
ii=1;
for n=0:1:10
for m=10:1:70
for mu=0.5:0.1:4
alpha=alpha_0.*10^(eta.*(mu_max-mu)./(mu_max-mu_min));
gamma=m.*alpha;
for j=0:1:n
j0(j+1)=1./factorial(j).*(gamma./delta).^j;
end
J0=sum(j0)^(-1);
HH=J0.*(gamma./delta).^n./factorial(n);
record(ii,:)=[m,mu,n,HH];
ii=ii+1;
end
end
end
% save record.mat record