function leader=SelectLeader(rep,beta)
% Select a leader from the group
    newRep = rep;

    % repNum = numel([rep.GridSubIndex])/5;
    repNum = numel(rep);
    nVar = numel(rep(1).GridSubIndex);
    nObj = 5;


    % find repeated times of each coordiantes
    numInCell  = zeros(1,repNum);

    for i = 1 : repNum
        for j = 1: repNum
            inSameCell = true;
            for k = 1 : nObj
                inSameCell = inSameCell & newRep(i).GridSubIndex(k) == newRep(j).GridSubIndex(k);
            end

            if  inSameCell
                numInCell(i) = numInCell(i) +1;
            end
        end
    end

    density = 1 ./ numInCell;

    P = beta * density;
    P = P / sum(P);

    sci    = RouletteWheelSelection(P);
    leader = newRep(sci);

end
