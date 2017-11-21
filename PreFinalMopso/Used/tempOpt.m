function optima=tempOpt(rep,meanCost)
% Find optima solution from a set of solutions

  global cSum1;
  global cSum2;
  global cEq1;
  global cEq2;
    rep=rep([rep.CF]);
    rep=DetermineDomination(rep);
    rep=rep(~[rep.IsDominated]);

    for i = 1: numel(rep)
        flag = 0;
        Cost = [rep(i).Cost];
        rep(i).GridIndex = Cost(1) +Cost(2) + Cost(3) +Cost(4);
        if(isnan(rep(i).GridIndex))
          rep(i) = [];
          continue;
        end
    end

    minGridIndex = min([rep.GridIndex]);
    SCM=find([rep.GridIndex] == minGridIndex);

%% Get Optima
    k =  1;
    opts   = rep(SCM);
    if(numel(opts) > 1)
      time = [opts.Cost];
      time = time(5,:);
      minTime = min(time);
      k = find(time == minTime);
    end

    opts   = opts(k);
    optima = leaders(1);
end
