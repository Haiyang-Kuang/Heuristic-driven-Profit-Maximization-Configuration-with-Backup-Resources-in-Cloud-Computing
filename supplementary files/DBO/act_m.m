function [yz] = act_m(x,lambda)
r1=0.1;
pa=roundn(pi,-4);
m=x(1);
s=x(2);
fl=-inf;
fu=-inf;
while(m-floor(x(1))>0.000001)
    i=1;
    for angle=0.5*pa+pa/100 : pa/100 : 1.5*pa-pa/100  
        if pa/2 < angle && angle <= pa   
            X(i,:)=[m-r1.*sin(angle-pa/2),s+r1.*cos(angle-pa/2)];   
        elseif pa < angle && angle < 3*pa/2  
            X(i,:)=[m-r1.*cos(angle-pa),s-r1.*sin(angle-pa)];
        end
        i=i+1;
    end
    Xmin=min(X(:,1));
    if Xmin>floor(x(1))
        F = Gms(X(:,1),X(:,2),lambda);
        [fl,pos]=max(F);
        m=X(pos,1);
        s=X(pos,2);
    else
        r1=0.5*r1;
    end
end

r2=0.1;
pa=roundn(pi,-4);
m2=x(1);
s2=x(2);
while(ceil(x(1))-m2>0.000001)
i=1;
for angle=1.5*pa+pa/100 : pa/100 : 2.5*pa-pa/100    
    if 2*pa <= angle && angle <= 2.5*pa   
        X(i,:)=[m2+r2.*cos(angle),s2+r2.*sin(angle)]; 
    elseif 1.5*pa < angle && angle < 2*pa 
        X(i,:)=[m2+r2.*sin(angle-3*pa/2),s2-r2.*cos(angle-3*pa/2)];
    end
        i=i+1;
end
Xmax=max(X(:,1));
if Xmax<ceil(x(1))
F = Gms(X(:,1),X(:,2),lambda);
[fu,pos]=max(F);
m2=X(pos,1);
s2=X(pos,2);
else
  r2=0.5*r2;  
end
end

if fl>fu
    yz=[fl,m,s];
else
    yz=[fu,m2,s2];

end


