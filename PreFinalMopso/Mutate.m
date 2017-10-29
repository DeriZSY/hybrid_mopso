function position = Mutate(x,pm,VarMin,VarMax)
% function for applying mutation
    nVar=numel(x);
    j=randi([1 nVar]);
    VarMin = VarMin(j);
    VarMax = VarMax(j);

    dx=pm*(VarMax-VarMin); % difference of pm*VarBound
    % lower bound = x - difference
    lb=x(j)-dx;
    if lb<VarMin
        lb=VarMin;
    end
    % upper bound = x + difference
    ub=x(j)+dx;
    if ub>VarMax
        ub=VarMax;
    end

    pJ = unifrnd(lb,ub);
    pJInt = floor(pJ);
    if pJ - pJInt > 0.5
        pJInt = pJInt + 1;
    end
    x(j) = pJInt;
    position = x;

end