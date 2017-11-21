function position = Mutate(x,pm)
% function for applying mutation
    global VarMinF;
    global VarMaxF;

    nVar = numel(x);
    j    = randi([1 nVar]);
    VarMin = VarMinF(j);
    VarMax = VarMaxF(j);

    dx = pm * (VarMax - VarMin);

    lb = x(j) - dx;
    if lb < VarMin
        lb = VarMin;
    end

    ub = x(j) + dx;
    if ub > VarMax
        ub = VarMax;
    end

    posJ = unifrnd(lb,ub);
    posJn = floor(posJ);

    if posJ - posJn > 0.5
        posJ = posJ + 1;
    end

    x(j) = posJ;
    position = x;

end
