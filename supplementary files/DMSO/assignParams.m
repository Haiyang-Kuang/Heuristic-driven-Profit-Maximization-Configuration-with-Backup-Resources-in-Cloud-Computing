function [w, c1, c2] = assignParams(sortedIdx, numSubpop)
if numSubpop>1
w = linspace(0.3, 0.9, numSubpop);
c1 = linspace(2.5, 1, numSubpop); 
c2 = linspace(2.5, 1, numSubpop); 

w = w(sortedIdx);
c1 = c1(sortedIdx);
c2 = c2(sortedIdx);
else
    w=0.3;
    c1=1.5;
    c2=1.5;
end
