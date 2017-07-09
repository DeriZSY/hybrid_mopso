% Run MOPSO
clear;
clc;
% addpath(/Users/DeriZsy/Desktop/HybridPSODevelopment/Hybrid\ PSO/FG-HPSO/HPSO-I\(feasible\ area\ completed\ version\)); 
%mopso_It100
itTimes = 20;
for ttl = 1: itTimes
	% ttl = 1;
	mopso1;
	figure;
	rep_costs=[rep.Cost];
	plot(rep_costs(1,:),rep_costs(2,:),'r*');
	xlabel('1^{st} Objective');
	ylabel('2^{nd} Objective');
	grid on;
	hold on;
	% clc;

	%mopso_It250
	% ttl = 2;
	mopso2;
	rep_costs=[rep.Cost];
	plot(rep_costs(1,:),rep_costs(2,:),'bv');

	hold on;
	clc;

	% %mopso_It370
	% ttl = 3;
	mopso3;
	rep_costs=[rep.Cost];
	plot(rep_costs(1,:),rep_costs(2,:),'g>');

	hold on;
	clc;
	
	mopso4;
	rep_costs=[rep.Cost];
	plot(rep_costs(1,:),rep_costs(2,:),'ks');

	hold on;
	clc;


	legend('mopso+densityMeasure', 'mopso+KConstraint','mopso+variantInertialWeight','mopso+VIW+KConstraint');
end

clc
j = 1;
%%Mopso1
fprintf('____________________________________________________________\n');
fprintf('MOPSO%d',j);
for i = 1 : itTimes
    opt = optima1(i);
	fprintf('Cost functions:\nf1: %d\nf2: %d\n',opt.Cost(1),opt.Cost(2));
    fprintf('Grid Index: %d\nGrid SubIndex %d (x) and %d (y)\n\n',opt.GridIndex(1),opt.GridSubIndex);
end
avgGI = mean([optima1.GridIndex]);
avgCf = mean([optima1.Cost],2);
fprintf('Average GridIndex = %f\n',avgGI);
fprintf('Average f1 = %f, f2 = %f\n',avgCf);



%%Mopso2
j = 2;
fprintf('____________________________________________________________\n');
fprintf('MOPSO%d',j);
for i = 1 : itTimes
    opt = optima2(i);
	fprintf('Cost functions:\nf1: %d\nf2: %d\n',opt.Cost(1),opt.Cost(2));
    fprintf('Grid Index: %d\nGrid SubIndex %d (x) and %d (y)\n\n',opt.GridIndex(1),opt.GridSubIndex);
end
avgGI = mean([optima2.GridIndex]);
avgCf = mean([optima2.Cost],2);
fprintf('Average GridIndex = %f\n',avgGI);
fprintf('Average f1 = %f, f2 = %f\n',avgCf);


j = 3;
fprintf('____________________________________________________________\n');
fprintf('MOPSO%d',j);
for i = 1 : itTimes
    opt = optima3(i);
	fprintf('Cost functions:\nf1: %d\nf2: %d\n',opt.Cost(1),opt.Cost(2));
    fprintf('Grid Index: %d\nGrid SubIndex %d (x) and %d (y)\n\n',opt.GridIndex(1),opt.GridSubIndex);
end
avgGI = mean([optima3.GridIndex]);
avgCf = mean([optima3.Cost],2);
fprintf('Average GridIndex = %f\n',avgGI);
fprintf('Average f1 = %f, f2 = %f\n',avgCf);


j = 4;
fprintf('____________________________________________________________\n');
fprintf('MOPSO%d',j);
for i = 1 : itTimes
    opt = optima4(i);
	fprintf('Cost functions:\nf1: %d\nf2: %d\n',opt.Cost(1),opt.Cost(2));
    fprintf('Grid Index: %d\nGrid SubIndex %d (x) and %d (y)\n\n',opt.GridIndex(1),opt.GridSubIndex);
end
avgGI = mean([optima4.GridIndex]);
avgCf = mean([optima4.Cost],2);
fprintf('Average GridIndex = %f\n',avgGI);
fprintf('Average f1 = %f, f2 = %f\n',avgCf);