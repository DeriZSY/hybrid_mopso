function z =Fitness(x)
	r   = x(1);
	R   = x(2);
	V   = x(3);
	Vr  = V *r/(R+r);
	invVR  = -V *R/(R+r);
	z = [Vr
	invVR]
end 