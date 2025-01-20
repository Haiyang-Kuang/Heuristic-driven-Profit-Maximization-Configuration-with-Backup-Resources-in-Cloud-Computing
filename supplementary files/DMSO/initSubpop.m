function subpop = initSubpop(particlesPerSubpop, dim, bounds,net)

particles = rand(particlesPerSubpop, dim);
for d = 1:dim
    particles(:, d) = particles(:, d) * (bounds(d, 2) - bounds(d, 1)) + bounds(d, 1);
end
subpop.particles = particles;
subpop.bestPositions = particles;
subpop.bestScores = arrayfun(@(i) objectiveFunction(particles(i, :),net), 1:particlesPerSubpop)';
end