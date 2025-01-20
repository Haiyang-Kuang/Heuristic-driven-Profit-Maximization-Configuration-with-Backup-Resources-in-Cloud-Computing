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
% qq»∫£∫439115722
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all 
clc

SearchAgents_no=50;

Function_name='F4'; 

Max_iteration=100; 
i=1;
for lambda=20.1:5:60.1
% Load details of the selected benchmark function
[lb,ub,dim,fobj]=Get_Functions_details(Function_name);
[fMin_cao(i),bestX_cao(i,:),DBO_curve,pos_curve]=DBO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj,lambda); 
% X3(cycle)=fMin;
fprintf('Cycle %d, Final Best Score: %.4f\n', i, fMin_cao(i));
i=i+1;
end
A=-fMin_cao';
% save Cao_data.mat bestX_cao fMin_cao
%
% semilogy(DBO_curve,'Color','g')
% title('Objective space')
% xlabel('Iteration');
% ylabel('Best score obtained so far');
%axis tight
% grid on
% box on
% legend('DBO')
% display(['The best solution obtained by DBO is : ', num2str(bestX)]);
% display(['The best optimal value of the objective funciton found by DBO is : ', num2str(fMin)]);
% for k=1:7
%     x=bestX(k,:);
%     lam=lambda(k);
%     yzk(k,:)=act_m(x,lam);
% end
% %%
% kk=[5,10,15,20,25,30,35];
% for kkk=1:7
%     F(kkk,:)=act_m(bestX(kkk,:),kk(kkk));
% end


