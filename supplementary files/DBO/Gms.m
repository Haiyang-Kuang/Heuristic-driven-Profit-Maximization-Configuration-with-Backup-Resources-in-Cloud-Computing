function FWD=Gms(m,mu,lambda)
q=0.00001;delta=2;D=2.5;
ar=15;tao=0.1;belta_1=1.5; kexi=9.4192;Px=2;belta_2=3;
alpha=(q/(1-q)).*lambda;
rho1=alpha/delta;
P_lost=rho1/(1+rho1);
alpha_e=(1-P_lost)*alpha;
alpha_l=P_lost*alpha;
rho=alpha_e/delta;
gamma=lambda.*(1-rho)./(m.*mu)+lambda.*rho./((m-1).*mu);
        if gamma<1
            a=m.*mu;
            b=(m-1).*mu+delta;
            Pm=(1-gamma)./((2.*pi.*m).^0.5.*(1-gamma).*(exp(gamma)./(exp(1).*gamma)).^m+1);
            A1=(b-a.*(1-gamma)).*(delta.*(1-rho)-a.*(1-gamma));
            A2=(a.*(1-gamma)-b).*(delta.*(1-rho)-b);
            A3=(a.*(1-gamma)-delta.*(1-rho)).*(b-delta.*(1-rho));
            FWD=(lambda.*(1-Pm.*(1./(1-gamma)-(1-rho.^2)./(1-gamma).*(1-exp(-(1-gamma).*a.*D))-(1-rho).*rho.^2.*a.*b./(b-(1-gamma).*a)...
                .*((1-exp(-a.*(1-gamma).*D))./(a.*(1-gamma))-(1-exp(-b.*D))./b)-(1-rho).*rho.^3.*a.*b.*delta.*((1-exp(-a.*(1-gamma).*D))...
                ./(A1.*a.*(1-gamma))+(1-exp(-b.*D))./(A2.*b)+(1-exp(-delta.*(1-rho).*D))./(A3.*delta.*(1-rho))))).*ar...
                -m.*(belta_1+tao.*((lambda.*(1-rho)./m+lambda.*rho./m).*kexi.*mu+Px)))-alpha_l/delta*(belta_2+tao*Px);
        else
            FWD=-inf;
        end
end
