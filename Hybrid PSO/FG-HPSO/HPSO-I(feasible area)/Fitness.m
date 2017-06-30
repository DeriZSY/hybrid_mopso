function z =Fitness(x)

	r   = x(1);
	R   = x(2);
	V   = x(3);
	Vr  = V *r/(R+r);
	VR  = V*R/(R+r);
	invPout  = -(VR^2) /R;
	Pin = (Vr^2)/r;
	z = [invPout
	Pin];
end 
