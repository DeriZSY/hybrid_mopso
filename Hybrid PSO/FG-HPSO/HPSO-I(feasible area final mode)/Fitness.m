function value = Fitness(X,varMin,varMax)
	x = X(1);
	y = X(2);
	f1 = 4*x^2 + 4*y^2;
	f2 = (x-5)^2 + (y-5)^2;
	% z = [f1
	%      f2];
	nVar = numel(X);
	G = 0;
	for i = 1:nVar
  		G = G + sqrt((X(i) - max (varMin(i), X(i) ) )^2 +(X(i) - min(X(i) ,  varMax(i)))^2);
	end
	f1 = f1 + G;
	f2 = f2 + G;
	value = [f1
	         f2];
	         
end
