

function [lb,ub,dim,fobj] = Get_Functions_details(F)


switch F
    case 'F1'
        fobj = @F1;
        lb=0.5;
        ub=2;
        dim=1;
        
    case 'F2'
        fobj = @F2;
        lb=[10,0.5];
        ub=[70,4.0];
        dim=2;
        
    case 'F3'
        fobj = @F3;
        lb=[10,0.5];
        ub=[70,4.0];
        dim=2;
        
   case 'F4'
        fobj = @F4;
        lb=[10,0.5,0];
        ub=[70,4.0,10];
        dim=3;
        
end

end

% F1

function o = F1(x)

end

% F2

function o = F2(x,lambda)
m=x(1);mu=x(2);
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
o=-G1;
end

% F3

function o = F3(x,lambda)
m=x(1);s=x(2);
mu=s;r=1;T_min=0.5;T_max=5;p=15;
R_0=10^(-5);d=2;s_max=4;s_min=0.5;
theta=1.5;xi=0.1;sig=9.4192;phi=2;Pt=2;
rho=lambda.*r./(m.*mu);
if rho<1
DMR1=m.*lambda.^m.*(exp(-(m.*s./r-lambda).*T_min)-exp(-(m.*s./r-lambda).*T_max));
DMR2=(s./r).^(m-1).*(m.*s./r-lambda).^2.*(T_max-T_min).*((sqrt(2.*pi.*m).*(m./exp(1)).^m).*(exp(m.*rho))+((m.*rho).^m./(1-rho)));
DMR=DMR1./DMR2;
R=R_0.*exp((d.*(s_max-s)./(s_max-s_min)));
R_exp=m.*s.*(2./(m.*s+R.*r)-1./(m.*s+2.*R.*r));
E=lambda.*p.*r.*(1-DMR).*R_exp;
C=m.*(theta+xi.*(rho.*sig.*s.^phi+Pt));
o=-(E-C);
else
    o=0;
end
end

% F4

function o = F4(x,lambda)
load('net.mat')
m=x(1);
mu=x(2);
n=x(3);
r=1;
D_min=2;
D_max=5;
var=15;
w=0.5;
mu_max=4;
mu_min=0.5;
delta=0.01;
alpha_0=1.*10^(-5);
eta=2;
beta_1=1.5;
beta_2=15;
siga=0.1;
Pst=2;
theta=2.5;
zeta=9.4192;
rho=lambda.*r./(m.*mu);
if rho<1
    Im=(1-rho)./(sqrt(2.*pi.*m).*(1-rho).*(exp(rho)./(exp(1).*rho)).^m+1);
    A=exp(D_max./w)./(exp(D_max/w)-exp(D_min/w));
    B=1./(exp(D_max/w)-exp(D_min/w));
    E1=1-Im./(1-rho).*exp(-(1-rho).*m.*mu.*D_min);
    E2=A.*Im./(1-rho).*(exp(-(1-rho).*m.*mu.*D_min)-exp(-(1-rho).*m.*mu.*D_max));
    E3=B.*m.*mu.*Im./(-(1-rho).*m.*mu+1/w).*(exp((-(1-rho).*m.*mu+1/w).*D_min)-exp((-(1-rho).*m.*mu+1/w).*D_max));
    E=(E1+E2+E3).*var.*r.*lambda;
    alpha=alpha_0.*10^(eta.*(mu_max-mu)./(mu_max-mu_min));
    gamma=m.*alpha;
    H=net([x(1);x(2);x(3)]);
    barN=gamma.*H;
    C_rent=(m+n).*beta_1+barN.*beta_2./delta;
    C_ele=siga.*((m+n+barN./delta).*Pst+lambda.*r.*zeta.*mu.^(theta-1));
    C=C_rent+C_ele;
else
    E=0;
    C=0;
end
o=-(E-C);
end

% F5

function o = F5(x)
dim=size(x,2);
o=sum(100*(x(2:dim)-(x(1:dim-1).^2)).^2+(x(1:dim-1)-1).^2);
end

% F6

function o = F6(x)
o=sum(abs((x+.5)).^2);
end

% F7

function o = F7(x)
dim=size(x,2);
o=sum([1:dim].*(x.^4))+rand;
end

% F8

function o = F8(x)
o=sum(-x.*sin(sqrt(abs(x))));
end

% F9

function o = F9(x)
dim=size(x,2);
o=sum(x.^2-10*cos(2*pi.*x))+10*dim;
end

% F10

function o = F10(x)
dim=size(x,2);
o=-20*exp(-.2*sqrt(sum(x.^2)/dim))-exp(sum(cos(2*pi.*x))/dim)+20+exp(1);
end

% F11

function o = F11(x)
dim=size(x,2);
o=sum(x.^2)/4000-prod(cos(x./sqrt([1:dim])))+1;
end

