% Dynamic Merging Swarm Optimization
clear;close all;
load('net.mat')
for cycle=1:1:20

totalParticles = 50; 
numSubpop = 5;
numCurSp=5;
particlesPerSubpop = totalParticles / numSubpop; 
dim = 3; 
maxIter = 100; 


bounds = [10, 70; 0.5, 4; 0, 10];

bestScore = inf; 
bestPos = zeros(1, dim); 


pops = cell(numSubpop, 1);
for i = 1:numSubpop
    pops{i} = initSubpop(particlesPerSubpop, dim, bounds,net);
end


survivalRecords = zeros(maxIter, 2); 
particleCounts = zeros(maxIter, numSubpop); 


restCount = 0; 
canMerge = false; 


% count_fig=1;
% N = 2;
% M = 3;
% subplot_length = 3;
% subplot_width = 4;
% top_margin = 0.3;
% bottom_margin = 0.8;
% left_margin = 0.7;
% right_margin = 0.1;
% gap = 0.9;
% figure_width = M * subplot_width + (M -1) * gap+left_margin+right_margin;
% figure_length = N * subplot_length + (N -1) * gap + top_margin + bottom_margin;
% subplot_position = zeros(N * M, 4);
% for i = 1:N
%     for j = 1:M
%         x_left =( (j - 1) * (subplot_width+gap) + left_margin )/ figure_width;
%         y_bottom = 1-(i*subplot_length+top_margin+(i-1)*gap)/ figure_length ;
%         subplot_position((i - 1) * M + j, :) = [x_left, y_bottom, subplot_width / figure_width, subplot_length / figure_length];
%     end
% end
% figure('Units', 'inches','Position', [1, -1, figure_width, figure_length]);


for iter = 1:maxIter
  
    scores = zeros(numSubpop, 1);
    for j = 1:numSubpop
        if ~isempty(pops{j}) && ~isempty(pops{j}.particles)
            scores(j) = min(pops{j}.bestScores); 
        else
            scores(j) = inf;
        end
    end
    
    [~, sortedIdx] = sort(scores);
    
    [w, c1, c2] = assignParams(sortedIdx, numSubpop);
    
    for j = 1:numSubpop
        if ~isempty(pops{j}) && ~isempty(pops{j}.particles) 
            [pops{j}, subBestScore, subBestPos] = ...
                updateSubpop(pops{j}, w(j), c1(j), c2(j), bounds, bestPos,net); % 传递 bestPos
            
           
            if subBestScore < bestScore
                bestScore = subBestScore;
                bestPos = subBestPos;
            end
        end
    end
    
    if numCurSp > numSubpop
        restCount = 0; 
        canMerge = false;
        numCurSp = numSubpop;
    end
    
    if canMerge && iter > 5 
        [pops, numSubpop] = mergeSubpops(pops, numSubpop,net);
    end
    
    if ~canMerge
        restCount = restCount + 1;
        if restCount >= 5 
            canMerge = true;
        end
    end
    
%     survivalRecords(iter, 1) = numSubpop; 
%     survivalRecords(iter, 2) = sum(cellfun(@(x) size(x.particles, 1), pops));
%     
%     for j = 1:numSubpop
%         particleCounts(iter, j) = size(pops{j}.particles, 1);
%     end
    
%     fprintf('Iter %d: Best Score = %.4f, Surviving Pops = %d\n, Current Best Position: [%.4f, %.4f, %.4f]\n', ...
%         iter, bestScore, numSubpop, bestPos(1), bestPos(2), bestPos(3));
%     %
%     if iter == 1 || iter == 15 || iter == 30 || iter == 50 || iter == 75 || iter == 100
%         plotParticles(pops, iter, bestPos, count_fig, subplot_position);
%         count_fig=count_fig+1;
%         %         save(sprintf('particle_positions_iter_%d.mat', iter), 'pops', 'bestPos');
%     end
%     Re_BS(iter) = bestScore;
end
X4(cycle)=bestScore;
fprintf('Cycle %d, Final Best Score: %.4f\n', cycle, bestScore);
end

