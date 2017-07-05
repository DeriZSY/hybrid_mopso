function leader=SelectLeader(rep,beta)
% Select a leader from the group
    % Implement domination judgement on the repository
        
    % rep=DetermineDomination(rep);%set rep.IsDominated

    % newRep=rep(~[rep.IsDominated]);%rep = non-dominated particles in repository
    % Grid Index of All Repository Members
    newRep = rep;
    numOfCod = numel([newRep.GridSubIndex])/2;
    nVar = numel(rep(1).GridSubIndex);
    % indexUnique = nan;
    % % find index unique cell;
    % for i = 1: numOfCod
    %     for j = 1 : numOfCod
    %         if newRep(i).GridSubIndex ~= newRep(j).GridSubIndex
    %             indexUnique(end+1) = i;
    %         end
    %     end
    % end

    % find repeated times of each coordiantes
    numInCell  = zeros(1,numOfCod);
    for i = 1 : numOfCod
        % numInCell(i) = numInCell(i) -1;
        for j = 1: numOfCod
            if newRep(i).GridSubIndex(1) == newRep(j).GridSubIndex(1) && newRep(i).GridSubIndex(1) == newRep(j).GridSubIndex(1) 
                numInCell(i) = numInCell(i) +1;
            end
        end
    end

    densFac = 1 ./ numInCell;


    % GI=[newRep.GridIndex];
    
    % % Occupied Cells : sells in the repository
    % OC=unique(GI);
    
    % % Number of corresponding element in OC
    % % e.g. OC = [1 2 4 7],N(1) = number of OC(1) in GI
    % % index means a compromised fitness, greater index stands for smaller fitness 
    % N=zeros(size(OC));
    % for k=1:numel(OC)
    %     N(k)=numel(find(GI==OC(k)));
    % end


    % Selection Probabilities 
    % Greater the N is, the smaller chance of being selected
    P=beta*densFac;
    P=P/sum(P);
    
    % Roulette wheel selection, return index of element of OC
    sci=RouletteWheelSelection(P);
    
    % % Selected Cell in OC
    % sc=OC(sci);
    
    % % Selected Cell Members
    % SCM=find(GI==sc);
    
    % % Selected Member Index, random from 1 to number of selected cell
    % smi=randi([1 numel(SCM)]);
    
    % % Selected Member 
    % sm=SCM(smi);
    % Leader
    leader=newRep(sci);

end