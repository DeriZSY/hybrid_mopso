function particle=FindGridIndex(particle,Grid,epsilon,delta,meanCost)
% find the index of a particle bounded by a square
% each column in one row represent coordinate in each axis
    nObj=numel(particle.Cost);
    
    nGrid=numel(Grid(1).LB);
    
    particle.GridSubIndex=zeros(1,nObj);
    
    for j=1:nObj
        UB = Grid.UB;
        particle.GridSubIndex(j)=...
            find(particle.Cost(j)< UB,1,'first');
        
    end

    %Interpretationof index : the order of the objective matters
    %objective one is of more importance than objective 2
    particle.GridIndex=particle.GridSubIndex(1);
        particle.GridIndex=particle.GridIndex-1;
        particle.GridIndex=particle.GridIndex + delta*abs(particle.GridIndex/meanCost(1)-particle.GridSubIndex(2)/meanCost(2));
        particle.GridIndex=epsilon(1)*particle.GridIndex+ epsilon(2)*particle.GridSubIndex(j);
    
end