% F12

function o = F12(x)
dim=size(x,2);
o=(pi/dim)*(10*((sin(pi*(1+(x(1)+1)/4)))^2)+sum((((x(1:dim-1)+1)./4).^2).*...
    (1+10.*((sin(pi.*(1+(x(2:dim)+1)./4)))).^2))+((x(dim)+1)/4)^2)+sum(Ufun(x,10,100,4));
end

% F13

function o = F13(x)
dim=size(x,2);
o=.1*((sin(3*pi*x(1)))^2+sum((x(1:dim-1)-1).^2.*(1+(sin(3.*pi.*x(2:dim))).^2))+...
    ((x(dim)-1)^2)*(1+(sin(2*pi*x(dim)))^2))+sum(Ufun(x,5,100,4));
end

% F14

function o = F14(x)
aS=[-32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32 -32 -16 0 16 32;,...
    -32 -32 -32 -32 -32 -16 -16 -16 -16 -16 0 0 0 0 0 16 16 16 16 16 32 32 32 32 32];

for j=1:25
    bS(j)=sum((x'-aS(:,j)).^6);
end
o=(1/500+sum(1./([1:25]+bS))).^(-1);
end

% F15

function o = F15(x)
aK=[.1957 .1947 .1735 .16 .0844 .0627 .0456 .0342 .0323 .0235 .0246];
bK=[.25 .5 1 2 4 6 8 10 12 14 16];bK=1./bK;
o=sum((aK-((x(1).*(bK.^2+x(2).*bK))./(bK.^2+x(3).*bK+x(4)))).^2);
end

% F16

function o = F16(x)
o=4*(x(1)^2)-2.1*(x(1)^4)+(x(1)^6)/3+x(1)*x(2)-4*(x(2)^2)+4*(x(2)^4);
end

% F17

function o = F17(x)
o=(x(2)-(x(1)^2)*5.1/(4*(pi^2))+5/pi*x(1)-6)^2+10*(1-1/(8*pi))*cos(x(1))+10;
end

% F18

function o = F18(x)
o=(1+(x(1)+x(2)+1)^2*(19-14*x(1)+3*(x(1)^2)-14*x(2)+6*x(1)*x(2)+3*x(2)^2))*...
    (30+(2*x(1)-3*x(2))^2*(18-32*x(1)+12*(x(1)^2)+48*x(2)-36*x(1)*x(2)+27*(x(2)^2)));
end

% F19

function o = F19(x)
aH=[3 10 30;.1 10 35;3 10 30;.1 10 35];cH=[1 1.2 3 3.2];
pH=[.3689 .117 .2673;.4699 .4387 .747;.1091 .8732 .5547;.03815 .5743 .8828];
o=0;
for i=1:4
    o=o-cH(i)*exp(-(sum(aH(i,:).*((x-pH(i,:)).^2))));
end
end

% F20

function o = F20(x)
aH=[10 3 17 3.5 1.7 8;.05 10 17 .1 8 14;3 3.5 1.7 10 17 8;17 8 .05 10 .1 14];
cH=[1 1.2 3 3.2];
pH=[.1312 .1696 .5569 .0124 .8283 .5886;.2329 .4135 .8307 .3736 .1004 .9991;...
    .2348 .1415 .3522 .2883 .3047 .6650;.4047 .8828 .8732 .5743 .1091 .0381];
o=0;
for i=1:4
    o=o-cH(i)*exp(-(sum(aH(i,:).*((x-pH(i,:)).^2))));
end
end

% F21

function o = F21(x)
aSH=[4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3;8 1 8 1;6 2 6 2;7 3.6 7 3.6];
cSH=[.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];

o=0;
for i=1:5
    o=o-((x-aSH(i,:))*(x-aSH(i,:))'+cSH(i))^(-1);
end
end

% F22

function o = F22(x)
aSH=[4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3;8 1 8 1;6 2 6 2;7 3.6 7 3.6];
cSH=[.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];

o=0;
for i=1:7
    o=o-((x-aSH(i,:))*(x-aSH(i,:))'+cSH(i))^(-1);
end
end

% F23

function o = F23(x)
aSH=[4 4 4 4;1 1 1 1;8 8 8 8;6 6 6 6;3 7 3 7;2 9 2 9;5 5 3 3;8 1 8 1;6 2 6 2;7 3.6 7 3.6];
cSH=[.1 .2 .2 .4 .4 .6 .3 .7 .5 .5];

o=0;
for i=1:10
    o=o-((x-aSH(i,:))*(x-aSH(i,:))'+cSH(i))^(-1);
end
end

function o=Ufun(x,a,k,m)
o=k.*((x-a).^m).*(x>a)+k.*((-x-a).^m).*(x<(-a));
end