function leader=FindOptima(rep,beta)
    rep=rep([rep.CF]);
    rep=DetermineDomination(rep);%set rep.IsDominated

    rep=rep(~[rep.IsDominated]);%rep = non-dominated particles in repository

    % Grid Index of All Repository Members
    GI=[rep.GridIndex];
    
    % Occupied Cells : sells in the repository
    OC=unique(GI);
    
    % Number of corresponding element in OC
    % e.g. OC = [1 2 4 7],N(1) = number of OC(1) in GI
    % index means a compromised fitness, greater index stands for smaller fitness 
    N=zeros(size(OC));
    for k=1:numel(OC)
        N(k)=numel(find(GI==OC(k)));
    end


    % Selection Probabilities 
    % Greater the N is, the smaller chance of being selected
    P=exp(-beta*N);
    P=P/sum(P);
    
    % Roulette wheel selection, return index of element of OC
    sci=RouletteWheelSelection(P);
    
    % Selected Cell in OC
    sc=OC(sci);
    
    % Selected Cell Members
    SCM=find(GI==sc);
    
    % Selected Member Index, random from 1 to number of selected cell
    smi=randi([1 numel(SCM)]);
    
    % Selected Member 
    sm=SCM(smi);
    
    % Leader
    leader=rep(sm);
