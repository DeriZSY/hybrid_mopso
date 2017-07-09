% Run MOPSO
clear;
clc;
itTimes = 5;
for ttl = 1:itTimes
mopso1;
clc;
end


clc
for i = 1 : itTimes
    opt = optima(i);
    fprintf('Cost functions:\nf1: %d\nf2: %d\n',opt.Cost(1),opt.Cost(2));
    fprintf('Grid Index: %d\nGrid SubIndex %d (x) and %d (y)\n\n',opt.GridIndex(1),opt.GridSubIndex);
end
avgGI = mean([optima.GridIndex]);
avgCf = mean([optima.Cost],2);
% rangeC = max([optima.Cost]) - min([optima.Cost]);
% rangeI = max([optima.GridIndex]) - min([optima.GridIndex]);
fprintf('Average GridIndex = %f\n',avgGI);
fprintf('Average f1 = %f, f2 = %f\n',avgCf);
% fprintf('Range of GridIndex = %f\n',rangeI);
% fprintf('Range of f1 is %f, f2 is %f\n',rangeC);