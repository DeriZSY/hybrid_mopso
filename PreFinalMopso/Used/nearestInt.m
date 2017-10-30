function z =nearestInt(x)
	z = floor(x);
	if x - z > 0.5
		z = x + 1;
	end
end
