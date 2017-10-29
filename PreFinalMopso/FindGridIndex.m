function particle=FindGridIndex(particle,Grid,rep)
% find the index of a particle bounded by a square
% each column in one row represent coordinate in each axis
    nObj=numel(particle.Cost);
    
    nGrid=numel(Grid(1).LB);
    
    particle.GridSubIndex=zeros(1,nObj);
    
    for j=1:nObj
    	if (isnan(particle.Cost(j)))
            Cos = [rep.Cost];
            Cos = [Cos(j,:)];
            idxDelete = find(isnan(Cos));
            rep(idxDelete) = [];
    		return;
    	end
        UB = Grid(j).UB;
        particle.GridSubIndex(j)=...
            find(particle.Cost(j)< UB,1,'first');
        
    end
   
      particle.GridIndex = sum([particle.GridSubIndex]);
end