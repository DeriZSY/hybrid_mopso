function leader=SelectLeader(rep,beta)
% Select a leader from the group
    % Implement domination judgement on the repository
        
    % rep=DetermineDomination(rep);%set rep.IsDominated

    % newRep=rep(~[rep.IsDominated]);%rep = non-dominated particles in repository
    % Grid Index of All Repository Members


    newRep = rep;
    numOfCod = numel([newRep.GridSubIndex])/5;
    nVar = numel(rep(1).GridSubIndex);


    % find repeated times of each coordiantes
    numInCell  = zeros(1,numOfCod);
    for i = 1 : numOfCod
        for j = 1: numOfCod
            if newRep(i).GridSubIndex(1) == newRep(j).GridSubIndex(1) && newRep(i).GridSubIndex(1) == newRep(j).GridSubIndex(1) 
                numInCell(i) = numInCell(i) +1;
            end
        end
    end

    densFac = 1 ./ numInCell;



    P=beta*densFac;
    P=P/sum(P);
    
    sci=RouletteWheelSelection(P);
    

    leader=newRep(sci);

end