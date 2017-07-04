
X = [0 6] ;   
x = X(1);
	y = X(2);
    VarMinF=[0   0 ];          % Lower Bound of Variables
VarMaxF=[5   3 ];          % Upper Bound of Variables


varMin= VarMinF;          % Lower Bound of Variables
varMax= VarMaxF;          % Upper Bound of Variables

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
	         f2]