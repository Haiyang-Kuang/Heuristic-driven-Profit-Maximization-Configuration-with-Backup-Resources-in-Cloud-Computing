% -----------------------------------------------------------------------------------------------------------
% Dung Beetle Optimizer: (DBO) (demo)
% Programmed by Jian-kai Xue    
% Updated 28 Nov. 2022.                     
%
% This is a simple demo version only implemented the basic         
% idea of the DBO for solving the unconstrained problem.    
% The details about DBO are illustratred in the following paper.    
% (To cite this article):                                                
%  Jiankai Xue & Bo Shen (2022) Dung beetle optimizer: a new meta-heuristic
% algorithm for global optimization. The Journal of Supercomputing, DOI:
% 10.1007/s11227-022-04959-6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% qq群：439115722
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%pop是种群，M是迭代次数，fobj是用来计算适应度的函数
%pNum：滚球蜣螂的数量   

%需要注意的是种群的大小以及各个小种群的大小都是可以根据实际问题自行调整的
function [fMin , bestX, Convergence_curve, pos_curve] = DBO(pop, M,c,d,dim,fobj,lambda)
        
   P_percent = 0.2;   

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
pNum = round( pop *  P_percent );   

lb= c.*ones( 1,dim );   
ub= d.*ones( 1,dim );    
%Initialization 
for i = 1 : pop
    
    x( i, : ) = lb + (ub - lb) .* rand( 1, dim );  
    fit( i ) = fobj( x( i, : ),lambda) ;                       
end

yzk=zeros(1,3);
pFit = fit;                       
pX = x; 
 XX=pX;    
[ fMin, bestI ] = min( fit );      % fMin denotes the global optimum fitness value
bestX = x( bestI, : );             % bestX denotes the global optimum position corresponding to fMin

 % Start updating the solutions.
for t = 1 : M    
       
        [fmax,B]=max(fit);
        worse= x(B,:); %
       r2=rand(1);
 

    for i = 1 : pNum    
        if(r2<0.9)
            r1=rand(1);
          a=rand(1,1);
          if (a>0.1)
           a=1;
          else
           a=-1;
          end
    x( i , : ) =  pX(  i , :)+0.3*abs(pX(i , : )-worse)+a*0.1*(XX( i , :)); % Equation (1)
       else

           aaa= randperm(180,1);
           if ( aaa==0 ||aaa==90 ||aaa==180 )
            x(  i , : ) = pX(  i , :);   
           end
         theta= aaa*pi/180;   
       
       x(  i , : ) = pX(  i , :)+tan(theta).*abs(pX(i , : )-XX( i , :));    % Equation (2)      

        end
      
        x(  i , : ) = Bounds( x(i , : ), lb, ub ); 
        fit(  i  ) = fobj( x(i , : ),lambda);
    end 
 [ fMMin, bestII ] = min( fit );      % 
  bestXX = x( bestII, : );           

 R=1-t/M;                           %

 Xnew1 = bestXX.*(1-R); 
     Xnew2 =bestXX.*(1+R);                    
   Xnew1= Bounds( Xnew1, lb, ub );
   Xnew2 = Bounds( Xnew2, lb, ub );
   
   
     Xnew11 = bestX.*(1-R); 
     Xnew22 =bestX.*(1+R);                     
   Xnew11= Bounds( Xnew11, lb, ub );
    Xnew22 = Bounds( Xnew22, lb, ub ); 
    
    
    for i = ( pNum + 1 ) :12                  % Equation (4)
     x( i, : )=bestXX+((rand(1,dim)).*(pX( i , : )-Xnew1)+(rand(1,dim)).*(pX( i , : )-Xnew2));
   x(i, : ) = Bounds( x(i, : ), Xnew1, Xnew2 ); 
  fit(i ) = fobj(  x(i,:),lambda) ;%
   end
  for i = 13: 19                  % Equation (6)

   
        x( i, : )=pX( i , : )+((randn(1)).*(pX( i , : )-Xnew11)+((rand(1,dim)).*(pX( i , : )-Xnew22)));
       x(i, : ) = Bounds( x(i, : ),lb, ub); 
       fit(i ) = fobj(  x(i,:),lambda) ;
  
  end
  for j = 20 : pop                 % Equation (7)
       x( j,: )=bestX+randn(1,dim).*((abs(( pX(j,:  )-bestXX)))+(abs(( pX(j,:  )-bestX))))./2;
      x(j, : ) = Bounds( x(j, : ), lb, ub );
      fit(j ) = fobj(x(j,:),lambda) ;
  end
   % Update the individual's best fitness vlaue and the global best fitness value
     XX=pX;
    for i = 1 : pop 
        if ( fit( i ) < pFit( i ) )
            pFit( i ) = fit( i );
            pX( i, : ) = x( i, : );
        end
        
        if( pFit( i ) < fMin )
           % fMin= pFit( i );
           fMin= pFit( i );
            bestX = pX( i, : );
          %  a(i)=fMin;
            
        end
    end
  
     Convergence_curve(t)=fMin;
     pos_curve(t,:)=bestX;
  
%     disp([' In iteration ' num2str(t) ': Number of solutions in the archive = ' num2str(fMin)]); 
  
end

% Application of simple limits/bounds
function s = Bounds( s, Lb, Ub)
  % Apply the lower bound vector
  temp = s;
  I = temp < Lb;
  temp(I) = Lb(I);
  
  % Apply the upper bound vector 
  J = temp > Ub;
  temp(J) = Ub(J);
  % Update this new move 
  s = temp;
function S = Boundss( SS, LLb, UUb)
  % Apply the lower bound vector
  temp = SS;
  I = temp < LLb;
  temp(I) = LLb(I);
  
  % Apply the upper bound vector 
  J = temp > UUb;
  temp(J) = UUb(J);
  % Update this new move 
  S = temp;
%---------------------------------------------------------------------------------------------------------------------------
