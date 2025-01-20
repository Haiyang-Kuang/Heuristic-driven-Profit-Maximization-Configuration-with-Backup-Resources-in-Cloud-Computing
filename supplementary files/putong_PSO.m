
clear;close all;clc;
for Cycle = 1:1:20
numParticles = 50; 
numDimensions = 3;
maxIterations = 100; 


lowerBound = [10, 0.5, 0]; 
upperBound = [70, 4, 10]; 


positions = lowerBound + rand(numParticles, numDimensions) .* (upperBound - lowerBound);
velocities = rand(numParticles, numDimensions) * 0.1; 


personalBestPositions = positions;
personalBestScores = arrayfun(@(i) objectiveFunction(positions(i, :)), 1:numParticles);
[globalBestScore, bestIndex] = min(personalBestScores);
globalBestPosition = personalBestPositions(bestIndex, :);
count_fig=1;

for iter = 1:maxIterations
    for i = 1:numParticles
        
        w = 0.5; 
        c1 = 1.5; 
        c2 = 1.5; 
        
        r1 = rand(1, numDimensions);
        r2 = rand(1, numDimensions);
        
        velocities(i, :) = w * velocities(i, :) + ...
                           c1 * r1 .* (personalBestPositions(i, :) - positions(i, :)) + ...
                           c2 * r2 .* (globalBestPosition - positions(i, :));
        
  
        positions(i, :) = positions(i, :) + velocities(i, :);

        positions(i, :) = max(positions(i, :), lowerBound);
        positions(i, :) = min(positions(i, :), upperBound);

        currentScore = objectiveFunction(positions(i, :));

        if currentScore < personalBestScores(i)
            personalBestScores(i) = currentScore;
            personalBestPositions(i, :) = positions(i, :);
        end

        if currentScore < globalBestScore
            globalBestScore = currentScore;
            globalBestPosition = positions(i, :);
        end
    end
  
end
X1(Cycle)=globalBestScore;
fprintf('Cycle %d: Best Score = %.4f\n', Cycle, globalBestScore);
end

% fprintf('Iteration %d: Best Score = %.4f\n', iter, globalBestScore);
% fprintf('Final Best Position: [%.4f, %.4f, %.4f]\n', globalBestPosition(1), globalBestPosition(2), globalBestPosition(3));


function score = objectiveFunction(position)
load('net.mat')
m=position(1);
mu=position(2);
n=position(3);
r=1;
D_min=0.5;
D_max=5;
var=15;
w=0.5;
mu_max=4;
mu_min=0.5;
delta=0.01;
alpha_0=10^(-5);
eta=2;
beta_1=1.5;
beta_2=15;
siga=0.1;
Pst=2;
theta=2.5;
zeta=9.4192;
lambda=30.1;
rho=lambda.*r./(m.*mu);
if rho<1
    Im=(1-rho)./(sqrt(2.*pi.*m).*(1-rho).*(exp(rho)./(exp(1).*rho)).^m+1);
    A=exp(D_max./w)./(exp(D_max/w)-exp(D_min/w));
    B=1./(exp(D_max/w)-exp(D_min/w));
    E1=1-Im./(1-rho).*exp(-(1-rho).*m.*mu.*D_min);
    E2=A.*Im./(1-rho).*(exp(-(1-rho).*m.*mu.*D_min)-exp(-(1-rho).*m.*mu.*D_max));
    E3=B.*m.*mu.*Im./(-(1-rho).*m.*mu+1/w).*(exp((-(1-rho).*m.*mu+1/w).*D_min)-exp((-(1-rho).*m.*mu+1/w).*D_max));
    E=(E1+E2+E3).*var.*r.*lambda;
    alpha=alpha_0.*10^(eta.*(mu_max-mu)./(mu_max-mu_min));
    gamma=m.*alpha;
    H=net([position(1);position(2);position(3)]);
    barN=gamma.*H;
    C_rent=(m+n).*beta_1+barN.*beta_2./delta;
    C_ele=siga.*((m+n+barN./delta).*Pst+lambda.*r.*zeta.*mu.^(theta-1));
    C=C_rent+C_ele;
else
    E=0;
    C=0;
    endX1
score=-(E-C);
end