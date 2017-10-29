function xnew=Mutate(x,pm,VarMinF,VarMaxF)
% function for applying mutation
    nVar=numel(x);
    j = randi([1 nVar]);
    VarMin = VarMinF(j);
    VarMax = VarMaxF(j);
    dx = pm*(VarMax - VarMin); % difference of pm*VarBound
    % lower bound = x - difference
    lb=x(j)-dx;
    if lb < VarMin
        lb=VarMin;
    end
    % upper bound = x + difference
    ub=x(j)+dx;
    if ub>VarMax
        ub=VarMax;
    end
    
    xnew=x;
    xnew(j)=unifrnd(lb,ub);

end