% fprintf('Final Best Position: [%.4f, %.4f, %.4f]\n', bestPos(1), bestPos(2), bestPos(3));
% fprintf('Final Best Score: %.4f\n', bestScore);
% 
% maxIter=100;
% color=[0.50,0.50,0.50;0.90,0.62,0.00;0.34,0.71,0.91;0.00,0.62,0.45;0.00,0.45,0.70;0.84,0.37,0.00];
% figure(2);
% set(gcf,'position',[0 0 1200 800])
% subplot(2, 2, 1);
% set(gca,'position', [0.065 0.615 0.425 0.375]);
% hold on
% box on
% grid on
% plot(1:maxIter, survivalRecords(:, 1),'-k','LineWidth',1);
% x1=[1:5,17:21,34:38,53:57,90:100];
% y1=[ones(1,5)*5,ones(1,5)*4,ones(1,5)*3,ones(1,5)*2,ones(1,11)];
% x2=[6:16,22:33,39:52,58:89];
% y2=[ones(1,11)*5,ones(1,12)*4,ones(1,14)*3,ones(1,32)*2];
% h2=plot(x1,y1,'o','LineWidth',1,'MarkerSize',6,'MarkerEdgeColor',color(4,:));
% h3=plot(x2,y2,'o','LineWidth',1,'MarkerSize',6,'MarkerEdgeColor',color(1,:));
% legend([h2,h3],{'Rest Cycle','Annexation Cycle'})
% % title('Surviving Subpopulations Over Iterations');
% xlabel({'Iteration';'(a)'});
% ylabel('Surviving Subpopulations');
% 
% 
% subplot(2, 2, 3);
% hold on
% box on
% grid on
% set(gca,'position', [0.065 0.12 0.425 0.375]);
% plot(1:maxIter, Re_BS,'-k','LineWidth',1);
% % title('Total Particles Over Iterations');
% legend('Fitness Curve')
% xlabel({'Iteration';'(b)'});
% ylabel('Current Best Fitness');
% 
% subplot(2, 2, [2 4]);
% set(gca,'position', [0.56 0.12 0.425 0.87]);
% hold on;
% box on
% grid on
% plot(1:maxIter, survivalRecords(:, 2), '-^','MarkerSize',4,'LineWidth',1,'Color',color(1,:),'DisplayName', 'Tatal Pop');
% for j = 1:5
%     plot(1:maxIter, particleCounts(:, j), '-.o','LineWidth',1,'Color',color(j+1,:), 'DisplayName', sprintf('Subpop %d', j));
% end
% % title('Particle Counts in Each Subpopulation Over Iterations');
% xlabel({'Iteration';'(c)'});
% ylabel('Number of Individuals');
% text(60,35,'Subpop 5','FontSize', 16);
% text(60,15,'Subpop 4','FontSize', 16);
% text(28,10,'Subpop 3','FontSize', 16);
% text(14,5,'Subpop 1','FontSize', 16);
% text(0.5,2,'Subpop 2','FontSize', 16);
% ylim([0 55])
% legend show;
% hold off;

%% 
% N = 3;
% M = 2;
% subplot_length = 3;
% subplot_width = 4;
% top_margin = 0.3;
% bottom_margin = 0.8;
% left_margin = 0.7;
% right_margin = 0.1;
% gap = 0.9;
% figure_width = M * subplot_width + (M -1) * gap+left_margin+right_margin;
% figure_length = N * subplot_length + (N -1) * gap + top_margin + bottom_margin;
% subplot_position = zeros(N * M, 4);
% for i = 1:N
%     for j = 1:M
%         x_left =( (j - 1) * (subplot_width+gap) + left_margin )/ figure_width;
%         y_bottom = 1-(i*subplot_length+top_margin+(i-1)*gap)/ figure_length ;
%         subplot_position((i - 1) * M + j, :) = [x_left, y_bottom, subplot_width / figure_width, subplot_length / figure_length];
%     end
% end
% figure('Units', 'inches','Position', [1, -1, figure_width, figure_length]);
% cord=[1 15 30 50 75 100];
% for count_fig=1:6
%     iter=cord(count_fig);
%     load(sprintf('particle_positions_iter_%d.mat', iter), 'pops', 'bestPos');
%     plotParticles(pops, iter, bestPos, count_fig, subplot_position);
% end


%%
% save('particleCounts.mat', 'particleCounts');
%
% save('huitu.mat', 'Re_BS', 'survivalRecords');
% particleCounts=xlsread('D:\matlabfile\data.xlsx','A1:E100');
