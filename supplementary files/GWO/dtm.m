function r2=dtm(AA,BB)
% r2=-inf;
r1=0.01;
pa=roundn(pi,-4);

while r1<100
    flag1=0;
    for angle=pa/10:pa/1000:2*pa%显然根本不用这么大的范围，因为基本上是在第二象限之内
        if angle<=0.5*pa
            j1=AA+r1.*cos(angle);   %在给定了初始点情况下,j1是横，j2是纵
            j2=BB+r1.*sin(angle);
        elseif pa/2<angle<=pa%第二象限
            j1=AA-r1.*sin(angle-pa/2);   %在给定了初始点情况下,j1是横，j2是纵
            j2=BB+r1.*cos(angle-pa/2);
        elseif pa<angle<=3*pa/2%第二象限
            j1=AA-r1.*cos(angle-pa);   %第三
            j2=BB-r1.*sin(angle-pa);
        else
            j1=AA+r1.*sin(angle-3*pa/2);   %第四
            j2=BB-r1.*cos(angle-3*pa/2);
            
        end
        if j1>=20||j1<=6||j2<=0.5||j2>=2||T_ms(j1,j2)>0.1
            continue
        end
        f4=100*T_ms(j1,j2);
        
        if     abs(f4-10)<=0.05    %大圈相切导数判断,带入的值也应该一致
            r2=r1; %拿一个东西去存储这个距离
            flag1=1;
            break
        end
    end
    if flag1==1
        break
    end
    r1=r1+0.001;
end
end
