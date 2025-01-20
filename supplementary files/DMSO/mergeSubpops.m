function [pops, numSubpop] = mergeSubpops(pops, numSubpop,net)

scores = zeros(numSubpop, 1);
sizes = zeros(numSubpop, 1);

for i = 1:numSubpop
    if ~isempty(pops{i}) 
        scores(i) = min(pops{i}.bestScores);
        sizes(i) = size(pops{i}.particles, 1);
    end
end


[~, sortedIdx] = sortrows([scores, sizes]);


for i = 1:numSubpop
    if sizes(sortedIdx(i)) > 0
        for j = i+1:numSubpop
            if sizes(sortedIdx(j)) > 0 
                
                medianPos = median(pops{sortedIdx(i)}.particles, 1);
                
                
                pops{sortedIdx(i)}.particles(end + 1, :) = medianPos;
                
              
                pops{sortedIdx(j)}.particles(end, :) = [];
                sizes(sortedIdx(i)) = sizes(sortedIdx(i)) + 1; 
                sizes(sortedIdx(j)) = sizes(sortedIdx(j)) - 1; 
                
               
                newParticle = pops{sortedIdx(i)}.particles(end, :);
                newScore = objectiveFunction(newParticle,net);
                pops{sortedIdx(i)}.bestScores(end + 1) = newScore;
                pops{sortedIdx(i)}.bestPositions(end + 1, :) = newParticle;
                
               
                if sizes(sortedIdx(j)) == 0
                    pops(sortedIdx(j)) = [];
                    numSubpop = numSubpop - 1;
                end
                break; 
            end
        end
    end
end
end