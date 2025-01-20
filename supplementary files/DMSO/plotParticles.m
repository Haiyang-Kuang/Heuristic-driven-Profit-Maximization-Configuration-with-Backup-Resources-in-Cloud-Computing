function plotParticles(pops, iter, bestPos, count_fig, subplot_position)

% color=[0.50,0.50,0.50;0.90,0.62,0.00;0.34,0.71,0.91;0.00,0.62,0.45;0.00,0.45,0.70;0.84,0.37,0.00];
figure(1)
kkk=count_fig;
subplot('Position', subplot_position(kkk, :));
hold on;
box on
grid on
colors = lines(length(pops));
for j = 1:length(pops)
    particles = pops{j}.particles;
   
    scatter3(particles(:, 1), particles(:, 2),particles(:, 3), 30, colors(j, :), 'filled', 'DisplayName', sprintf('Sub %d', j),'MarkerFaceAlpha', 0.5);
end
scatter3(bestPos(1), bestPos(2), bestPos(3), 100, 'k', 'filled', 'DisplayName', 'GBP', 'MarkerEdgeColor', 'w');
fprintf('Current Best Position: [%.4f, %.4f, %.4f]\n', bestPos(1), bestPos(2), bestPos(3));

title(sprintf('Individual Positions at Iteration %d', iter));
h1=xlabel('$m$');
h2=ylabel('$s$');
h3=zlabel('$n$');
set([h1,h2,h3],'interpreter','latex','fontsize',16)
legend show;
grid on;
hold off;

end