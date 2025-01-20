function [subpop, subBestScore, subBestPos] = updateSubpop(subpop, w, c1, c2, bounds, bestPos,net)

particles = subpop.particles;
velocities = zeros(size(particles)); 
numParticles = size(particles, 1);

bestScores = subpop.bestScores;
bestPositions = subpop.bestPositions;


for i = 1:numParticles
    r1 = rand(1, size(particles, 2));
    r2 = rand(1, size(particles, 2));
    velocities(i, :) = w * velocities(i, :) + ...
        c1 * r1 .* (bestPositions(i, :) - particles(i, :)) + ...
        c2 * r2 .* (bestPos - particles(i, :)); 
    
    
    maxSpeed = 1; 
    velocities(i, :) = max(min(velocities(i, :), maxSpeed), -maxSpeed);
    
    particles(i, :) = particles(i, :) + velocities(i, :);
    
   
    for d = 1:size(particles, 2)
        if particles(i, d) < bounds(d, 1)
            particles(i, d) = bounds(d, 1);
        elseif particles(i, d) > bounds(d, 2)
            particles(i, d) = bounds(d, 2);
        end
    end
    
  
    score = objectiveFunction(particles(i, :),net);
    
    
    if score < bestScores(i)
        bestScores(i) = score;
        bestPositions(i, :) = particles(i, :);
    end
end


[subBestScore, bestIdx] = min(bestScores);
subBestPos = bestPositions(bestIdx, :);


subpop.particles = particles;
subpop.bestScores = bestScores;
subpop.bestPositions = bestPositions;
end
