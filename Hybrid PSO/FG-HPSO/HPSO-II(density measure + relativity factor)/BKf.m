function z =BKf(X)
	x = X(1);
	y = X(2);
	f1 = 4*x^2 + 4*y^2;
	f2 = (x-5)^2 + (y-5)^2;
	z = [f1
	     f2];
end
