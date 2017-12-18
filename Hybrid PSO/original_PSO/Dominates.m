function b=Dominates(x,y)
% if x dominates y, return true
    if isstruct(x)
        x=x.Cost;
    end
    
    if isstruct(y)
        y=y.Cost;
    end

    b=all(x<=y) && any(x<y);

end