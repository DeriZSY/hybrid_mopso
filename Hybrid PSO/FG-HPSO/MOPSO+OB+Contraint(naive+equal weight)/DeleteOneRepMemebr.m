
function rep=DeleteOneRepMemebr(rep,gamma)
%Select memeber of repository with greater fitness coefficient
%Delete it from repository

    % Grid Index of All Repository Members
    GI=[rep.GridIndex];
    
    % Occupied Cells
    OC=unique(GI);
    
    % Number of Particles in Occupied Cells
    N=zeros(size(OC));
    for k=1:numel(OC)
        N(k)=numel(find(GI==OC(k)));
    end
    
    % Selection Probabilities, greater fitness, greater probability
    P=exp(gamma*N);
    P=P/sum(P);
    
    % Selected Cell Index
    sci=RouletteWheelSelection(P);
    
    % Selected Cell
    sc=OC(sci);
    
    % Selected Cell Members
    SCM=find(GI==sc);
    
    % Selected Member Index
    smi=randi([1 numel(SCM)]);
    
    % Selected Member
    sm=SCM(smi);
    
    % Delete Selected Member
    rep(sm)=[];

end