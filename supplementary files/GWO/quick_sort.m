%%%%%%%%%%%Ѱ��֧���%%%%%%%%
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
% M=2;                    %Ŀ�꺯��ֵ�ĸ���
% V=10;                    %ÿ��Ŀ�꺯��ֵ��ά��
% non_dom=[];
% individual=pop;         %pop����Ⱥ���Ա���+Ŀ�꺯��ֵ��������Ϊ��Ⱥ����
% while ~isempty(individual)  %individualΪ��ʱֹͣѭ��
%     temp1=[];
%     temp2=[];
%     flag=0;
%     %Number of individuals that dominate this individual  ֧��i�Ľ�ĸ���
%     %individual(i).n=0;
%     %Individuals which this individual dominate            ��i֧��Ľ�
%     %individual(i).p=[]
%     for i=2:size(individual,1)               %size(individual,1)Ϊindividual������
%         dom_less=0;
%         dom_equal=0;
%         dom_more=0;
%         for j=1:M                            %M=2������Ŀ�꺯��
%             if(individual(1,V+j)<individual(i,V+j))  %V=6��ÿ��Ŀ�꺯����Ϊ��ά   %%pareto֧���ж�
%                 dom_less=dom_less+1;         %��1�п���֧���i
%             elseif  (individual(1,V+j)==individual(i,V+j))
%                 dom_equal=dom_equal+1;       %����֧��
%             else
%                 dom_more=dom_more+1;         %��1�п��ܱ���i֧��
%             end
%         end
%         if dom_less==0 && dom_equal~=M       %����Ϊ��ʱ����ʾ��i֧���1
%             flag=flag+1;                     %flag�д�Ž�i֧���1�ĸ���
%             temp1=[temp1;individual(i,:)];   %temp1�д��֧���i
%         elseif dom_more==0 && dom_equal~=M   %����Ϊ��ʱ����ʾ��1֧���i
%             temp2=[temp2;individual(1,:)];   %temp2�д��֧���1
%         else                                 %��������������⻥��֧��
%             temp1=[temp1;individual(i,:)];   %temp1��Ҳ����п���֧��Ľ�i
%         end                                  %���j����i����Ѵ�ʱ��j����individual(i)_p��
%     end                                      %ѭ������ʱ����ʾ��1������������еĽ������֧���б�
%     if flag==0||isempty(temp1)               %�����ж�ֵΪ��ʱ����ʾ��1���ܵ�ǰ�κν��֧��
%         %����1Ϊ��ǰ�⼯�е�һ��pareto���Ž�
%         non_dom=[non_dom;individual(1,:)];
%     end
%     individual=temp1;                        %��ʱtemp1�д�ŵľ���ͨ���ϴαȽϺ�ʣ�µķ�֧��⣨��֧��⼴����������֧�䣩
end


