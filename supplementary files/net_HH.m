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
% save(sprintf('record_%d.mat', lambda), 'record'); % 保存数据

%%

load('record.mat')
inputs = record(:, 1:3)'; 
targets =  record(:, 4)';


hiddenLayerSize = 10;
net = feedforwardnet(hiddenLayerSize);


net = train(net, inputs, targets);


predictions = net(inputs);

save net.mat net