%%%%%%%%%%%寻找支配解%%%%%%%%
function non_dom=quick_sort(pop)
    npop=size(pop,1);
    K=10;
    pop(:,K+3)=0;
    for i=1:npop
        pop(i,K+3)=0;
        for j=1:i-1
            if pop(j,K+3)==0
                if Dominates(pop(i,K+1:K+2)',pop(j,K+1:K+2)')
                    pop(j,K+3)=1;
                elseif Dominates(pop(j,K+1:K+2)',pop(i,K+1:K+2)')
                    pop(i,K+3)=1;
                    break;
                end
            end
        end
    end
   ind=find(pop(:,K+3)==0);
   non_dom=pop(ind,1:K+2);

% [N,P]=size(pop);
% M=2;                    %目标函数值的个数
% V=10;                    %每个目标函数值的维数
% non_dom=[];
% individual=pop;         %pop：种群（自变量+目标函数值），行数为种群数量
% while ~isempty(individual)  %individual为空时停止循环
%     temp1=[];
%     temp2=[];
%     flag=0;
%     %Number of individuals that dominate this individual  支配i的解的个数
%     %individual(i).n=0;
%     %Individuals which this individual dominate            被i支配的解
%     %individual(i).p=[]
%     for i=2:size(individual,1)               %size(individual,1)为individual的行数
%         dom_less=0;
%         dom_equal=0;
%         dom_more=0;
%         for j=1:M                            %M=2，两个目标函数
%             if(individual(1,V+j)<individual(i,V+j))  %V=6，每个目标函数均为六维   %%pareto支配判断
%                 dom_less=dom_less+1;         %解1有可能支配解i
%             elseif  (individual(1,V+j)==individual(i,V+j))
%                 dom_equal=dom_equal+1;       %互不支配
%             else
%                 dom_more=dom_more+1;         %解1有可能被解i支配
%             end
%         end
%         if dom_less==0 && dom_equal~=M       %该行为真时，表示解i支配解1
%             flag=flag+1;                     %flag中存放解i支配解1的个数
%             temp1=[temp1;individual(i,:)];   %temp1中存放支配解i
%         elseif dom_more==0 && dom_equal~=M   %该行为真时，表示解1支配解i
%             temp2=[temp2;individual(1,:)];   %temp2中存放支配解1
%         else                                 %其余情况：两个解互不支配
%             temp1=[temp1;individual(i,:)];   %temp1中也存放有可能支配的解i
%         end                                  %则称j优于i，则把此时的j放入individual(i)_p中
%     end                                      %循环结束时，表示解1依次与后面所有的解进行了支配判别
%     if flag==0||isempty(temp1)               %该行判断值为真时，表示解1不受当前任何解的支配
%         %即解1为当前解集中的一个pareto最优解
%         non_dom=[non_dom;individual(1,:)];
%     end
%     individual=temp1;                        %此时temp1中存放的就是通过上次比较后剩下的非支配解（非支配解即不受其他解支配）
end


